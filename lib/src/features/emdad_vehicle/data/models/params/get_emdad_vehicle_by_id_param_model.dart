import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_emdad_vehicle_by_id_param_entity.dart';

class GetEmdadVehicleByIdParamModel extends GetEmdadVehicleByIdParamEntity {
  const GetEmdadVehicleByIdParamModel({
    super.id,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'Id': id,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
