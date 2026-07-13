import '../../../data/models/params/change_plan_status_param_model.dart';

class ChangePlanStatusParamEntity {
  final int planId;
  final bool isActive;
  final int reasonId;
  final String description;

  const ChangePlanStatusParamEntity({
    required this.planId,
    required this.isActive,
    required this.reasonId,
    required this.description,
  });

  ChangePlanStatusParamModel toModel() {
    return ChangePlanStatusParamModel(
      planId: planId,
      isActive: isActive,
      reasonId: reasonId,
      description: description,
    );
  }
}
