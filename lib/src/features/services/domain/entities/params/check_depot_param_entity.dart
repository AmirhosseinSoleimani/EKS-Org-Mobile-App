import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/check_depot_param_model.dart';

class CheckDepotParamEntity {
  int? serviceRequestId;
  int? planningId;
  ServiceType serviceType;

  CheckDepotParamEntity({
   required this.serviceType,
    this.serviceRequestId,
    this.planningId,
  });

  CheckDepotParamEntity copyWith({
    int? serviceRequestId,
    int? planningId,
    ServiceType? serviceType,
  }) {
    return CheckDepotParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      planningId: planningId ?? this.planningId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  CheckDepotParamModel toModel() {
    return CheckDepotParamModel(
      serviceRequestId: serviceRequestId,
      planningId: planningId,
      serviceType: serviceType,
    );
  }
}

