import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';

class SpecialPlanProductModel extends SpecialPlanProductEntity {
  const SpecialPlanProductModel({
    required super.id,
    required super.title,
    super.code,
    super.serviceTypeTitle,
    super.allowedForSpecialPlanInfo,
    super.isActive,
  });

  factory SpecialPlanProductModel.fromJson(Map<String, dynamic> json) {
    return SpecialPlanProductModel(
      id: SpecialPlanJsonHelper.integer(json['id']) ?? 0,
      title: SpecialPlanJsonHelper.string(json['title']) ?? '',
      code: SpecialPlanJsonHelper.string(json['code']),
      serviceTypeTitle: SpecialPlanJsonHelper.string(
        json['serviceTypeTitle'],
      ),
      allowedForSpecialPlanInfo: SpecialPlanJsonHelper.boolean(
            json['allowedForSpecialPlanInfo'],
          ) ??
          false,
      isActive: SpecialPlanJsonHelper.boolean(json['isActive']) ?? true,
    );
  }
}
