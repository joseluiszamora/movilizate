import 'package:flutter/material.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingDetailView extends StatelessWidget {
  final Parking parking;

  const ParkingDetailView({super.key, required this.parking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Cabecera con imagen y botón de regreso
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Imagen de fondo
                  Image.network(
                    parking.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
                  ),
                  // Gradiente para mejorar visibilidad del texto
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                parking.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              // Botón para compartir
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Implementar función para compartir
                },
              ),
            ],
          ),

          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tarjeta con información principal
                  _buildInfoCard(context),

                  const SizedBox(height: 20),

                  // Servicios disponibles
                  const Text(
                    'Servicios Disponibles',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildServicesList(),

                  const SizedBox(height: 20),

                  // Horarios
                  _buildScheduleInfo(),

                  const SizedBox(height: 20),

                  // Ubicación y botón para navegar
                  _buildLocationSection(context),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Fila superior con dirección y calificación
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    parking.address,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${parking.rating}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 24),

            // Estadísticas principales
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Precio',
                  '${parking.pricePerHour.toStringAsFixed(0)} Bs/hora',
                  Icons.attach_money,
                ),
                _buildStatItem(
                  'Distancia',
                  '${parking.distance.toStringAsFixed(2)} km',
                  Icons.route,
                ),
                _buildStatItem(
                  'Espacios',
                  '${parking.availableSpots}/${parking.totalSpots}',
                  Icons.confirmation_number,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[600], size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildServicesList() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: parking.services.length,
        itemBuilder: (context, index) {
          final service = parking.services[index];
          IconData icon;
          switch (service.toLowerCase()) {
            case 'baño':
              icon = Icons.wc;
              break;
            case 'cámaras de seguridad':
              icon = Icons.videocam;
              break;
            case 'vigilancia':
              icon = Icons.security;
              break;
            case 'luz':
              icon = Icons.lightbulb;
              break;
            case 'agua':
              icon = Icons.water_drop;
              break;
            case 'wifi':
              icon = Icons.wifi;
              break;
            default:
              icon = Icons.check_circle;
          }

          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.amber, size: 28),
                ),
                const SizedBox(height: 5),
                Text(
                  service,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horario',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: parking.isOpen ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                parking.isOpen ? 'Abierto' : 'Cerrado',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Lun - Dom: 6:00 - 22:00', // Placeholder - esto vendría de datos reales
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ubicación',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey[300],
            child: Stack(
              children: [
                // Aquí iría un mapa estático o un mapa interactivo pequeño
                Center(
                  child: Icon(Icons.map, size: 50, color: Colors.grey[400]),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black.withOpacity(0.6),
                    child: Text(
                      'Lat: ${parking.latitude.toStringAsFixed(4)}, Lng: ${parking.longitude.toStringAsFixed(4)}',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _openGoogleMaps(parking),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.directions),
                label: const Text(
                  'Cómo llegar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openGoogleMaps(Parking parking) async {
    final url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${parking.latitude},${parking.longitude}&travelmode=driving',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Si no se puede abrir Google Maps
      print('No se pudo abrir Google Maps');
    }
  }
}
