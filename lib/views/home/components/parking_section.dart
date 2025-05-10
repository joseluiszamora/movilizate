import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movilizate/core/blocs/parking/parking_bloc.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:movilizate/views/parking/screens/parking_detail_view.dart';

class ParkingSection extends StatefulWidget {
  final String title;
  final List<Parking>? parkingSpots; // Hacemos opcional este parámetro

  const ParkingSection({super.key, required this.title, this.parkingSpots});

  @override
  State<ParkingSection> createState() => _ParkingSectionState();
}

class _ParkingSectionState extends State<ParkingSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ParkingBloc>().add(const LoadParkings());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Encabezado de sección
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {
                // Acción cuando se presiona "Ver mas"
              },
              child: const Text(
                'Ver mas',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.amber,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Lista horizontal de parkings cargados desde el bloc
        SizedBox(
          height: 200,
          child: BlocBuilder<ParkingBloc, ParkingState>(
            builder: (context, state) {
              if (state is ParkingLoaded) {
                final parkings = state.parkings;

                if (parkings.isEmpty) {
                  return const Center(
                    child: Text('No hay parqueaderos disponibles'),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: parkings.length,
                  itemBuilder: (context, index) {
                    return ParkingCard(parkingInfo: parkings[index]);
                  },
                );
              }

              // Si tenemos datos de respaldo, los usamos mientras carga
              if (widget.parkingSpots != null &&
                  widget.parkingSpots!.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.parkingSpots!.length,
                  itemBuilder: (context, index) {
                    return ParkingCard(
                      parkingInfo: widget.parkingSpots![index],
                    );
                  },
                );
              }

              // Si no tenemos datos, mostramos un indicador de carga
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}

class ParkingCard extends StatelessWidget {
  final Parking parkingInfo;

  const ParkingCard({super.key, required this.parkingInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParkingDetailView(parking: parkingInfo),
          ),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen y rating
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    parkingInfo.imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 110,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${parkingInfo.rating}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Nombre del parking
            Text(
              parkingInfo.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Dirección
            Text(
              parkingInfo.address,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),

            const SizedBox(height: 6),

            // Precio y distancia
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Precio
                Row(
                  children: [
                    Text(
                      'Bs ${parkingInfo.pricePerHour.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '/Hora',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),

                // Distancia
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.amber, size: 10),
                    const SizedBox(width: 4),
                    Text(
                      '${parkingInfo.distance.toStringAsFixed(2)}km',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
