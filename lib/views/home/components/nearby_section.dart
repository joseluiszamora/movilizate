import 'package:flutter/material.dart';
import 'package:movilizate/core/models/parking.dart';

class NearbySection extends StatelessWidget {
  final String title;
  final List<Parking> nearbySpots;

  const NearbySection({
    super.key,
    required this.title,
    required this.nearbySpots,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Encabezado de sección
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {
                // Acción cuando se presiona "See All"
              },
              child: const Text(
                'See All',
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

        // Lista vertical de spots cercanos
        Column(
          children:
              nearbySpots
                  .map((spot) => NearbyParkingCard(parkingInfo: spot))
                  .toList(),
        ),
      ],
    );
  }
}

class NearbyParkingCard extends StatelessWidget {
  final Parking parkingInfo;

  const NearbyParkingCard({super.key, required this.parkingInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              parkingInfo.imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    height: 80,
                    width: 80,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
            ),
          ),

          const SizedBox(width: 12),

          // Detalles del parking
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre del parking
                Text(
                  parkingInfo.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // Dirección
                Text(
                  parkingInfo.address,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),

                const SizedBox(height: 8),

                // Precio y rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Precio
                    Row(
                      children: [
                        Text(
                          '\$${parkingInfo.pricePerHour.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "/Hora",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${parkingInfo.rating}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Distancia
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.circle, color: Colors.amber, size: 10),
              const SizedBox(height: 4),
              Text(
                '${parkingInfo.distance.toStringAsFixed(2)}km',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
