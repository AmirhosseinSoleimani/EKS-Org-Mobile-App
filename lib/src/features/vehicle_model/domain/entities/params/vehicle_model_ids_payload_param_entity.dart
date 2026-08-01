import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_ids_payload_request_model.dart';

class VehicleModelIdsPayloadParamEntity {
  const VehicleModelIdsPayloadParamEntity({
    required this.vehicleModelId,
    required this.ids,
    this.serviceCategoryId,
  });

  final int vehicleModelId;
  final int? serviceCategoryId;
  final List<int> ids;

  VehicleModelIdsPayloadRequestModel toServiceCategoriesModel() {
    return VehicleModelIdsPayloadRequestModel(
      vehicleModelId: vehicleModelId,
      emdadServiceCategoryIds: ids,
    );
  }

  VehicleModelIdsPayloadRequestModel toDefectsModel() {
    return VehicleModelIdsPayloadRequestModel(
      vehicleModelId: vehicleModelId,
      serviceCategoryId: serviceCategoryId,
      defectInfoIds: ids,
    );
  }
}
