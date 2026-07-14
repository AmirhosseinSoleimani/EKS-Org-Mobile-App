import 'package:eks_sana_plus_org/src/features/plan_info/data/models/params/change_plan_info_location_param_model.dart';

class ChangePlanInfoLocationParamEntity {
  final int planId;
  final int emdadUnitId;
  final int locationId;
  final double latitude;
  final double longitude;
  final String address;

  const ChangePlanInfoLocationParamEntity({
    required this.planId,
    required this.emdadUnitId,
    required this.locationId,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  ChangePlanInfoLocationParamEntity copyWith({
    int? planId,
    int? emdadUnitId,
    int? locationId,
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return ChangePlanInfoLocationParamEntity(
      planId: planId ?? this.planId,
      emdadUnitId: emdadUnitId ?? this.emdadUnitId,
      locationId: locationId ?? this.locationId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  ChangePlanInfoLocationParamModel toModel() {
    return ChangePlanInfoLocationParamModel(
      planId: planId,
      emdadUnitId: emdadUnitId,
      locationId: locationId,
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }
}
