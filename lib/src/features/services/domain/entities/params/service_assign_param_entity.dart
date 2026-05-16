import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/service_assign_param_model.dart';

class ServiceAssignParamEntity {
  ServiceType serviceType;
  int? serviceRequestId;
  int? emdadgarID;
  int? type;
  bool? isActive;
  String? description;
  int? distance;
  String? distanceTitle;
  int? duration;
  String? durationTitle;
  int? emdadgarPriority;
  int? planningId;
  int? cancelReason;
  int? rejectReason;

  ServiceAssignParamEntity({
   required this.serviceType,
    this.serviceRequestId,
    this.emdadgarID,
    this.type,
    this.isActive,
    this.description,
    this.distance,
    this.distanceTitle,
    this.duration,
    this.durationTitle,
    this.emdadgarPriority,
    this.planningId,
    this.cancelReason,
    this.rejectReason,
  });

  ServiceAssignParamEntity copyWith({
    int? serviceRequestId,
    ServiceType? serviceType,
    int? emdadgarID,
    int? type,
    bool? isActive,
    String? description,
    int? distance,
    String? distanceTitle,
    int? duration,
    String? durationTitle,
    int? emdadgarPriority,
    int? planningId,
    int? cancelReason,
    int? rejectReason,
  }) {
    return ServiceAssignParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      emdadgarID: emdadgarID ?? this.emdadgarID,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      distanceTitle: distanceTitle ?? this.distanceTitle,
      duration: duration ?? this.duration,
      durationTitle: durationTitle ?? this.durationTitle,
      emdadgarPriority: emdadgarPriority ?? this.emdadgarPriority,
      planningId: planningId ?? this.planningId,
      cancelReason: cancelReason ?? this.cancelReason,
      rejectReason: rejectReason ?? this.rejectReason,
    );
  }

  ServiceAssignParamModel toModel() {
    return ServiceAssignParamModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      emdadgarID: emdadgarID,
      type: type,
      isActive: isActive,
      description: description,
      distance: distance,
      distanceTitle: distanceTitle,
      duration: duration,
      durationTitle: durationTitle,
      emdadgarPriority: emdadgarPriority,
      planningId: planningId,
      cancelReason: cancelReason,
      rejectReason: rejectReason,
    );
  }
}
