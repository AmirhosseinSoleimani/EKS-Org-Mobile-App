import 'package:eks_sana_plus_org/src/shared/features/user/data/models/color_model.dart';
import 'package:flutter/material.dart';

@immutable
class ColorEntity {
  const ColorEntity({
    this.colorId,
    this.colorName,
    this.colorCode,
  });

  final int? colorId;
  final String? colorName;
  final String? colorCode;

  ColorModel toModel() {
    return ColorModel(
      colorId: colorId,
      colorName: colorName,
      colorCode: colorCode,
    );
  }
}
