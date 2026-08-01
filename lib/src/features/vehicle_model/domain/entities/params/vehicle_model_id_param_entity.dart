import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_id_request_model.dart';

class VehicleModelIdParamEntity {
  const VehicleModelIdParamEntity({required this.id});

  final int id;

  VehicleModelIdRequestModel toModel() {
    return VehicleModelIdRequestModel(id: id);
  }
}
