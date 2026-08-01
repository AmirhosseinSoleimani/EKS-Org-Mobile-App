import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_form_request_model.dart';

class VehicleModelFormParamEntity {
  const VehicleModelFormParamEntity({
    this.id,
    required this.code,
    required this.name,
    required this.navganTypeId,
    required this.isActive,
    required this.hasDepot,
  });

  final int? id;
  final String code;
  final String name;
  final int navganTypeId;
  final bool isActive;
  final bool hasDepot;

  VehicleModelFormRequestModel toModel() {
    return VehicleModelFormRequestModel(
      id: id,
      code: code,
      name: name,
      navganTypeId: navganTypeId,
      isActive: isActive,
      hasDepot: hasDepot,
    );
  }
}
