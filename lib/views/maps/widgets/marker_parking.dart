import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:movilizate/core/models/parking.dart';

class MarkerParking {
  Marker makeMarker(
    Parking parking,
    double baseSize,
    Function(Parking parking) onTap,
  ) {
    // Determinar color según disponibilidad
    final Color markerColor;
    if (!parking.isOpen) {
      markerColor = Colors.red;
    } else if (parking.availableSpots < 5) {
      markerColor = Colors.orange;
    } else {
      markerColor = Colors.green;
    }

    // Determinar tamaño final con variación
    final markerSize = baseSize * (parking.isNear ? 1.2 : 1.0);

    return Marker(
      point: parking.position,
      width: markerSize,
      height: markerSize,
      child: GestureDetector(
        onTap: () => onTap(parking),
        child: Container(
          decoration: BoxDecoration(
            color: markerColor.withValues(alpha: 0.8),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.local_parking,
              color: Colors.white,
              size: markerSize * 0.6,
            ),
          ),
        ),
      ),
    );
  }
}
