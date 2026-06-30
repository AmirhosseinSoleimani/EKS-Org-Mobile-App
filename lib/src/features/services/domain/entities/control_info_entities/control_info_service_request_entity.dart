
import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_info_service_request_model.dart';

import 'service_request_step_entity.dart';

class ControlInfoServiceRequestEntity {
  final String? timeFromCallToBeginRequestRegistration;
  final String? timeFromBeginToFinishRequestRegistration;
  final String? timeFromFinishRequestRegistrationToAssignEmdadgar;

  final ServiceRequestStepEntity? call;
  final ServiceRequestStepEntity? serviceRequestRegistrationBegin;
  final ServiceRequestStepEntity? serviceRequestRegistrationFinish;
  final ServiceRequestStepEntity? assignEmdadgar;
  final ServiceRequestStepEntity? reserveEmdadgar;

  const ControlInfoServiceRequestEntity({
    this.timeFromCallToBeginRequestRegistration,
    this.timeFromBeginToFinishRequestRegistration,
    this.timeFromFinishRequestRegistrationToAssignEmdadgar,
    this.call,
    this.serviceRequestRegistrationBegin,
    this.serviceRequestRegistrationFinish,
    this.assignEmdadgar,
    this.reserveEmdadgar,
  });

  ControlInfoServiceRequestEntity copyWith({
    String? timeFromCallToBeginRequestRegistration,
    String? timeFromBeginToFinishRequestRegistration,
    String? timeFromFinishRequestRegistrationToAssignEmdadgar,
    ServiceRequestStepEntity? call,
    ServiceRequestStepEntity? serviceRequestRegistrationBegin,
    ServiceRequestStepEntity? serviceRequestRegistrationFinish,
    ServiceRequestStepEntity? assignEmdadgar,
    ServiceRequestStepEntity? reserveEmdadgar,
  }) {
    return ControlInfoServiceRequestEntity(
      timeFromCallToBeginRequestRegistration:
      timeFromCallToBeginRequestRegistration ??
          this.timeFromCallToBeginRequestRegistration,
      timeFromBeginToFinishRequestRegistration:
      timeFromBeginToFinishRequestRegistration ??
          this.timeFromBeginToFinishRequestRegistration,
      timeFromFinishRequestRegistrationToAssignEmdadgar:
      timeFromFinishRequestRegistrationToAssignEmdadgar ??
          this.timeFromFinishRequestRegistrationToAssignEmdadgar,
      call: call ?? this.call,
      serviceRequestRegistrationBegin:
      serviceRequestRegistrationBegin ??
          this.serviceRequestRegistrationBegin,
      serviceRequestRegistrationFinish:
      serviceRequestRegistrationFinish ??
          this.serviceRequestRegistrationFinish,
      assignEmdadgar: assignEmdadgar ?? this.assignEmdadgar,
      reserveEmdadgar: reserveEmdadgar ?? this.reserveEmdadgar,
    );
  }

  ControlInfoServiceRequestModel toModel() {
    return ControlInfoServiceRequestModel(
      timeFromCallToBeginRequestRegistration:
      timeFromCallToBeginRequestRegistration,
      timeFromBeginToFinishRequestRegistration:
      timeFromBeginToFinishRequestRegistration,
      timeFromFinishRequestRegistrationToAssignEmdadgar:
      timeFromFinishRequestRegistrationToAssignEmdadgar,
      call: call?.toModel(),
      serviceRequestRegistrationBegin:
      serviceRequestRegistrationBegin?.toModel(),
      serviceRequestRegistrationFinish:
      serviceRequestRegistrationFinish?.toModel(),
      assignEmdadgar: assignEmdadgar?.toModel(),
      reserveEmdadgar: reserveEmdadgar?.toModel(),
    );
  }
}
