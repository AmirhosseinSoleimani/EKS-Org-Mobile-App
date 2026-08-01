class VehicleModelIdRequestModel {
  const VehicleModelIdRequestModel({required this.id});

  final int id;

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
