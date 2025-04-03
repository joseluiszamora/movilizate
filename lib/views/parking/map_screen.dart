import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:movilizate/core/blocs/parking/parking_bloc.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:movilizate/views/maps/osm_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

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
        const Text("data Home"),
        Expanded(
          child: OsmMap(
            pointCenter: state.userPosition,
            markers: _buildParkingMarkers(state.parkings, context),
            onMapRefresh: () => _reloadParkings(context),
          ),
        ),
      ],
    );
    // return Stack(
    //   children: [
    //     Expanded(
    //       child: OsmMap(
    //         pointCenter: state.userPosition,
    //         markers: _buildParkingMarkers(state.parkings, context),
    //       ),
    //     ),
    // FlutterMap(
    //   options: MapOptions(
    //     initialCenter: state.userPosition,
    //     initialZoom: 15.0,
    //   ),
    //   children: [
    //     TileLayer(
    //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //       userAgentPackageName: 'com.example.app',
    //     ),
    //     MarkerLayer(markers: _buildParkingMarkers(state.parkings, context)),
    //     MarkerLayer(
    //       markers: [
    // Marker(
    //   point: state.userPosition,
    //   width: 40,
    //   height: 40,
    //   child: const Icon(
    //     Icons.person_pin_circle,
    //     color: Colors.red,
    //     size: 40,
    //   ),
    // ),
    //       ],
    //     ),
    //   ],
    // ),
    //   ],
    // );
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
          child: Icon(Icons.local_parking, color: Colors.blue, size: 40),
        ),
      );
    }).toList();
  }

  Widget _buildErrorUI(BuildContext context, String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_off, size: 50, color: Colors.red),
          const SizedBox(height: 20),
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _handlePermissionRetry(context),
            icon: const Icon(Icons.location_on),
            label: const Text('Intentar nuevamente'),
          ),
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text('Abrir configuración'),
          ),
        ],
      ),
    );
  }

  // --- Funciones de Acción ---

  void _showParkingDetails(BuildContext context, Parking parking) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(parking.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('📍 ${parking.address}'),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.attach_money, size: 20),
                  Text('Bs ${parking.pricePerHour.toStringAsFixed(2)} / hora'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.local_parking, size: 20),
                  Text('Espacios: ${parking.availableSpots}'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _openInGoogleMaps(parking),
                child: const Text('Cómo llegar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openInGoogleMaps(Parking parking) async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${parking.latitude},${parking.longitude}&travelmode=driving',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _reloadParkings(BuildContext context) {
    context.read<ParkingBloc>().add(const LoadParkings());
  }

  Future<void> _handlePermissionRetry(BuildContext context) async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      _reloadParkings(context);
    }
  }
}
