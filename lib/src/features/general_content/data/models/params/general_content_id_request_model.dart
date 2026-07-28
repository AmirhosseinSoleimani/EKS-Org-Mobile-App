class GeneralContentIdRequestModel {
  const GeneralContentIdRequestModel({required this.id});

  final int id;

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
