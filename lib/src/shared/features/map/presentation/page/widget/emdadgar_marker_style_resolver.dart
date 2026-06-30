import 'dart:ui';

import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/EmdadgarMapMarkerConfig.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';


class EmdadgarMarkerStyleResolver {
  const EmdadgarMarkerStyleResolver();

  MarkerStyle resolve(EmdadgarEntity emdadgar) {
    return _resolveByCodes(
      navganTypeCode: emdadgar.navganTypeCode,
      status: emdadgar.status,
    );
  }

  MarkerStyle resolveInfo(EmdadgarInfoEntity emdadgar) {
    return _resolveByCodes(
      navganTypeCode: emdadgar.navganTypeCode,
      status: emdadgar.status,
    );
  }

  MarkerStyle resolveCustomer() {
    return const MarkerStyle(
      iconPath: SvgManager.customerMarker,
      color: Color(0xff6C35D4),
    );
  }

  MarkerStyle _resolveByCodes({
    required int? navganTypeCode,
    required int? status,
  }) {
    final iconPath =
        MapMarkerConfig.navganIcons[navganTypeCode] ??
            MapMarkerConfig.defaultIcon;

    final color =
        MapMarkerConfig.statusColors[status] ??
            MapMarkerConfig.defaultColor;

    return MarkerStyle(
      iconPath: iconPath,
      color: color,
    );
  }
}