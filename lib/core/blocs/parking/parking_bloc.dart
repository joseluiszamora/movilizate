import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'parking_event.dart';
part 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final SupabaseClient _supabase = Supabase.instance.client;
  final Geolocator _geolocator = Geolocator();

  ParkingBloc() : super(ParkingLoading()) {
    on<LoadParkings>(_onLoadParkings);
  }

  Future<void> _onLoadParkings(
    LoadParkings event,
    Emitter<ParkingState> emit,
  ) async {
    try {
      // Obtener ubicación del usuario
      Position userPosition = await _getUserLocation();

      // Obtener parqueos de Supabase
      final response = await _supabase.from('parking').select('*');

      List<Parking> parkings =
          (response as List).map((json) => Parking.fromJson(json)).toList();

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

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const Distance distance = Distance();
    return distance(LatLng(lat1, lon1), LatLng(lat2, lon2));
  }
}
