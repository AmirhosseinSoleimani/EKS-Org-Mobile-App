import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/delete_emdad_vehicle_param_entity.dart';

class DeleteEmdadVehicleParamModel extends DeleteEmdadVehicleParamEntity {
  const DeleteEmdadVehicleParamModel({
    super.id,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'id': id,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
