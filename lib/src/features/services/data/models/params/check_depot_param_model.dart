import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/check_depot_param_entity.dart';

class CheckDepotParamModel extends CheckDepotParamEntity {
  CheckDepotParamModel({
    required super.serviceType,
    super.serviceRequestId,
    super.planningId,
  });

  Map<String, dynamic> toJson() {
    return {
      "serviceRequestId": serviceRequestId,
      "planningId": planningId,
      "serviceType": serviceType.value,
    };
  }
}
