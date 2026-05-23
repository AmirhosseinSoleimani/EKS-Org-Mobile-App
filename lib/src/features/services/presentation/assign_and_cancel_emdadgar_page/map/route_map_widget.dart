import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/emdadgar_marker_style_resolver.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/map_control_buttons.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/map_pin_marker.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/marker_style.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/route_info_box.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/route_map_empty_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class RouteMapWidget extends StatelessWidget {
  final RouteDataEntity routeData;
  final MarkerStyle startMarkerStyle;
  final MarkerStyle destinationMarkerStyle;
  final double height;
  final double initialZoom;
  final bool showInfoBox;
  final bool isFullScreen;

  RouteMapWidget({
    super.key,
    required this.routeData,
    required this.startMarkerStyle,
    required this.destinationMarkerStyle,
    this.height = 520,
    this.initialZoom = 14,
    this.showInfoBox = true,
    this.isFullScreen = false,
  });

  final MapController _mapController = MapController();

  static const Color _routeColor = Color(0xff2563EB);

  @override
  Widget build(BuildContext context) {
    final route = _getMainRoute();

    if (route == null) {
      return const RouteMapEmptyState();
    }

    final routePoints = _extractRoutePoints(route);

    if (routePoints.isEmpty) {
      return const RouteMapEmptyState();
    }

    final startPoint = _toLatLng(route.start);
    final destinationPoint = _toLatLng(route.destination);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: startPoint,
                initialZoom: initialZoom,
                initialCameraFit: CameraFit.bounds(
                  bounds: LatLngBounds.fromPoints(routePoints),
                  padding: const EdgeInsets.all(48),
                ),
                interactionOptions: const InteractionOptions(
                  flags:
                      InteractiveFlag.drag |
                      InteractiveFlag.pinchZoom |
                      InteractiveFlag.doubleTapZoom |
                      InteractiveFlag.flingAnimation |
                      InteractiveFlag.scrollWheelZoom,
                ),
              ),
              children: [
                _buildTileLayer(),
                _buildRoutePolyline(routePoints),
                _buildMarkers(
                  startPoint: startPoint,
                  destinationPoint: destinationPoint,
                  startMarkerStyle: startMarkerStyle,
                  destinationMarkerStyle: destinationMarkerStyle,
                ),
              ],
            ),

            MapControlButtons(
              mapController: _mapController,
              defaultCenter: startPoint,
              defaultZoom: initialZoom,
              isFullScreen: isFullScreen,
              onFullScreenTap: () => _openFullScreenMap(context),
            ),

            if (showInfoBox)
              PositionedDirectional(
                start: 16,
                end: 16,
                bottom: 16,
                child: RouteInfoBox(route: route),
              ),
          ],
        ),
      ),
    );
  }

  RouteEntity? _getMainRoute() {
    if (routeData.routes.isEmpty) return null;
    return routeData.routes.first;
  }

  List<lat_lng.LatLng> _extractRoutePoints(RouteEntity route) {
    return route.legs
        .expand((leg) => leg.steps)
        .expand((step) => step.points)
        .where((point) => point.length >= 2)
        .map((point) => lat_lng.LatLng(point[0], point[1]))
        .toList();
  }

  lat_lng.LatLng _toLatLng(LocationEntity location) {
    return lat_lng.LatLng(location.latitude, location.longitude);
  }

  TileLayer _buildTileLayer() {
    return TileLayer(
      urlTemplate: AppConstants.parsiMapUrlTemplate,
      tileProvider: NonCachingNetworkTileProvider(
        urlTemplate: AppConstants.parsiMapUrlTemplate,
      ),
    );
  }

  PolylineLayer _buildRoutePolyline(List<lat_lng.LatLng> points) {
    return PolylineLayer(
      polylines: [
        Polyline(
          points: points,
          strokeWidth: 5,
          color: _routeColor,
          borderStrokeWidth: 2,
          borderColor: Colors.white,
        ),
      ],
    );
  }

  MarkerLayer _buildMarkers({
    required lat_lng.LatLng startPoint,
    required lat_lng.LatLng destinationPoint,
    required MarkerStyle startMarkerStyle,
    required MarkerStyle destinationMarkerStyle,
  }) {
    return MarkerLayer(
      markers: [
        Marker(
          width: AppSize.s48,
          height: AppSize.s48,
          point: startPoint,
          child: MapPinMarker(
            iconPath: startMarkerStyle.iconPath,
            color: startMarkerStyle.color,
          ),
        ),
        Marker(
          width: AppSize.s42,
          height: AppSize.s42,
          point: destinationPoint,
          child: MapPinMarker(
            iconPath: destinationMarkerStyle.iconPath,
            color: destinationMarkerStyle.color,
          ),
        ),
      ],
    );
  }

  void _openFullScreenMap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: RouteMapWidget(
            routeData: routeData,
            startMarkerStyle: startMarkerStyle,
            destinationMarkerStyle: destinationMarkerStyle,
            initialZoom: _mapController.camera.zoom,
            height: MediaQuery.of(context).size.height,
            showInfoBox: showInfoBox,
            isFullScreen: true,
          ),
        );
      },
    );
  }
}
