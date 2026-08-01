class VehicleModelIdsPayloadRequestModel {
  const VehicleModelIdsPayloadRequestModel({
    required this.vehicleModelId,
    this.serviceCategoryId,
    this.emdadServiceCategoryIds,
    this.defectInfoIds,
  });

  final int vehicleModelId;
  final int? serviceCategoryId;
  final List<int>? emdadServiceCategoryIds;
  final List<int>? defectInfoIds;

  Map<String, dynamic> toServiceCategoriesJson() {
    return {
      'vehicleModelId': vehicleModelId,
      'emdadServiceCategoryIds': emdadServiceCategoryIds ?? const [],
    };
  }

  Map<String, dynamic> toDefectsJson() {
    return {
      'vehicleModelId': vehicleModelId,
      'serviceCategoryId': serviceCategoryId,
      'defectInfoIds': defectInfoIds ?? const [],
    };
  }
}
