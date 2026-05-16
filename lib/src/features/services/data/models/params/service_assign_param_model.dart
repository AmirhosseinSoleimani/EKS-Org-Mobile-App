
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_assign_param_entity.dart';

class ServiceAssignParamModel extends ServiceAssignParamEntity {
  ServiceAssignParamModel({
    required super.serviceType,
    super.serviceRequestId,
    super.emdadgarID,
    super.type,
    super.isActive,
    super.description,
    super.distance,
    super.distanceTitle,
    super.duration,
    super.durationTitle,
    super.emdadgarPriority,
    super.planningId,
    super.cancelReason,
    super.rejectReason,
  });

  Map<String, dynamic> toJson() {
    return {
      "serviceRequestId": serviceRequestId,
      "serviceType": serviceType.value,
      "emdadgarID": emdadgarID,
      "type": type,
      "isActive": isActive,
      "description": description,
      "distance": distance,
      "distanceTitle": distanceTitle,
      "duration": duration,
      "durationTitle": durationTitle,
      "emdadgarPriority": emdadgarPriority,
      "planningId": planningId,
      if (cancelReason != null && cancelReason! > 0) "cancelReason": cancelReason,
      if (rejectReason != null && rejectReason! > 0) "rejectReason": rejectReason,
    };
  }
}