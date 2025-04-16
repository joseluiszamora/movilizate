import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movilizate/core/utils/maps/custom_map_options.dart';
import 'package:movilizate/views/maps/widgets/map_actions_buttons.dart';
import 'package:movilizate/views/maps/widgets/ripple_user_marker.dart';
import 'package:movilizate/views/teleferico_map/map/marker_station.dart';
import 'package:movilizate/views/teleferico_map/models/station.dart';

class MtOsmMap extends StatefulWidget {
  const MtOsmMap({
    super.key,
    required this.pointCenter,
    required this.markers,
    required this.onMapRefresh,
    required this.onMarkerTap,
  });

  final LatLng pointCenter;
  final List<Station> markers;
  final Function() onMapRefresh;
  final Function(Station) onMarkerTap;

  @override
  State<MtOsmMap> createState() => _MtOsmMapState();
}

class _MtOsmMapState extends State<MtOsmMap> {
  late CacheManager _mapCacheManager;
  late MapController _mapController;
  double _currentZoom = 15.0;
  bool _isLoadingMap = true;

  @override
  void initState() {
    super.initState();
    _initializeCacheManager();
    _mapController = MapController();
    _mapController.mapEventStream.listen((event) {
      if (event is MapEventMoveEnd) {
        setState(() {
          _currentZoom = event.camera.zoom;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _mapCacheManager.dispose();
    _mapController.dispose();
  }

  _initializeCacheManager() async {
    CacheManager mapCacheTmp =
        await CustomMapOptions().initializeCacheManager();

    setState(() {
      _mapCacheManager = mapCacheTmp;
      _isLoadingMap = false;
    });
  }

  //* Método para construir marcadores dinámicos
  List<Marker> _buildDynamicMarkers(List<Station> stations, double zoom) {
    // Ajustamos el tamaño base según el nivel de zoom
    final baseSize = 30.0 + (zoom - 10.0); // Aumenta tamaño con zoom

    final List<Marker> markers = [];
    // Agregamos el marcador de usuario
    markers.add(
      Marker(
        rotate: true,
        point: widget.pointCenter,
        width: 60.0, // Tamaño suficiente para la animación
        height: 60.0,
        child: RippleUserMarker(color: Colors.blueAccent, size: 50.0),
        // child: PulsatingUserMarker(color: Colors.blueAccent, size: 50.0),
      ),
    );

    // Agregamos los marcadores de parqueos
    for (var station in stations) {
      markers.add(
        MarkerStation().makeMarker(station, baseSize, (station) {
          widget.onMarkerTap(station);
        }),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingMap) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        // opciones del mapa
        options: MapOptions(
          initialCenter: widget.pointCenter,
          initialZoom: _currentZoom,
          onPositionChanged: (position, hasGesture) {
            if (hasGesture) {
              setState(() {
                _currentZoom = position.zoom;
              });
            }
          },
        ),
        // options: CustomMapOptions().customMapOptions(widget.pointCenter),
        children: [
          // Capa personalizada del mapa
          CustomMapOptions().tileLayerOptions(_mapCacheManager),

          // Agregar marcadores
          // MarkerLayer(markers: widget.markers..add(mapUserPosition())),
          MarkerLayer(
            rotate: true,
            markers: _buildDynamicMarkers(widget.markers, _currentZoom),
          ),
        ],
      ),
      floatingActionButton: MapActionButtons(
        onCenterLocation: () {
          _mapController.move(widget.pointCenter, _mapController.camera.zoom);
        },
        onRefresh: () => widget.onMapRefresh,
        onZoomIn: () {
          _mapController.move(
            _mapController.camera.center,
            _mapController.camera.zoom + 1,
          );
        },
        onZoomOut: () {
          _mapController.move(
            _mapController.camera.center,
            _mapController.camera.zoom - 1,
          );
        },
        isDarkMode: false,
        // isDarkMode: Theme.of(context).brightness == Brightness.dark,
      ),
    );
  }
}
