import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/services_and_labors_and_parts_evaluation_model.dart';

class AidServiceEvaluationSubmitParamModel {
  final int? serviceRequestId;
  final int? serviceType;
  final int? emdadgarId;
  final int? serviceCategoryId;
  final int? customerKilometer;
  final int? distanceToCustomer;

  final String? assignDate;
  final String? arriveDate;
  final String? endWorkDate;
  final bool confirmValidation;
  final int? defectInfoId;
  final String? description;

  final ServicesAndLaborsAndPartsEvaluationModel
  servicesAndLaborsAndPartsEvaluationPayload;

  const AidServiceEvaluationSubmitParamModel({
    this.serviceRequestId,
    this.serviceType,
    this.emdadgarId,
    this.serviceCategoryId,
    this.customerKilometer,
    this.distanceToCustomer,
    this.assignDate,
    this.arriveDate,
    this.endWorkDate,
    this.confirmValidation = false,
    this.defectInfoId,
    this.description,
    required this.servicesAndLaborsAndPartsEvaluationPayload,
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceRequestId': serviceRequestId,
      'serviceType': serviceType,
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
      'servicesAndLaborsAndPartsEvaluationPayload':
          servicesAndLaborsAndPartsEvaluationPayload.toJson(),
    };
  }
}
