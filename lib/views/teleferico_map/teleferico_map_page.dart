import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:movilizate/views/teleferico_map/map/mt_osm_map.dart';
import 'package:movilizate/views/teleferico_map/models/line.dart';
import 'package:movilizate/views/teleferico_map/models/station.dart';
import 'package:movilizate/views/teleferico_map/views/station_detail_screen.dart';

class TelefericoMapPage extends StatelessWidget {
  const TelefericoMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Station> stations = [];

    for (var line in Line.allLines) {
      stations.addAll(line.stations);
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Estaciones"),
            //* Opcion para filtrar mapas
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                // _showFilterScreen(context);
              },
            ),
          ],
        ),
        Expanded(
          child: MtOsmMap(
            pointCenter: LatLng(-16.522547866401833, -68.16939430723444),
            markers: stations,
            onMapRefresh: () {},
            onMarkerTap: (station) => _showStationDetails(context, station),
          ),
        ),
      ],
    );
  }

  void _showStationDetails(BuildContext context, Station station) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StationDetailScreen(station: station);
      },
    );
  }
}
