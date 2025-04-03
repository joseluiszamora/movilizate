import 'package:flutter/material.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingDetailsSheet extends StatelessWidget {
  final Parking parking;

  const ParkingDetailsSheet({super.key, required this.parking});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(parking.name, style: Theme.of(context).textTheme.titleLarge),
          Text(parking.address),
          const SizedBox(height: 10),
          Text('Precio: Bs ${parking.pricePerHour}/hora'),
          Text('Espacios: ${parking.availableSpots}'),
          ElevatedButton(
            onPressed: () => _openInMaps(parking),
            child: const Text('Abrir en Maps'),
          ),
        ],
      ),
    );
  }

  void _openInMaps(Parking parking) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${parking.latitude},${parking.longitude}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
