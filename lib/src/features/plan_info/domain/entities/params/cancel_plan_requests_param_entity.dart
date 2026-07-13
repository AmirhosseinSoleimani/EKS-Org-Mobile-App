import '../../../data/models/params/cancel_plan_requests_param_model.dart';

class CancelPlanRequestsParamEntity {
  final int planId;
  final bool shouldCancel;

  const CancelPlanRequestsParamEntity({
    required this.planId,
    required this.shouldCancel,
  });

  CancelPlanRequestsParamModel toModel() {
    return CancelPlanRequestsParamModel(
      planId: planId,
      shouldCancel: shouldCancel,
    );
  }
}
