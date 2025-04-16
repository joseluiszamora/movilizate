import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:movilizate/views/teleferico_map/models/station.dart';

class MarkerStation {
  Marker makeMarker(
    Station station,
    double baseSize,
    Function(Station station) onTap,
  ) {
    // Determinar color según disponibilidad
    final Color markerColor = Station.colorFromHex(station.color);

    // Determinar tamaño final con variación
    // final markerSize = baseSize * (parking.isNear ? 1.2 : 1.0);
    final markerSize = baseSize * 1.0;

    return Marker(
      // rotate: true,
      point: LatLng(station.latitude, station.longitude),
      width: markerSize,
      height: markerSize,
      child: GestureDetector(
        onTap: () => onTap(station),
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
