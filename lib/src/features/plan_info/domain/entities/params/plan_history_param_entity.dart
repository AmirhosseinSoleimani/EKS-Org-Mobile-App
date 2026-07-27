class PlanHistoryParamEntity {
  const PlanHistoryParamEntity({
    required this.refId,
    this.type = 11,
  });

  final int refId;
  final int type;

  Map<String, dynamic> toQueryParameters() => {
    'refId': refId,
    'type': type,
  };
}