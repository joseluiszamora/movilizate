import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movilizate/core/blocs/parking/parking_bloc.dart';
import 'package:movilizate/core/models/filter_options.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:movilizate/views/maps/osm_map.dart';
import 'package:movilizate/views/parking/screens/error_ui_screen.dart';
import 'package:movilizate/views/parking/screens/filter_screen.dart';
import 'package:movilizate/views/parking/screens/parking_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ParkingBloc>().add(const StartPeriodicUpdates());
    });
  }

  @override
  void dispose() {
    context.read<ParkingBloc>().add(const StopPeriodicUpdates());
    super.dispose();
  }

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
            markers: state.parkings,
            onMapRefresh: () => _reloadParkings(context),
            onMarkerTap: (parking) => _showParkingDetails(context, parking),
          ),
        ),
      ],
    );
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

  void _showParkingDetails(BuildContext context, Parking parking) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ParkingDetailScreen(parking: parking);
      },
    );
  }

  void _reloadParkings(BuildContext context) {
    context.read<ParkingBloc>().add(const LoadParkings());
  }
}
