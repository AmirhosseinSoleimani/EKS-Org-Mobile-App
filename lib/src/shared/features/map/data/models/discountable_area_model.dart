import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/discountable_area_entity.dart';

class DiscountableAreaModel extends DiscountableAreaEntity {
  const DiscountableAreaModel({
    required super.id,
    required super.areaTitle,
    super.areaCityTitle,
    super.areaProvinceTitle,
  });

  factory DiscountableAreaModel.fromJson(Map<String, dynamic> json) {
    return DiscountableAreaModel(
      id: _integer(json['id']) ?? 0,
      areaTitle: json['areaTitle']?.toString().trim() ?? '',
      areaCityTitle: json['areaCityTitle']?.toString().trim(),
      areaProvinceTitle: json['areaProvinceTitle']?.toString().trim(),
    );
  }

  static int? _integer(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}
