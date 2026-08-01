import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_control_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/non_caching_network_tile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AppMap extends StatelessWidget {
  const AppMap({
    super.key,
    required this.mapController,
    required this.serviceType,
    required this.initialCenter,
    this.initialZoom = 14,
    this.height,
    this.markers = const [],
    this.routePoints = const [],
    this.extraLayers = const [],
    this.interactive = true,
    this.showControls = true,
    this.showFullScreenButton = true,
    this.isFullScreen = false,
    this.onFullScreenTap,
    this.onCurrentLocationTap,
    this.onMapTap,
    this.onPositionChanged,
    this.bottomOverlay,
    this.fitPoints = const [],
    this.borderRadius = 25,
    this.routeStrokeWidth = 5,
  });

  final MapController mapController;
  final ServiceType serviceType;
  final LatLng initialCenter;
  final double initialZoom;
  final double? height;
  final List<AppMapMarker> markers;
  final List<LatLng> routePoints;
  final List<Widget> extraLayers;
  final List<LatLng> fitPoints;
  final bool interactive;
  final bool showControls;
  final bool showFullScreenButton;
  final bool isFullScreen;
  final VoidCallback? onFullScreenTap;
  final VoidCallback? onCurrentLocationTap;
  final ValueChanged<LatLng>? onMapTap;
  final void Function(MapCamera camera, bool hasGesture)? onPositionChanged;
  final Widget? bottomOverlay;
  final double borderRadius;
  final double routeStrokeWidth;

  @override
  Widget build(BuildContext context) {
    final map = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              keepAlive: true,
              initialCenter: initialCenter,
              initialZoom: initialZoom,
              initialCameraFit: fitPoints.length > 1
                  ? CameraFit.bounds(
                      bounds: LatLngBounds.fromPoints(fitPoints),
                      padding: const EdgeInsets.all(48),
                    )
                  : null,
              interactionOptions: InteractionOptions(
                flags: interactive
                    ? InteractiveFlag.drag |
                        InteractiveFlag.pinchZoom |
                        InteractiveFlag.doubleTapZoom |
                        InteractiveFlag.flingAnimation |
                        InteractiveFlag.scrollWheelZoom
                    : InteractiveFlag.none,
              ),
              onTap: onMapTap == null
                  ? null
                  : (_, point) => onMapTap?.call(point),
              onPositionChanged: onPositionChanged,
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.parsiMapUrlTemplate,
                keepBuffer: 2,
                tileProvider: NonCachingNetworkTileProvider(
                  urlTemplate: AppConstants.parsiMapUrlTemplate,
                ),
              ),
              ...extraLayers,
              if (routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints,
                      strokeWidth: routeStrokeWidth,
                      color: serviceType.serviceColor,
                      borderStrokeWidth: 2,
                      borderColor: Colors.white,
                    ),
                  ],
                ),
              if (markers.isNotEmpty)
                MarkerLayer(
                  markers: markers
                      .map(
                        (item) => Marker(
                          width: item.width,
                          height: item.height,
                          point: item.point,
                          child: item.onTap == null
                              ? item.child
                              : GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: item.onTap,
                                  child: item.child,
                                ),
                        ),
                      )
                      .toList(growable: false),
                ),
            ],
          ),
          if (showControls)
            MapControlButtons(
              mapController: mapController,
              defaultCenter: initialCenter,
              defaultZoom: initialZoom,
             // serviceColor: serviceType.serviceColor,
              isFullScreen: isFullScreen,
             // showFullScreenButton: showFullScreenButton,
              onFullScreenTap: onFullScreenTap?? (){},
              onCurrentLocationTap: onCurrentLocationTap,
            ),
          if (bottomOverlay != null) bottomOverlay!,
        ],
      ),
    );

    if (height != null) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: map,
      );
    }

    return SizedBox.expand(child: map);
  }
}
