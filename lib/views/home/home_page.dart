import 'package:flutter/material.dart';
import 'package:movilizate/core/models/parking.dart';
import 'package:movilizate/views/home/components/search_bar.dart';
import 'package:movilizate/views/home/components/parking_section.dart';
import 'package:movilizate/views/home/components/nearby_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView(
            children: [
              // Texto principal clickeable usando GestureDetector
              Text(
                "Encontremos lo mejor\ncerca de ti",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 20),

              // Barra de búsqueda clickeable (envolvemos todo el componente)
              const HomeSearchBar(),

              const SizedBox(height: 25),

              // Sección de mejores estacionamientos
              ParkingSection(
                title: 'Parqueos Cercanos',
                parkingSpots: [
                  Parking(
                    id: 101,
                    name: 'Elia Garder Parking',
                    address: 'Ivory Elephant street',
                    pricePerHour: 6,
                    rating: 4.4,
                    latitude: 0.0,
                    longitude: 0.0,
                    distance: 1.24,
                    imageUrl: 'assets/images/parking1.jpg',
                    totalSpots: 10,
                    availableSpots: 5,
                    isOpen: false,
                    isNear: false,
                    services: [],
                  ),
                  Parking(
                    id: 102,
                    name: 'Mall Gozilas Parking',
                    address: 'Ivory Elephant street',
                    pricePerHour: 6,
                    rating: 4.4,
                    latitude: 0.0,
                    longitude: 0.0,
                    distance: 1.24,
                    imageUrl: 'assets/images/parking1.jpg',
                    totalSpots: 10,
                    availableSpots: 5,
                    isOpen: false,
                    isNear: false,
                    services: [],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Sección de estacionamientos cercanos
              NearbySection(
                title: 'Nearby You',
                nearbySpots: [
                  Parking(
                    id: 102,
                    name: 'Mall Gozilas Parking',
                    address: 'Ivory Elephant street',
                    pricePerHour: 6,
                    rating: 4.4,
                    latitude: 0.0,
                    longitude: 0.0,
                    distance: 1.24,
                    imageUrl: 'assets/images/parking1.jpg',
                    totalSpots: 10,
                    availableSpots: 5,
                    isOpen: false,
                    isNear: false,
                    services: [],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
