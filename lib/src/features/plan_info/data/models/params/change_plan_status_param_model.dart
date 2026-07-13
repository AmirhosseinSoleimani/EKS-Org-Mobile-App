class ChangePlanStatusParamModel {
  final int planId;
  final bool isActive;
  final int reasonId;
  final String description;

  const ChangePlanStatusParamModel({
    required this.planId,
    required this.isActive,
    required this.reasonId,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'isActive': isActive,
      'reasonId': reasonId,
      'description': description,
    };
  }
}
