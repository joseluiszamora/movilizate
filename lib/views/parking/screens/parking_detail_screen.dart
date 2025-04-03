import 'package:flutter/material.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:movilizate/views/maps/osm_map.dart';
import 'package:movilizate/views/parking/components/info_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingDetailScreen extends StatelessWidget {
  const ParkingDetailScreen({super.key, required this.parking});

  final Parking parking;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(parking.name),
            background: Image.network(
              parking.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 50),
                  ),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: parking.isOpen ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        parking.isOpen ? 'Abierto' : 'Cerrado',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < parking.rating.floor()
                              ? Icons.star
                              : index < parking.rating
                              ? Icons.star_half
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${parking.rating})',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        parking.address,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _openInGoogleMaps(parking);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.directions, color: Colors.blue),
                          SizedBox(height: 10),
                          Text("Como llegar", textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoCard(
                      icon: Icons.attach_money,
                      title: 'Precio',
                      subtitle: 'Bs. ${parking.pricePerHour}/hora',
                      color: Colors.green,
                    ),
                    InfoCard(
                      icon: Icons.local_parking,
                      title: 'Espacios',
                      subtitle: '${parking.availableSpots} disponibles',
                      color: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Servicios',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      parking.services.map((service) {
                        return Chip(
                          label: Text(service),
                          backgroundColor: Colors.blue.shade100,
                        );
                      }).toList(),
                ),
                const SizedBox(height: 24),

                //* Muestra un minimapa, por el momento desactivado
                // showMiniMap(parking)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showMiniMap(Parking parking) => Column(
    children: [
      const Text(
        'Ubicación',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: OsmMap(
            pointCenter: parking.position,
            markers: [],
            onMapRefresh: () {},
          ),
        ),
      ),
    ],
  );

  Future<void> _openInGoogleMaps(Parking parking) async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${parking.latitude},${parking.longitude}&travelmode=driving',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
