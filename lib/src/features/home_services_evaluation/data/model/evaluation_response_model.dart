import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_service_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'evaluation_image_model.dart';


class EvaluationResponseModel extends EvaluationResponseEntity {
  EvaluationResponseModel({
    super.avarezi,
    super.dakal,
    super.invoiceOnlineMode,
    super.stopTime,
    super.lastEvaluationEntity,
    super.isContractor,
  });

  factory EvaluationResponseModel.fromJson(Map<String, dynamic> json) {
    return EvaluationResponseModel(
      avarezi: json['avarezi'],
      dakal: json['dakal'],
      invoiceOnlineMode: json['invoiceOnlineMode'],
      stopTime: json['stopTime'],
      isContractor: json['isPeymankar'],
      lastEvaluationEntity: json['lastEvaluation'] != null ? LastEvaluationModel.fromJson(json['lastEvaluation']) : null,
    );
  }
}

class LastEvaluationModel extends LastEvaluationEntity {
  LastEvaluationModel({
    super.acceptanceCode,
    super.arriveDate,
    super.arriveTrackerName,
    super.assignDate,
    super.assignTrackerName,
    super.createNewServiceRequest,
    super.customerKilometer,
    super.defectInfoId,
    super.description,
    super.distanceHamlCustomer,
    super.distanceToCustomer,
    super.emdadgarId,
    super.serviceCategoryId,
    super.endWorkDate,
    super.endWorkTrackerName,
    super.id,
    super.isAccepted,
    super.reasonHamlId,
    super.representation,
    super.serviceRequestId,
    super.stopTime,
    super.confirmValidation,
    super.emdadgarNavganTypeId,
    super.serviceType,
    super.cancelReasonId,
    super.cancelReasonNotPresentId,
    super.defectInfoTitle,
    super.payAvarezi,
    super.reasonHamlTitle,
    super.receptionCode,
    super.receptionId,
    super.receptionMessage,
    super.representationCode,
    super.servicesAndLaborsAndPartsEvaluationPayloadEntity,
    super.useDakal,
    super.images
  });

  factory LastEvaluationModel.fromJson(Map<String, dynamic> json) {
    return LastEvaluationModel(
      serviceRequestId: json['serviceRequestId'],
      serviceType: json['serviceType'],
      id: json['id'],
      emdadgarId: json['emdadgarId'],
      cancelReasonId: json['cancelReasonId'],
      cancelReasonNotPresentId: json['cancelReasonNotPresentId'],
      serviceCategoryId: json['serviceCategoryId'],
      distanceToCustomer: json['distanceToCustomer'],
      customerKilometer: json['customerKilometer'],
      isAccepted: json['isAccepted'],
      description: json['description'],
      stopTime: json['stopTime'],
      createNewServiceRequest: json['createNewServiceRequest'],
      assignDate: json['assignDate'],
      arriveDate: json['arriveDate'],
      endWorkDate: json['endWorkDate'],
      assignTrackerName: json['assignTrackerName'],
      arriveTrackerName: json['arriveTrackerName'],
      endWorkTrackerName: json['endWorkTrackerName'],
      emdadgarNavganTypeId: json['emdadgarNavganTypeId'],
      confirmValidation: json['confirmValidation'],
      servicesAndLaborsAndPartsEvaluationPayloadEntity:
      json['servicesAndLaborsAndPartsEvaluationPayload'] != null ? ServicesAndLaborsAndPartsEvaluationPayloadModel.fromJson(json['servicesAndLaborsAndPartsEvaluationPayload']) : null,
      defectInfoId: json['defectInfoId'],
      defectInfoTitle: json['defectInfoTitle'],
      distanceHamlCustomer: json['distanceHamlCustomer'],
      representationCode: json['representationCode'],
      acceptanceCode: json['acceptanceCode'],
      reasonHamlId: json['reasonHamlId'],
      reasonHamlTitle: json['reasonHamlTitle'],
      useDakal: json['useDakal'],
      payAvarezi: json['payAvarezi'],
      representation: json['representation'],
      receptionId: json['receptionId'],
      receptionCode: json['receptionCode'],
      receptionMessage: json['receptionMessage'],
      images: (json['evaluationImages'] as List<dynamic>?)?.map((e) => EvaluationImageModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceRequestId': serviceRequestId,
      'serviceType': serviceType,
      'id': id,
      'emdadgarId': emdadgarId,
      'cancelReasonId': cancelReasonId,
      'cancelReasonNotPresentId': cancelReasonNotPresentId,
      'emdadServiceCategoryId': serviceCategoryId,
      'distanceToCustomer': distanceToCustomer,
      'customerKilometer': customerKilometer,
      'isAccepted': isAccepted,
      'description': description,
      'stopTime': stopTime,
      'createNewServiceRequest': createNewServiceRequest,
      'assignDate': assignDate,
      'arriveDate': arriveDate,
      'endWorkDate': endWorkDate,
      'assignTrackerName': assignTrackerName,
      'arriveTrackerName': arriveTrackerName,
      'endWorkTrackerName': endWorkTrackerName,
      'emdadgarNavganTypeId': emdadgarNavganTypeId,
      'confirmValidation': confirmValidation,
      'servicesAndLaborsAndPartsEvaluationPayload': servicesAndLaborsAndPartsEvaluationPayloadEntity?.toModel().toJson(),
      'defectInfoId': defectInfoId,
      'defectInfoTitle': defectInfoTitle,
      'distanceHamlCustomer': distanceHamlCustomer,
      'representaionCode': representationCode,
      'acceptanceCode': acceptanceCode,
      'reasonHamlId': reasonHamlId,
      'reasonHamlTitle': reasonHamlTitle,
      'useDakal ': useDakal,
      'payAvarezi ': payAvarezi,
      'representation': representation,
      'receptionId': receptionId,
      'receptionCode': receptionCode,
      'receptionMessage': receptionMessage,
      'evaluationImages': images?.map((e) => (e).toModel().toJson()).toList(),
    };
  }
}

class ServicesAndLaborsAndPartsEvaluationPayloadModel extends ServicesAndLaborsAndPartsEvaluationPayloadEntity {
  ServicesAndLaborsAndPartsEvaluationPayloadModel({
    super.evaluationServiceEntity,
  });

  factory ServicesAndLaborsAndPartsEvaluationPayloadModel.fromJson(Map<String, dynamic> json) {
    return ServicesAndLaborsAndPartsEvaluationPayloadModel(
      evaluationServiceEntity: (json['evaluationServices'] as List<dynamic>?)?.map((item) => EvaluationServiceModel.fromJson(item)).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'evaluationServices': evaluationServiceEntity?.map((e) => e.toModel().toJson()).toList(),
    };
  }
}