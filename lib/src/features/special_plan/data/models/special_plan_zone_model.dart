import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_zone_entity.dart';

class SpecialPlanZoneModel extends SpecialPlanZoneEntity {
  const SpecialPlanZoneModel({
    super.id,
    super.title,
    super.provinceTitle,
    super.cityTitle,
  });

  factory SpecialPlanZoneModel.fromJson(Map<String, dynamic> json) {
    return SpecialPlanZoneModel(
      id: SpecialPlanJsonHelper.integer(json['id']),
      title: SpecialPlanJsonHelper.string(
        json['title'] ?? json['areaTitle'] ?? json['zoneTitle'],
      ),
      provinceTitle: SpecialPlanJsonHelper.string(
        json['provinceTitle'] ?? json['areaProvinceTitle'],
      ),
      cityTitle: SpecialPlanJsonHelper.string(
        json['cityTitle'] ?? json['areaCityTitle'],
      ),
    );
  }
}
