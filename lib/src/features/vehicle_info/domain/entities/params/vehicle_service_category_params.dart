class SubmitVehicleServiceCategoriesParamEntity {
  const SubmitVehicleServiceCategoriesParamEntity({
    required this.vehicleInfoId,
    required this.emdadServiceCategoryIds,
  });

  final int vehicleInfoId;
  final List<int> emdadServiceCategoryIds;

  Map<String, dynamic> toJson() => {
        'vehicleInfoId': vehicleInfoId,
        'emdadServiceCateogries': emdadServiceCategoryIds,
      };
}

class InsertBatchVehicleServiceCategoriesParamEntity {
  const InsertBatchVehicleServiceCategoriesParamEntity({
    required this.vehicleId,
    required this.emdadServiceCategoryIds,
  });

  final int vehicleId;
  final List<int> emdadServiceCategoryIds;

  Map<String, dynamic> toJson() => {
        'vehicleId': vehicleId,
        'emdadServiceCategoryIds': emdadServiceCategoryIds,
      };
}

class GetVehicleDefectsParamEntity {
  const GetVehicleDefectsParamEntity({
    required this.vehicleInfoId,
    required this.emdadServiceCategoryId,
  });

  final int vehicleInfoId;
  final int emdadServiceCategoryId;

  Map<String, dynamic> toJson() => {
        'vehicleInfoId': vehicleInfoId,
        'emdadServiceCategoryId': emdadServiceCategoryId,
      };
}

class SubmitVehicleDefectLimitationParamEntity {
  const SubmitVehicleDefectLimitationParamEntity({
    required this.vehicleId,
    required this.serviceCategoryId,
    required this.defectInfoIds,
  });

  final int vehicleId;
  final int serviceCategoryId;
  final List<int> defectInfoIds;

  Map<String, dynamic> toJson() => {
        'vehicleId': vehicleId,
        'serviceCategoryId': serviceCategoryId,
        'defectInfoIds': defectInfoIds,
      };
}
