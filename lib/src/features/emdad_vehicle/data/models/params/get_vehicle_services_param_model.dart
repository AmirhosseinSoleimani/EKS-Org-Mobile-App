import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_services_param_entity.dart';

class GetVehicleServicesParamModel extends GetVehicleServicesParamEntity {
  const GetVehicleServicesParamModel({
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
