class VehicleHistoryParamEntity {
  const VehicleHistoryParamEntity({
    required this.refId,
    this.type = 2,
  });

  final int refId;
  final int type;

  Map<String, dynamic> toQueryParameters() => {
        'refId': refId,
        'type': type,
      };
}
