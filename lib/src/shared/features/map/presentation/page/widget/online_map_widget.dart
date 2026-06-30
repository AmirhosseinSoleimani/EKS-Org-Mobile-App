import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OnlineMapWidget extends StatelessWidget {
  final RouteDataEntity mapData;
  final double emdadgarLat;
  final double emdadgarLng;
  final double destLat;
  final double destLng;

  const OnlineMapWidget({
    super.key,
    required this.mapData,
    required this.emdadgarLat,
    required this.emdadgarLng,
    required this.destLat,
    required this.destLng,
  });

  List<LatLng> _buildPolyline() {
    final points = <LatLng>[];

    if (mapData.routes.isNotEmpty) {
      final route = mapData.routes.first;

      for (final leg in route.legs) {
        for (final step in leg.steps) {
          for (final p in step.points) {
            if (p.length == 2) {
              points.add(LatLng(p[0], p[1]));
            }
          }
        }
      }
    }

    return points;
  }

  @override
  Widget build(BuildContext context) {
    final polylinePoints = _buildPolyline();
    final hasPoints = polylinePoints.isNotEmpty;

    final center =
        hasPoints ? polylinePoints.first : LatLng(emdadgarLat, emdadgarLng);

    return FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: 14.0,
      ),
      children: [
        TileLayer(
          urlTemplate: AppConstants.parsiMapUrlTemplate,
          tileProvider: NonCachingNetworkTileProvider(
            urlTemplate: AppConstants.parsiMapUrlTemplate,
          ),
          keepBuffer: 1,
        ),
        if (hasPoints)
          PolylineLayer(
            polylines: [
              Polyline(
                points: polylinePoints,
                strokeWidth: 5,
                color: Colors.blue.shade700,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(emdadgarLat, emdadgarLng),
              width: 40,
              height: 40,
              child: const Icon(
                Icons.local_shipping,
                color: Colors.red,
                size: 32,
              ),
            ),
            Marker(
              point: LatLng(destLat, destLng),
              width: 40,
              height: 40,
              child: const Icon(
                Icons.location_on,
                color: Colors.green,
                size: 36,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
