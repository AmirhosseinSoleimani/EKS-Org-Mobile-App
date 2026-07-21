import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_info_location_param_entity.dart';

class ChangePlanInfoLocationParamModel
    extends ChangePlanInfoLocationParamEntity {
  const ChangePlanInfoLocationParamModel({
    required super.planId,
    required super.emdadUnitId,
    required super.locationId,
    required super.latitude,
    required super.longitude,
    required super.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'emdadUnitId': emdadUnitId,
      'locationId': locationId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}
