import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class MapControlButtons extends StatelessWidget {
  final MapController mapController;
  final lat_lng.LatLng defaultCenter;
  final double defaultZoom;
  final bool isFullScreen;
  final VoidCallback onFullScreenTap;
  final VoidCallback? onCurrentLocationTap;

  const MapControlButtons({
    super.key,
    required this.mapController,
    required this.defaultCenter,
    required this.defaultZoom,
    required this.isFullScreen,
    required this.onFullScreenTap,
    this.onCurrentLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 16,
      end: 16,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:  Colors.white.withAlpha(200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            CircleMapButton(
              icon: Icons.add,
              onTap: () {
                final camera = mapController.camera;
                mapController.move(camera.center, camera.zoom + 1);
              },
            ),
            const SizedBox(height: 12),
            CircleMapButton(
              icon: Icons.remove,
              onTap: () {
                final camera = mapController.camera;
                mapController.move(camera.center, camera.zoom - 1);
              },
            ),
            const SizedBox(height: 12),
            CircleMapButton(
              icon: isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
              onTap: isFullScreen ? context.pop : onFullScreenTap,
            ),
            const SizedBox(height: 12),
            CircleMapButton(
              icon: Icons.my_location,
              onTap:
                  onCurrentLocationTap ??
                  () {
                    mapController.move(defaultCenter, defaultZoom);
                  },
            ),
          ],
        ),
      ),
    );
  }
}

class CircleMapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const CircleMapButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: AppSize.s40,
          height: AppSize.s40,
          child: Icon(icon, color: const Color(0xff6C35D4), size: 24),
        ),
      ),
    );
  }
}
