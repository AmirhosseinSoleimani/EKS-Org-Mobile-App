class AgencyIdRequestModel {
  const AgencyIdRequestModel({this.id});

  final int? id;

  factory AgencyIdRequestModel.fromJson(Map<String, dynamic> json) {
    return AgencyIdRequestModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
