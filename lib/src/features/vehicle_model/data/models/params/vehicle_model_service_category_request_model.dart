class VehicleModelServiceCategoryRequestModel {
  const VehicleModelServiceCategoryRequestModel({
    required this.vehicleModelId,
    required this.serviceCategoryId,
  });

  final int vehicleModelId;
  final int serviceCategoryId;

  Map<String, dynamic> toJson() {
    return {
      'vehicleModelId': vehicleModelId,
      'serviceCategoryId': serviceCategoryId,
    };
  }
}
