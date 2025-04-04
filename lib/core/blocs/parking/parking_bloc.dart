import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:movilizate/core/models/filter_options.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'parking_event.dart';
part 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final SupabaseClient _supabase = Supabase.instance.client;
  // final Geolocator _geolocator = Geolocator();
  Timer? _updateTimer;

  List<Parking> _loadedParkings = [];
  FilterOptions? _lastAppliedFilters;

  ParkingBloc() : super(ParkingLoading()) {
    on<LoadParkings>(_onLoadParkings);
    on<StartPeriodicUpdates>(_onStartPeriodicUpdates);
    on<StopPeriodicUpdates>(_onStopPeriodicUpdates);
    on<LoadParkingDetails>(_onLoadParkingDetails);
    on<FilterParkings>(_onFilterParkings);
  }

  Future<void> _onLoadParkings(
    LoadParkings event,
    Emitter<ParkingState> emit,
  ) async {
    try {
      // Obtener ubicación del usuario
      Position userPosition = await _getUserLocation();

      // Obtener parqueos de Supabase
      final parkings = await _fetchParkings(userPosition);

      // Calcular distancias y marcar cercanos
      for (var parking in parkings) {
        double distance = _calculateDistance(
          userPosition.latitude,
          userPosition.longitude,
          parking.latitude,
          parking.longitude,
        );
        parking.isNear = distance <= 500; // 500 metros como radio cercano
      }
      emit(
        ParkingLoaded(
          userPosition: LatLng(userPosition.latitude, userPosition.longitude),
          parkings: parkings,
        ),
      );
    } catch (e) {
      emit(ParkingError(e.toString()));
    }
  }

  void _onStartPeriodicUpdates(
    StartPeriodicUpdates event,
    Emitter<ParkingState> emit,
  ) {
    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(const LoadParkings());
    });
  }

  void _onStopPeriodicUpdates(
    StopPeriodicUpdates event,
    Emitter<ParkingState> emit,
  ) {
    _updateTimer?.cancel();
  }

  Future<void> _onLoadParkingDetails(
    LoadParkingDetails event,
    Emitter<ParkingState> emit,
  ) async {
    emit(ParkingLoading());
    try {
      final parking = await _supabase
          .from('parkings')
          .select('*')
          .eq('id', event.parkingId)
          .single()
          .then((response) => Parking.fromJson(response));

      emit(ParkingDetailLoaded(parking));
    } catch (e) {
      emit(ParkingError('Failed to load parking details'));
    }
  }

  void _onFilterParkings(
    FilterParkings event,
    Emitter<ParkingState> emit,
  ) async {
    // Obtener ubicación del usuario
    Position userPosition = await _getUserLocation();

    _lastAppliedFilters = event.filterOptions;
    // final filteredParkings = _applyFilters(
    //   _loadedParkings,
    //   event.filterOptions,
    // );

    final filteredParkings = await getFilteredParkings(userLat: userPosition.latitude, userLng: userPosition.longitude, filters: event.filterOptions)

    emit(
      ParkingLoaded(
        userPosition: LatLng(userPosition.latitude, userPosition.longitude),
        parkings: filteredParkings,
      ),
    );
  }

  Future<Position> _getUserLocation() async {
    final status = await Permission.location.request();

    if (status.isDenied) {
      throw Exception('Permiso de ubicación denegado por el usuario');
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      throw Exception(
        'Permiso denegado permanentemente. Actívalo en Configuración',
      );
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }

  Future<List<Parking>> _fetchParkings(Position userPosition) async {
    final response = await _supabase.from('parking').select('*');

    return (response as List).map((json) => Parking.fromJson(json)).toList();
  }

  Future<List<Parking>> getFilteredParkings({
    required double userLat,
    required double userLng,
    required FilterOptions filters,
    // double? maxPrice,
    // int? minAvailableSpots,
    // double? maxDistance, // en metros
    // List<String>? services,
    // double? minRating,
  }) async {
    // Consulta base
    var query = _supabase.from('parking').select('*');

    // Filtro por precio máximo
    if (filters.maxPrice != null) {
      query = query.lte('price_per_hour', filters.maxPrice);
    }

    // Filtro por espacios disponibles mínimos
    if (filters.minAvailableSpots != null) {
      query = query.gte('available_spots', filters.minAvailableSpots);
    }

    // Filtro por servicios (array contiene)
    // if (filters.services != null && filters.services.isNotEmpty) {
    //   query = query.contains('services', filters.services);
    // }

    // Filtro por rating mínimo
    if (filters.minRating != null) {
      query = query.gte('average_rating', filters.minRating);
    }

    // Ejecutamos la consulta inicial
    final response = await query;

    // if (response.isEmpty != null) {
    //   throw Exception('Error fetching parkings: ${response.error!.message}');
    // }

    // Convertimos a objetos Parking
    List<Parking> parkings =
        (response as List).map((json) => Parking.fromJson(json)).toList();

    // Filtro por distancia (post-query porque necesita cálculo)
    if (filters.maxDistance != null) {
      parkings =
          parkings.where((parking) {
            final distance = _calculateDistance(
              userLat,
              userLng,
              parking.latitude,
              parking.longitude,
            );
            return distance <= filters.maxDistance;
          }).toList();
    }

    return parkings;
  }

  // Función para calcular distancia entre coordenadas
  double _calculateDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    const Distance distance = Distance();
    return distance(LatLng(lat1, lng1), LatLng(lat2, lng2));
  }

  // List<Parking> _applyFilters(List<Parking> parkings, FilterOptions filters) {
  //   return parkings.where((parking) {
  //     // Filtrar por precio
  //     if (parking.pricePerHour > filters.maxPrice) {
  //       return false;
  //     }

  //     // Filtrar por espacios disponibles
  //     if (parking.availableSpots < filters.minAvailableSpots) {
  //       return false;
  //     }

  //     // Filtrar por calificación
  //     if (parking.rating < filters.minRating) {
  //       return false;
  //     }

  //     // Filtrar por servicios
  //     if (filters.services.isNotEmpty) {
  //       // Verificar si todos los servicios seleccionados están en el parqueo
  //       final hasAllSelectedServices = filters.services.every(
  //         (service) => parking.services.contains(service),
  //       );
  //       if (!hasAllSelectedServices) {
  //         return false;
  //       }
  //     }

  //     return true;
  //   }).toList();
  // }

  @override
  Future<void> close() {
    _updateTimer?.cancel();
    return super.close();
  }
}
