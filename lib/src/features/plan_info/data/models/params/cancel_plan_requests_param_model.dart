class CancelPlanRequestsParamModel {
  final int planId;
  final bool shouldCancel;

  const CancelPlanRequestsParamModel({
    required this.planId,
    required this.shouldCancel,
  });

  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'shouldCancel': shouldCancel,
    };
  }
}
