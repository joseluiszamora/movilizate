import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movilizate/core/utils/maps/custom_map_options.dart';

class OsmMap extends StatefulWidget {
  const OsmMap({
    super.key,
    required this.pointCenter,
    required this.markers,
    required this.onMapRefresh,
  });

  final LatLng pointCenter;
  final List<Marker> markers;
  final Function() onMapRefresh;

  @override
  State<OsmMap> createState() => _OsmMapState();
}

class _OsmMapState extends State<OsmMap> {
  late CacheManager _mapCacheManager;
  late MapController _mapController;
  bool _isLoadingMap = true;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initializeCacheManager();
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

  @override
  Widget build(BuildContext context) {
    if (_isLoadingMap) {
      return const Center(child: CircularProgressIndicator());
    }

    mapUserPosition() => Marker(
      point: widget.pointCenter,
      width: 40,
      height: 40,
      child: const Icon(Icons.person_pin_circle, color: Colors.red, size: 40),
    );

    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        // opciones del mapa
        options: CustomMapOptions().customMapOptions(widget.pointCenter),
        children: [
          // Capa personalizada del mapa
          CustomMapOptions().tileLayerOptions(_mapCacheManager),

          // Agregar marcadores
          MarkerLayer(markers: widget.markers..add(mapUserPosition())),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //* Botón Center
          FloatingActionButton(
            heroTag: 'center',
            onPressed: () {
              // _mapController.animate(
              //   widget.pointCenter,
              //   zoom: 15.0,
              //   duration: const Duration(milliseconds: 500),
              // );
              _mapController.move(
                widget.pointCenter,
                _mapController.camera.zoom,
              );
            },
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 10),
          //* Botón refresh
          FloatingActionButton(
            heroTag: 'refresh',
            onPressed: widget.onMapRefresh,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          //* Botón zoom +
          FloatingActionButton(
            heroTag: 'zoomIn',
            child: const Icon(Icons.add),
            onPressed: () {
              _mapController.move(
                _mapController.camera.center,
                _mapController.camera.zoom + 1,
              );
            },
          ),
          const SizedBox(height: 10),

          //* Botón zoom +
          FloatingActionButton(
            heroTag: 'zoomOut',
            child: const Icon(Icons.remove),
            onPressed: () {
              // Disminuir zoom
              _mapController.move(
                _mapController.camera.center,
                _mapController.camera.zoom - 1,
              );
            },
          ),
        ],
      ),
    );
  }
}
