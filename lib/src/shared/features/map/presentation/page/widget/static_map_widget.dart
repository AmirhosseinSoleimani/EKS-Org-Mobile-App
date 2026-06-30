import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

import 'map_widget.dart';

class StaticMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final double zoom;
  final ServiceType serviceType;

  const StaticMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    this.zoom = 16.0,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    final latLng = lat_lng.LatLng(latitude, longitude);
    final mapController = MapController();

    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: latLng,
            initialZoom: zoom,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.none,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: AppConstants.parsiMapUrlTemplate,
              tileProvider: NonCachingNetworkTileProvider(
                urlTemplate: AppConstants.parsiMapUrlTemplate,
              ),
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: AppSize.s42,
                  height: AppSize.s42,
                  point: latLng,
                  child: SvgWidget(
                    src: SvgAsset(
                        (serviceType == ServiceType.homeService) ? SvgManager
                            .homeServiceLocation : SvgManager.location),
                    width: AppSize.s60,
                    height: AppSize.s60,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}