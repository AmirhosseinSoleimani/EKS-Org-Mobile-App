import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_service_category_request_model.dart';

class VehicleModelServiceCategoryParamEntity {
  const VehicleModelServiceCategoryParamEntity({
    required this.vehicleModelId,
    required this.serviceCategoryId,
  });

  final int vehicleModelId;
  final int serviceCategoryId;

  VehicleModelServiceCategoryRequestModel toModel() {
    return VehicleModelServiceCategoryRequestModel(
      vehicleModelId: vehicleModelId,
      serviceCategoryId: serviceCategoryId,
    );
  }
}
