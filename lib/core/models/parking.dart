import 'package:latlong2/latlong.dart';

class Parking {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double distance;
  final int totalSpots;
  final int availableSpots;
  final double pricePerHour;
  final String imageUrl;
  final bool isOpen;
  final List<String> services;
  final double rating;
  bool isNear;

  Parking({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.totalSpots,
    required this.availableSpots,
    required this.pricePerHour,
    required this.imageUrl,
    required this.isOpen,
    required this.services,
    required this.rating,
    required this.isNear,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      distance: json['distance']?.toDouble() ?? 0.0,
      totalSpots: json['totalSpots'],
      availableSpots: json['availableSpots'],
      pricePerHour: json['pricePerHour'].toDouble(),
      imageUrl: json['imageUrl'],
      isOpen: json['isOpen'],
      // services: List<String>.from(json['services']),
      services: [
        'Baño',
        'Cámaras de seguridad',
        'Vigilancia',
        'Luz',
        'Agua',
        'WiFi',
      ],
      rating: json['rating'].toDouble(),
      isNear: false,
    );
  }

  LatLng get position => LatLng(latitude, longitude);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'totalSpots': totalSpots,
      'availableSpots': availableSpots,
      'pricePerHour': pricePerHour,
      'imageUrl': imageUrl,
      'isOpen': isOpen,
      'services': services,
      'rating': rating,
      // 'isNear': isNear,
    };
  }
}
