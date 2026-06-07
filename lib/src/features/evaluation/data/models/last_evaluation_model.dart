import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';

import 'services_and_labors_and_parts_evaluation_payload_model.dart';

class ResponseLastEvaluationModel extends ResponseLastEvaluationEntity {
  const ResponseLastEvaluationModel({
    super.lastEvaluation,
    super.avarezi,
    super.dakal,
    super.stopTime,
    super.isPeymankar,
    super.invoiceOnlineMode,
  });

  factory ResponseLastEvaluationModel.fromJson(Map<String, dynamic> json) {
    return ResponseLastEvaluationModel(
      lastEvaluation: json['lastEvaluation'] == null
          ? null
          : LastEvaluationModel.fromJson(json['lastEvaluation']),
      avarezi: json['avarezi'],
      dakal: json['dakal'],
      stopTime: json['stopTime'],
      isPeymankar: json['isPeymankar'],
      invoiceOnlineMode: json['invoiceOnlineMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastEvaluation': lastEvaluation?.toModel().toJson(),
      'avarezi': avarezi,
      'dakal': dakal,
      'stopTime': stopTime,
      'isPeymankar': isPeymankar,
      'invoiceOnlineMode': invoiceOnlineMode,
    };
  }
}

class LastEvaluationModel extends LastEvaluationEntity {
  const LastEvaluationModel({
    super.emdadServiceCategoryId,
    super.defectInfoId,
    super.defectInfoTitle,
    super.distanceHamlCustomer,
    super.representationCode,
    super.acceptanceCode,
    super.reasonHamlId,
    super.useDakal,
    super.payAvarezi,
    super.representation,
    super.serviceTypeTitle,
    super.id,
    super.emdadgarId,
    super.serviceCategoryId,
    super.distanceToCustomer,
    super.customerKilometer,
    super.description,
    super.stopTime,
    super.createNewServiceRequest,
    super.assignDate,
    super.arriveDate,
    super.endWorkDate,
    super.assignTrackerName,
    super.arriveTrackerName,
    super.endWorkTrackerName,
    super.emdadgarNavganTypeId,
    super.confirmValidation,
    super.isImageMandatory,
    super.needImage,
    super.servicesAndLaborsAndPartsEvaluationPayload,
    super.evaluationImages,
    super.serviceRequestId,
    super.serviceType,
  });

  factory LastEvaluationModel.fromJson(Map<String, dynamic> json) {
    return LastEvaluationModel(
      emdadServiceCategoryId: json['emdadServiceCategoryId'],
      defectInfoId: json['defectInfoId'],
      defectInfoTitle: json['defectInfoTitle'],
      distanceHamlCustomer: (json['distanceHamlCustomer'] as num?)?.toDouble(),
      representationCode: json['representaionCode'],
      acceptanceCode: json['acceptanceCode'],
      reasonHamlId: json['reasonHamlId'],
      useDakal: json['useDakal'],
      payAvarezi: json['payAvarezi'],
      representation: json['representation'],
      serviceTypeTitle: json['serviceTypeTitle'],
      id: json['id'],
      emdadgarId: json['emdadgarId'],
      serviceCategoryId: json['serviceCategoryId'],
      distanceToCustomer: (json['distanceToCustomer'] as num?)?.toDouble(),
      customerKilometer: json['customerKilometer'],
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
      isImageMandatory: json['isImageMandatory'],
      needImage: json['needImage'],
      servicesAndLaborsAndPartsEvaluationPayload:
          json['servicesAndLaborsAndPartsEvaluationPayload'] == null
          ? null
          : ServicesAndLaborsAndPartsEvaluationPayloadModel.fromJson(
              json['servicesAndLaborsAndPartsEvaluationPayload'],
            ),
      evaluationImages: json['evaluationImages'],
      serviceRequestId: json['serviceRequestId'],
      serviceType: json['serviceType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emdadServiceCategoryId': emdadServiceCategoryId,
      'defectInfoId': defectInfoId,
      'defectInfoTitle': defectInfoTitle,
      'distanceHamlCustomer': distanceHamlCustomer,
      'representaionCode': representationCode,
      'acceptanceCode': acceptanceCode,
      'reasonHamlId': reasonHamlId,
      'useDakal': useDakal,
      'payAvarezi': payAvarezi,
      'representation': representation,
      'serviceTypeTitle': serviceTypeTitle,
      'id': id,
      'emdadgarId': emdadgarId,
      'serviceCategoryId': serviceCategoryId,
      'distanceToCustomer': distanceToCustomer,
      'customerKilometer': customerKilometer,
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
      'isImageMandatory': isImageMandatory,
      'needImage': needImage,
      'servicesAndLaborsAndPartsEvaluationPayload':
          servicesAndLaborsAndPartsEvaluationPayload?.toModel().toJson(),
      'evaluationImages': evaluationImages,
      'serviceRequestId': serviceRequestId,
      'serviceType': serviceType,
    };
  }
}
