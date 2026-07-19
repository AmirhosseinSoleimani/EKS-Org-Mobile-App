class DeleteAgencyRequestModel {
  const DeleteAgencyRequestModel({required this.id});

  final int id;

  factory DeleteAgencyRequestModel.fromJson(Map<String, dynamic> json) {
    return DeleteAgencyRequestModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toQueryParameters() {
    return {'id': id};
  }
}
