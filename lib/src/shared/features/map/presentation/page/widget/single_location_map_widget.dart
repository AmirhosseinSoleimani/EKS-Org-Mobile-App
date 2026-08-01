import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_pin_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/view_model/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SingleLocationMapWidget extends StatefulWidget {
  const SingleLocationMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.markerStyle,
    required this.serviceType,
    this.height = 520,
    this.initialZoom = 14,
    this.isFullScreen = false,
    this.interactive = true,
    this.showFullScreenButton = true,
    this.onMapTap,
    this.onCurrentLocationTap,
    this.onMarkerTap,
  });

  final double? latitude;
  final double? longitude;
  final MarkerStyle markerStyle;
  final ServiceType serviceType;
  final double? height;
  final double initialZoom;
  final bool isFullScreen;
  final bool interactive;
  final bool showFullScreenButton;
  final ValueChanged<LatLng>? onMapTap;
  final VoidCallback? onCurrentLocationTap;
  final VoidCallback? onMarkerTap;

  @override
  State<SingleLocationMapWidget> createState() =>
      _SingleLocationMapWidgetState();
}

class _SingleLocationMapWidgetState extends State<SingleLocationMapWidget> {
  final MapController _mapController = MapController();

  LatLng? get _locationPoint {
    final latitude = widget.latitude;
    final longitude = widget.longitude;

    if (!_isValidCoordinate(latitude, longitude)) {
      return null;
    }

    return LatLng(latitude!, longitude!);
  }

  @override
  void didUpdateWidget(covariant SingleLocationMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    final locationChanged = oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude;
    final point = _locationPoint;

    if (!locationChanged || point == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _mapController.move(point, _mapController.camera.zoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    final point = _locationPoint;

    if (point == null) {
      return _LocationMapEmptyState(height: widget.height);
    }

    return AppMap(
      mapController: _mapController,
      serviceType: widget.serviceType,
      initialCenter: point,
      initialZoom: widget.initialZoom,
      height: widget.height,
      interactive: widget.interactive,
      showFullScreenButton: widget.showFullScreenButton,
      isFullScreen: widget.isFullScreen,
      onMapTap: widget.onMapTap,
      onCurrentLocationTap: () => _handleCurrentLocationTap(point),
      onFullScreenTap: () => _openFullScreenMap(context),
      markers: [
        AppMapMarker(
          point: point,
          width: AppSize.s48,
          height: AppSize.s48,
          onTap: widget.onMarkerTap,
          child: MapPinMarker(
            iconPath: widget.markerStyle.iconPath,
            color: widget.markerStyle.color,
          ),
        ),
      ],
    );
  }

  void _handleCurrentLocationTap(LatLng point) {
    if (widget.onCurrentLocationTap != null) {
      widget.onCurrentLocationTap?.call();
      return;
    }

    _mapController.move(point, widget.initialZoom);
  }

  void _openFullScreenMap(BuildContext context) {
    final point = _locationPoint;
    if (point == null) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: SingleLocationMapWidget(
            latitude: point.latitude,
            longitude: point.longitude,
            markerStyle: widget.markerStyle,
            serviceType: widget.serviceType,
            initialZoom: _mapController.camera.zoom,
            height: MediaQuery.sizeOf(context).height,
            isFullScreen: true,
            interactive: widget.interactive,
            showFullScreenButton: widget.showFullScreenButton,
            onMapTap: widget.onMapTap,
            onMarkerTap: widget.onMarkerTap,
            onCurrentLocationTap: widget.onCurrentLocationTap,
          ),
        );
      },
    );
  }

  bool _isValidCoordinate(double? latitude, double? longitude) {
    if (latitude == null || longitude == null) return false;
    if (!latitude.isFinite || !longitude.isFinite) return false;

    return latitude >= -90 &&
        latitude <= 90 &&
        longitude >= -180 &&
        longitude <= 180;
  }
}

class _LocationMapEmptyState extends StatelessWidget {
  const _LocationMapEmptyState({required this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final child = DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_off_outlined,
              size: AppSize.s48,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSize.s12),
            BodyMediumText(
              text: 'موقعیت مکانی ثبت نشده است',
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );

    if (height != null) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: child,
      );
    }

    return SizedBox.expand(child: child);
  }
}
