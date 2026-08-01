import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_pin_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/view_model/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/route_info_box.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteMapWidget extends StatefulWidget {
  const RouteMapWidget({
    super.key,
    required this.routeData,
    required this.startMarkerStyle,
    required this.destinationMarkerStyle,
    required this.serviceType,
    this.height = 520,
    this.initialZoom = 14,
    this.showInfoBox = true,
    this.isFullScreen = false,
  });

  final RouteDataEntity routeData;
  final MarkerStyle startMarkerStyle;
  final MarkerStyle destinationMarkerStyle;
  final ServiceType serviceType;
  final double? height;
  final double initialZoom;
  final bool showInfoBox;
  final bool isFullScreen;

  @override
  State<RouteMapWidget> createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final route = _mainRoute;
    if (route == null) {
      return _RouteMapEmptyState(
        height: widget.height,
        serviceType: widget.serviceType,
      );
    }

    final routePoints = _extractRoutePoints(route);
    if (routePoints.isEmpty) {
      return _RouteMapEmptyState(
        height: widget.height,
        serviceType: widget.serviceType,
      );
    }

    final startPoint = _toLatLng(route.start);
    final destinationPoint = _toLatLng(route.destination);

    return AppMap(
      mapController: _mapController,
      serviceType: widget.serviceType,
      initialCenter: startPoint,
      initialZoom: widget.initialZoom,
      height: widget.height,
      routePoints: routePoints,
      fitPoints: routePoints,
      markers: [
        AppMapMarker(
          point: startPoint,
          width: AppSize.s48,
          height: AppSize.s48,
          child: MapPinMarker(
            iconPath: widget.startMarkerStyle.iconPath,
            color: widget.startMarkerStyle.color,
          ),
        ),
        AppMapMarker(
          point: destinationPoint,
          width: AppSize.s42,
          height: AppSize.s42,
          child: MapPinMarker(
            iconPath: widget.destinationMarkerStyle.iconPath,
            color: widget.destinationMarkerStyle.color,
          ),
        ),
      ],
      isFullScreen: widget.isFullScreen,
      onFullScreenTap: () => _openFullScreenMap(context),
      onCurrentLocationTap: () => _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(routePoints),
          padding: const EdgeInsets.all(48),
        ),
      ),
      bottomOverlay: widget.showInfoBox
          ? PositionedDirectional(
              start: AppPadding.p16,
              end: AppPadding.p16,
              bottom: AppPadding.p16,
              child: RouteInfoBox(route: route),
            )
          : null,
    );
  }

  RouteEntity? get _mainRoute {
    if (widget.routeData.routes.isEmpty) return null;
    return widget.routeData.routes.first;
  }

  List<LatLng> _extractRoutePoints(RouteEntity route) {
    return route.legs
        .expand((leg) => leg.steps)
        .expand((step) => step.points)
        .where((point) => point.length >= 2)
        .map((point) => LatLng(point[0], point[1]))
        .toList(growable: false);
  }

  LatLng _toLatLng(LocationEntity location) {
    return LatLng(location.latitude, location.longitude);
  }

  void _openFullScreenMap(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: RouteMapWidget(
            routeData: widget.routeData,
            startMarkerStyle: widget.startMarkerStyle,
            destinationMarkerStyle: widget.destinationMarkerStyle,
            serviceType: widget.serviceType,
            initialZoom: _mapController.camera.zoom,
            height: MediaQuery.sizeOf(context).height,
            showInfoBox: widget.showInfoBox,
            isFullScreen: true,
          ),
        );
      },
    );
  }
}

class _RouteMapEmptyState extends StatelessWidget {
  const _RouteMapEmptyState({
    required this.height,
    required this.serviceType,
  });

  final double? height;
  final ServiceType serviceType;

  @override
  Widget build(BuildContext context) {
    final content = DecoratedBox(
      decoration: BoxDecoration(
        color: serviceType.serviceColor.withAlpha(18),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: BodyMediumText(
          text: 'مسیر قابل نمایش نیست',
          color: serviceType.serviceColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (height != null) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: content,
      );
    }

    return SizedBox.expand(child: content);
  }
}
