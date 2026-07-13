import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_history_param_entity.dart';

class GetVehicleHistoryParamModel extends GetVehicleHistoryParamEntity {
  const GetVehicleHistoryParamModel({
    super.refId,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'refId': refId,
      'type': 2,
    };
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
