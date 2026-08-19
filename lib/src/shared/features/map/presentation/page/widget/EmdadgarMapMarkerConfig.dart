import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class MapMarkerConfig {
  static const Color customerColor = Color(0xff6C35D4);
  static const Color readyColor = Color(0xff22C55E);
  static const Color allocatedColor = Color(0xffF59E0B);
  static const Color vacationColor = Color(0xffEF4444);
  static const Color outOfShiftColor = Color(0xff9CA3AF);
  static const Color defaultColor = readyColor;


  static const String customerIcon = ImageManager.customerMarker;
  static const String defaultEmdadgarIcon = ImageManager.onMissionEmpty;


  static const String defaultIcon = SvgManager.jarsaghil;

  static const Map<int, String> navganIcons = {
    1: SvgManager.jarsaghil,
    2: SvgManager.charkhgir,
    3: SvgManager.motor,
    4: SvgManager.savari,
    5: SvgManager.khodroSavar,
    6: SvgManager.peymankarKhodroSavar,
    7: SvgManager.peymankarCharkhgir,
    8: SvgManager.dakaldarKhodroSavar,
    9: SvgManager.peymankarDakaldar,
  };

  static const Map<int, Color> statusColors = {
    1: readyColor,
    2: allocatedColor,
  };
}
