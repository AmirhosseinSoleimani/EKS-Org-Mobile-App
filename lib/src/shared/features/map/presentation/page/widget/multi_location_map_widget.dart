import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/core/app_map_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MultiLocationMapWidget extends StatefulWidget {
  const MultiLocationMapWidget({
    super.key,
    required this.markers,
    required this.initialCenter,
    required this.serviceType,
    this.height = 520,
    this.initialZoom = 12,
    this.isFullScreen = false,
    this.interactive = true,
    this.showFullScreenButton = true,
    this.fitMarkers = false,
    this.onCurrentLocationTap,
    this.onFullScreenTap,
    this.bottomOverlay,
  });

  final List<AppMapMarker> markers;
  final LatLng initialCenter;
  final ServiceType serviceType;
  final double? height;
  final double initialZoom;
  final bool isFullScreen;
  final bool interactive;
  final bool showFullScreenButton;
  final bool fitMarkers;
  final VoidCallback? onCurrentLocationTap;
  final VoidCallback? onFullScreenTap;
  final Widget? bottomOverlay;

  @override
  State<MultiLocationMapWidget> createState() =>
      _MultiLocationMapWidgetState();
}

class _MultiLocationMapWidgetState extends State<MultiLocationMapWidget> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return AppMap(
      mapController: _mapController,
      serviceType: widget.serviceType,
      initialCenter: widget.initialCenter,
      initialZoom: widget.initialZoom,
      height: widget.height,
      markers: widget.markers,
      fitPoints: widget.fitMarkers
          ? widget.markers.map((marker) => marker.point).toList(growable: false)
          : const [],
      interactive: widget.interactive,
      showFullScreenButton: widget.showFullScreenButton,
      isFullScreen: widget.isFullScreen,
      onCurrentLocationTap: widget.onCurrentLocationTap ??
          () => _mapController.move(
                widget.initialCenter,
                widget.initialZoom,
              ),
      onFullScreenTap: widget.onFullScreenTap ?? () => _openFullScreenMap(context),
      bottomOverlay: widget.bottomOverlay,
    );
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
          child: MultiLocationMapWidget(
            markers: widget.markers,
            initialCenter: widget.initialCenter,
            serviceType: widget.serviceType,
            initialZoom: _mapController.camera.zoom,
            height: MediaQuery.sizeOf(context).height,
            isFullScreen: true,
            interactive: widget.interactive,
            showFullScreenButton: widget.showFullScreenButton,
            fitMarkers: widget.fitMarkers,
            onCurrentLocationTap: widget.onCurrentLocationTap,
            onFullScreenTap: widget.onFullScreenTap,
            bottomOverlay: widget.bottomOverlay,
          ),
        );
      },
    );
  }
}
