import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/color_entity.dart';

class ColorModel extends ColorEntity {
  const ColorModel({super.colorId, super.colorName, super.colorCode});

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      colorId: json['colorId'],
      colorName: json['colorName'],
      colorCode: json['colorCode'],
    );
  }
  Map<String, dynamic> toJson() => {
    'colorId': colorId,
    'colorName': colorName,
    'colorCode': colorCode,
  };
}
