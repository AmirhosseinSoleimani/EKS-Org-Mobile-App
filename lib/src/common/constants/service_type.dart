import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:flutter/material.dart';

enum ServiceType {
  reliefService(1, 'خدمات امدادی', ColorLightManager.primary),
  homeService(2, 'خدمت در محل', ColorLightManager.secondary)/*,
  saleProduct(5, 'فروش تجاری', ColorDarkManager.purple)*/;

  final int value;
  final String label;
  final Color serviceColor;

  const ServiceType(this.value, this.label, this.serviceColor);

  static ServiceType fromValue(int? value) {
    if (value == null) return ServiceType.reliefService;
    return ServiceType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ServiceType.reliefService,
    );
  }
}