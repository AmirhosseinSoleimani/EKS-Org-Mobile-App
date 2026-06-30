import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bullet_point/bullet_point.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/filter_widgets/interfaces/dropdown_item.dart';

enum ServiceType implements DropdownItem {
  reliefService(1, 'خدمات امدادی', ColorLightManager.primary, Icons.car_repair),
  homeService(2, 'خدمت در محل', ColorLightManager.secondary, Icons.home_repair_service)/*,
  saleProduct(5, 'فروش تجاری', ColorDarkManager.purple)*/;


  final Color serviceColor;
  final IconData icon;

  const ServiceType(this.value, this.label, this.serviceColor, this.icon);


  @override
  final String label;

  @override
  final int value;

  @override
  Widget leading(BuildContext context) {
    return BulletPoint(color: serviceColor);
  }


  static ServiceType fromValue(int? value) {
    return ServiceType.values.firstWhere(
          (e) => e.value == value,
      orElse: () => ServiceType.reliefService,
    );
  }
}