import 'dart:ui';

import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/EmdadgarMapMarkerConfig.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/map/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';

class EmdadgarMarkerStyleResolver {
  const EmdadgarMarkerStyleResolver();

  MarkerStyle resolve(EmdadgarEntity emdadgar) {
    final iconPath =
        MapMarkerConfig.navganIcons[emdadgar.navganTypeCode] ??
        MapMarkerConfig.defaultIcon;

    final color =
        MapMarkerConfig.statusColors[emdadgar.status] ??
        MapMarkerConfig.defaultColor;

    return MarkerStyle(iconPath: iconPath, color: color);
  }

  MarkerStyle resolveCustomer() {
    return const MarkerStyle(
      iconPath: ImageManager.customerMarker,
      color: Color(0xff6C35D4),
    );
  }
}
