import 'package:flutter/material.dart';
import 'package:movilizate/views/teleferico_map/models/station.dart';
import 'package:movilizate/views/teleferico_map/widgets/info_card_station.dart';
import 'package:url_launcher/url_launcher.dart';

class StationDetailScreen extends StatelessWidget {
  const StationDetailScreen({super.key, required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(station.name),
            background: Image.network(
              "https://adminweb.miteleferico.bo/uploads/NARANJA_009e523187.jpg",
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
        //https://ahoraelpueblo.bo/images/noticias/Sociedad/2024/08/Telef%C3%A9ricoPeat%C3%B3n29824.jpg
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
                        color: Station.colorFromHex(station.color),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Abierto',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),

                    const SizedBox(width: 4),
                    Text('(5)', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        station.adress,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _openInGoogleMaps(station);
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
                    InfoCardStation(
                      icon: Icons.attach_money,
                      title: 'Precio',
                      subtitle: 'Bs. ${station.code}/hora',
                      color: Colors.green,
                    ),
                    InfoCardStation(
                      icon: Icons.local_parking,
                      title: 'Espacios',
                      subtitle: '${station.idLine} disponibles',
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
                // Wrap(
                //   spacing: 8,
                //   runSpacing: 8,
                //   children:
                //       parking.services.map((service) {
                //         return Chip(
                //           label: Text(service),
                //           backgroundColor: Colors.blue.shade100,
                //         );
                //       }).toList(),
                // ),
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

  Future<void> _openInGoogleMaps(Station station) async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${station.latitude},${station.longitude}&travelmode=driving',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
