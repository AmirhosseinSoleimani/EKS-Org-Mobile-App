import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_page_entity.dart';

class SpecialPlanPageModel extends SpecialPlanPageEntity {
  const SpecialPlanPageModel({
    super.records,
    super.count,
  });

  factory SpecialPlanPageModel.fromResponse(dynamic response) {
    final rawRecords = SpecialPlanJsonHelper.records(response);
    final records = rawRecords
        .whereType<Map>()
        .map(
          (item) => SpecialPlanModel.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList(growable: false);
    return SpecialPlanPageModel(
      records: records,
      count: SpecialPlanJsonHelper.count(response, records.length),
    );
  }
}
