// Proveedor de Tiles con Caché Personalizado
import 'dart:typed_data';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class MyCachedTileProvider extends NetworkTileProvider {
  final CacheManager cacheManager;

  MyCachedTileProvider({required this.cacheManager});

  Future<Uint8List> loadTileBytes(String url) async {
    try {
      // Intentar obtener archivo de caché
      FileInfo? fileInfo = await cacheManager.getFileFromCache(url);

      if (fileInfo != null && fileInfo.file.existsSync()) {
        // Si está en caché, devolver bytes del archivo
        return await fileInfo.file.readAsBytes();
      }

      // Si no está en caché, descargar y guardar
      FileInfo newFileInfo = await cacheManager.downloadFile(url);
      return await newFileInfo.file.readAsBytes();
    } catch (e) {
      print('Error cargando tile: $e');

      // Fallback a descarga directa si hay problemas
      final response = await http.get(Uri.parse(url));
      return response.bodyBytes;
    }
  }
}
