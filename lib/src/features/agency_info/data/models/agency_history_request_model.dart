class AgencyHistoryRequestModel {
  const AgencyHistoryRequestModel({
    this.refId,
    this.type,
  });

  final int? refId;
  final int? type;

  factory AgencyHistoryRequestModel.fromJson(Map<String, dynamic> json) {
    return AgencyHistoryRequestModel(
      refId: json['refId'] is int
          ? json['refId'] as int
          : int.tryParse(json['refId']?.toString() ?? ''),
      type: json['type'] is int
          ? json['type'] as int
          : int.tryParse(json['type']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refId': refId,
      'type': type,
    };
  }
}
