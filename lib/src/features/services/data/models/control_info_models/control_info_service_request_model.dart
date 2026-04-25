import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_service_request_entity.dart';

import 'service_request_step_model.dart';

class ControlInfoServiceRequestModel extends ControlInfoServiceRequestEntity {
  ControlInfoServiceRequestModel({
    super.timeFromCallToBeginRequestRegistration,
    super.timeFromBeginToFinishRequestRegistration,
    super.timeFromFinishRequestRegistrationToAssignEmdadgar,
    super.call,
    super.serviceRequestRegistrationBegin,
    super.serviceRequestRegistrationFinish,
    super.assignEmdadgar,
    super.reserveEmdadgar,
  });

  factory ControlInfoServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ControlInfoServiceRequestModel(
      timeFromCallToBeginRequestRegistration:
          json['timeFromCallToBeginRequestRegistration'],
      timeFromBeginToFinishRequestRegistration:
          json['timeFromBeginToFinishRequestRegistration'],
      timeFromFinishRequestRegistrationToAssignEmdadgar:
          json['timeFromFinishRequestRegistrationToAssignEmdadgar'],
      call: json['call'] != null
          ? ServiceRequestStepModel.fromJson(json['call'])
          : null,
      serviceRequestRegistrationBegin:
          json['serviceRequestRegistrationBegin'] != null
              ? ServiceRequestStepModel.fromJson(
                  json['serviceRequestRegistrationBegin'])
              : null,
      serviceRequestRegistrationFinish:
          json['serviceRequestRegistrationFinish'] != null
              ? ServiceRequestStepModel.fromJson(
                  json['serviceRequestRegistrationFinish'])
              : null,
      assignEmdadgar: json['assignEmdadgar'] != null
          ? ServiceRequestStepModel.fromJson(json['assignEmdadgar'])
          : null,
      reserveEmdadgar: json['reserveEmdadgar'] != null
          ? ServiceRequestStepModel.fromJson(json['reserveEmdadgar'])
          : null,
    );
  }
}
