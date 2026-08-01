import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class AppMapMarker {
  const AppMapMarker({
    required this.point,
    required this.child,
    this.width = 48,
    this.height = 48,
    this.onTap,
  });

  final LatLng point;
  final Widget child;
  final double width;
  final double height;
  final VoidCallback? onTap;
}
