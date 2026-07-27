import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/plan_history_param_entity.dart';

class PlanHistoryParamModel extends PlanHistoryParamEntity {
  const PlanHistoryParamModel({
    required super.refId,
    super.type = 11,
  });

  factory PlanHistoryParamModel.fromEntity(PlanHistoryParamEntity entity) {
    return PlanHistoryParamModel(
      refId: entity.refId,
      type: entity.type,
    );
  }

  @override
  Map<String, dynamic> toQueryParameters() => {
    'refId': refId,
    'type': type,
  };
}

extension PlanHistoryParamEntityX on PlanHistoryParamEntity {
  PlanHistoryParamModel toModel() {
    return PlanHistoryParamModel.fromEntity(this);
  }
}