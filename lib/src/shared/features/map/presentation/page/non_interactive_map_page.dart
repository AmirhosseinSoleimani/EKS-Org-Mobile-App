import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class NonInteractiveMapPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  final double zoom;
  final ServiceType? type;

  const NonInteractiveMapPage({
    super.key,
    required this.latitude,
    required this.longitude,
    this.zoom = 16.0,
    this.type,
  });

  @override
  State<NonInteractiveMapPage> createState() => _NonInteractiveMapPageState();
}

class _NonInteractiveMapPageState extends State<NonInteractiveMapPage> {

  late final MapController _mapController;
  late final lat_lng.LatLng _latLng;
  static const double _markerSize = AppSize.s48;

  @override
  void initState() {
    _mapController = MapController();
    _latLng = lat_lng.LatLng(widget.latitude, widget.longitude);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: IgnorePointer(
        ignoring: true,
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _latLng,
            initialZoom: widget.zoom,
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
              keepBuffer: 1,
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: _markerSize,
                  height: _markerSize,
                  point: _latLng,
                  child: SvgWidget(
                    src: SvgAsset((widget.type == ServiceType.homeService) ? SvgManager.homeServiceLocation : SvgManager.location),
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