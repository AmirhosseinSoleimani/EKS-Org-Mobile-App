import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class NonCachingNetworkTileProvider extends TileProvider {
  NonCachingNetworkTileProvider({required this.urlTemplate});

  final String urlTemplate;

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    final url = urlTemplate
        .replaceAll('{x}', coordinates.x.toString())
        .replaceAll('{y}', coordinates.y.toString())
        .replaceAll('{z}', coordinates.z.toString());

    return NetworkImage(url);
  }
}
