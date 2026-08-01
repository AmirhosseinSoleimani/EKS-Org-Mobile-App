import 'dart:ui';

import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/EmdadgarMapMarkerConfig.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/view_model/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';


class EmdadgarMarkerStyleResolver {
  const EmdadgarMarkerStyleResolver();

  MarkerStyle resolve(EmdadgarEntity emdadgar) {
    return _resolveByCodes(
      navganTypeCode: emdadgar.navganTypeCode,
      status: emdadgar.status,
      inVacation: emdadgar.inVacation,
      inShift: emdadgar.inShift,
    );
  }

  MarkerStyle resolveInfo(EmdadgarInfoEntity emdadgar) {
    return _resolveByCodes(
      navganTypeCode: emdadgar.navganTypeCode,
      status: emdadgar.status,
      inVacation: emdadgar.inVacation,
      inShift: emdadgar.inShift,
    );
  }

  MarkerStyle resolveCustomer() {
    return const MarkerStyle(
      iconPath: SvgManager.customerMarker,
    );
  }

  MarkerStyle _resolveByCodes({
    required int? navganTypeCode,
    required int? status,
    required bool? inVacation,
    required bool? inShift,
  }) {
    final iconPath =
        MapMarkerConfig.navganIcons[navganTypeCode] ??
            MapMarkerConfig.defaultIcon;

    final color =_resolveColor(
      status: status,
      inVacation: inVacation,
      inShift: inShift,
    );


    return MarkerStyle(
      iconPath: iconPath,
      color: color,
    );
  }

  Color _resolveColor({
    required int? status,
    required bool? inVacation,
    required bool? inShift,
  }) {
    if (inVacation == true) {
      return MapMarkerConfig.vacationColor;
    }

    if (inShift == false) {
      return MapMarkerConfig.outOfShiftColor;
    }

    return MapMarkerConfig.statusColors[status] ??
        MapMarkerConfig.defaultColor;
  }
}