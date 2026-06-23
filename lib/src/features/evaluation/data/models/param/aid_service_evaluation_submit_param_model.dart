import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/aid_service_evaluation_submit_param_entity.dart';

class AidServiceEvaluationSubmitParamModel
    extends AidServiceEvaluationSubmitParamEntity {
  const AidServiceEvaluationSubmitParamModel({
    required super.serviceType,
    super.serviceRequestId,
    super.emdadgarId,
    super.serviceCategoryId,
    super.customerKilometer,
    super.distanceToCustomer,
    super.assignDate,
    super.arriveDate,
    super.endWorkDate,
    super.confirmValidation = false,
    super.defectInfoId,
    super.description,
    super.representaionCode,
    super.acceptanceCode,
    super.representation,
    super.emdadgarEvaluationId,
    super.distanceHamlCustomer,
    super.representationId,
    super.emdadServiceCategoryId,
    required super.servicesAndLaborsAndPartsEvaluationPayload,
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceRequestId': serviceRequestId,
      'serviceType': serviceType.value,
      'emdadgarId': emdadgarId,
      'serviceCategoryId': serviceCategoryId,
      'customerKilometer': customerKilometer,
      'distanceToCustomer': distanceToCustomer,
      'AssignDate': assignDate,
      'ArriveDate': arriveDate,
      'EndWorkDate': endWorkDate,
      'ConfirmValidation': confirmValidation,
      'DefectInfoId': defectInfoId,
      'Description': description,
      'representaionCode': representaionCode,
      'acceptanceCode': acceptanceCode,
      'representationId': representationId,
      'emdadgarEvaluationId': emdadgarEvaluationId,
      'emdadServiceCategoryId': emdadServiceCategoryId,
      'distanceHamlCustomer': distanceHamlCustomer,
      'servicesAndLaborsAndPartsEvaluationPayload':
          servicesAndLaborsAndPartsEvaluationPayload.toModel().toJson(),
    };
  }
}
