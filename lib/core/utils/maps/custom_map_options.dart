import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movilizate/core/utils/maps/cached_tiles_provider.dart';
import 'package:path_provider/path_provider.dart';

class CustomMapOptions {
  MapOptions customMapOptions(LatLng initialCenter) {
    return MapOptions(
      initialCenter: initialCenter,
      initialZoom: 12.0,
      minZoom: 3,
      maxZoom: 18,
      // Callback para eventos de mapa
      onMapEvent: (mapEvent) {
        // Puedes manejar eventos como zoom, movimiento, etc.
        // print('Evento de mapa: ${mapEvent.camera.center}');
      },
    );
  }

  TileLayer tileLayerOptions(CacheManager mapCacheManager) {
    return TileLayer(
      urlTemplate:
          "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
      subdomains: const ['a', 'b', 'c', 'd'],
      maxZoom: 18,
      // Usar proveedor de tiles personalizado, para mejorar la velocidad
      tileProvider: MyCachedTileProvider(cacheManager: mapCacheManager),
      // Mejora de rendimiento
      keepBuffer: 5,
    );
  }

  Future<CacheManager> initializeCacheManager() async {
    // Obtener directorio temporal de manera segura
    final tempDir = await getTemporaryDirectory();

    // Crear el CacheManager
    CacheManager mapCacheManager = CacheManager(
      Config(
        'map_tiles_cache',
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 200,
        fileSystem: IOFileSystem(tempDir.path),
      ),
    );

    // Actualizar estado cuando se complete la inicialización
    return mapCacheManager;
  }
}
