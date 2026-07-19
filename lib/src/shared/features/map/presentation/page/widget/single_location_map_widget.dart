import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_control_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_pin_marker.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SingleLocationMapWidget extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final MarkerStyle markerStyle;

  final double height;
  final double initialZoom;
  final bool isFullScreen;

  final ValueChanged<LatLng>? onMapTap;

  final VoidCallback? onCurrentLocationTap;

  final VoidCallback? onMarkerTap;

  const SingleLocationMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.markerStyle,
    this.height = 520,
    this.initialZoom = 14,
    this.isFullScreen = false,
    this.onMapTap,
    this.onCurrentLocationTap,
    this.onMarkerTap,
  });

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

    final locationChanged =
        oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude;

    if (!locationChanged) {
      return;
    }

    final point = _locationPoint;

    if (point == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _mapController.move(point, _mapController.camera.zoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    final point = _locationPoint;

    if (point == null) {
      return _LocationMapEmptyState(height: widget.height);
    }

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: point,
                initialZoom: widget.initialZoom,
                interactionOptions: const InteractionOptions(
                  flags:
                      InteractiveFlag.drag |
                      InteractiveFlag.pinchZoom |
                      InteractiveFlag.doubleTapZoom |
                      InteractiveFlag.flingAnimation |
                      InteractiveFlag.scrollWheelZoom,
                ),
                onTap: widget.onMapTap == null
                    ? null
                    : (_, selectedPoint) {
                        widget.onMapTap?.call(selectedPoint);
                      },
              ),
              children: [_buildTileLayer(), _buildMarkerLayer(point)],
            ),

            MapControlButtons(
              mapController: _mapController,
              defaultCenter: point,
              defaultZoom: widget.initialZoom,
              isFullScreen: widget.isFullScreen,
              onFullScreenTap: () {
                _openFullScreenMap(context);
              },
              onCurrentLocationTap: () {
                _handleCurrentLocationTap(point);
              },
            ),
          ],
        ),
      ),
    );
  }

  TileLayer _buildTileLayer() {
    return TileLayer(
      urlTemplate: AppConstants.parsiMapUrlTemplate,
      tileProvider: NonCachingNetworkTileProvider(
        urlTemplate: AppConstants.parsiMapUrlTemplate,
      ),
    );
  }

  MarkerLayer _buildMarkerLayer(LatLng point) {
    return MarkerLayer(
      markers: [
        Marker(
          width: AppSize.s48,
          height: AppSize.s48,
          point: point,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onMarkerTap,
            child: MapPinMarker(
              iconPath: widget.markerStyle.iconPath,
              color: widget.markerStyle.color,
            ),
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

    if (point == null) {
      return;
    }

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
            initialZoom: _mapController.camera.zoom,
            height: MediaQuery.sizeOf(context).height,
            isFullScreen: true,
            onMapTap: widget.onMapTap,
            onMarkerTap: widget.onMarkerTap,
            onCurrentLocationTap: widget.onCurrentLocationTap,
          ),
        );
      },
    );
  }

  bool _isValidCoordinate(double? latitude, double? longitude) {
    if (latitude == null || longitude == null) {
      return false;
    }

    if (!latitude.isFinite || !longitude.isFinite) {
      return false;
    }

    final isLatitudeValid = latitude >= -90 && latitude <= 90;

    final isLongitudeValid = longitude >= -180 && longitude <= 180;

    return isLatitudeValid && isLongitudeValid;
  }
}

class _LocationMapEmptyState extends StatelessWidget {
  final double height;

  const _LocationMapEmptyState({required this.height});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      width: double.infinity,
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
            Text(
              'موقعیت مکانی ثبت نشده است',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
