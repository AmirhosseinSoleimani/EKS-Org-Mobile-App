import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_defects_param_entity.dart';

class GetVehicleDefectsParamModel extends GetVehicleDefectsParamEntity {
  const GetVehicleDefectsParamModel({
    super.vehicleInfoId,
    super.emdadServiceCategoryId,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'vehicleInfoId': vehicleInfoId,
      'emdadServiceCategoryId': emdadServiceCategoryId,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
