import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:movilizate/core/blocs/parking/parking_bloc.dart';
import 'package:movilizate/core/models/filter_options.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:movilizate/views/maps/osm_map.dart';
import 'package:movilizate/views/parking/screens/error_ui_screen.dart';
import 'package:movilizate/views/parking/screens/filter_screen.dart';
import 'package:movilizate/views/parking/screens/parking_detail_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingBloc, ParkingState>(
      listener: (context, state) {
        if (state is ParkingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is ParkingLoaded) {
          return _buildMapWithParkings(context, state);
        } else if (state is ParkingError) {
          return _buildErrorUI(context, state.message);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // --- Widgets Privados ---

  Widget _buildMapWithParkings(BuildContext context, ParkingLoaded state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("data Home"),
            //* Opcion para filtrar mapas
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                _showFilterScreen(context);
              },
            ),
          ],
        ),
        Expanded(
          child: OsmMap(
            pointCenter: state.userPosition,
            markers: _buildParkingMarkers(state.parkings, context),
            onMapRefresh: () => _reloadParkings(context),
          ),
        ),
      ],
    );
  }

  List<Marker> _buildParkingMarkers(
    List<Parking> parkings,
    BuildContext context,
  ) {
    return parkings.map((parking) {
      return Marker(
        point: parking.position,
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _showParkingDetails(context, parking),
          // child: Icon(Icons.local_parking, color: Colors.blue, size: 40),
        ),
      );
    }).toList();
  }

  Widget _buildErrorUI(BuildContext context, String errorMessage) {
    return ErrorUiScreen(
      errorMessage: errorMessage,
      reloadParkings: () {
        _reloadParkings(context);
      },
    );
  }

  // --- Funciones de Acción ---

  void _showParkingDetails(BuildContext context, Parking parking) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ParkingDetailScreen(parking: parking);
      },
    );
  }

  void _showFilterScreen(BuildContext context) {
    FilterOptions filterOptions = FilterOptions(
      maxPrice: 10.0,
      minAvailableSpots: 0,
      maxDistance: 1.0,
      services: [],
      minRating: 0.0,
    );
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterScreen(initialFilters: filterOptions);
      },
    );
  }

  void _reloadParkings(BuildContext context) {
    context.read<ParkingBloc>().add(const LoadParkings());
  }
}
