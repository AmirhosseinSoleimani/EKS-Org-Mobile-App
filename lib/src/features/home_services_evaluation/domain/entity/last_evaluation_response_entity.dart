import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';

import 'evaluation_image_entity.dart';

class EvaluationResponseEntity {
  LastEvaluationEntity? lastEvaluationEntity;
  bool? avarezi;
  bool? dakal;
  bool? stopTime;
  bool? isContractor;
  bool? invoiceOnlineMode;

  EvaluationResponseEntity({
    this.lastEvaluationEntity,
    this.invoiceOnlineMode,
    this.stopTime,
    this.dakal,
    this.isContractor,
    this.avarezi,
  });

  EvaluationResponseEntity copyWith({
    LastEvaluationEntity? lastEvaluationEntity,
    bool? avarezi,
    bool? dakal,
    bool? stopTime,
    bool? invoiceOnlineMode,
    bool? isContractor,
  }) {
    return EvaluationResponseEntity(
      lastEvaluationEntity: lastEvaluationEntity ?? this.lastEvaluationEntity,
      avarezi: avarezi ?? this.avarezi,
      dakal: dakal ?? this.dakal,
      stopTime: stopTime ?? this.stopTime,
      invoiceOnlineMode: invoiceOnlineMode ?? this.invoiceOnlineMode,
      isContractor: isContractor ?? this.isContractor,
    );
  }

  EvaluationResponseModel toModel() {
    return EvaluationResponseModel(
      avarezi: avarezi,
      dakal: dakal,
      stopTime: stopTime,
      invoiceOnlineMode: invoiceOnlineMode,
      lastEvaluationEntity: lastEvaluationEntity,
      isContractor: isContractor,
    );
  }
}

class LastEvaluationEntity {
  int? serviceRequestId;
  int? serviceType;
  int? id;
  int? emdadgarId;
  int? cancelReasonId;
  int? cancelReasonNotPresentId;
  int? serviceCategoryId;
  double? distanceToCustomer;
  int? customerKilometer;
  bool? isAccepted;
  String? description;
  int? stopTime;
  bool? createNewServiceRequest;
  String? assignDate;
  String? arriveDate;
  String? endWorkDate;
  String? assignTrackerName;
  String? arriveTrackerName;
  String? endWorkTrackerName;
  int? emdadgarNavganTypeId;
  bool? confirmValidation;
  ServicesAndLaborsAndPartsEvaluationPayloadEntity?
  servicesAndLaborsAndPartsEvaluationPayloadEntity;
  int? defectInfoId;
  String? defectInfoTitle;
  double? distanceHamlCustomer;
  int? representationCode;

  int? acceptanceCode;
  int? reasonHamlId;
  String? reasonHamlTitle;
  bool? useDakal;
  bool? payAvarezi;
  bool? representation;
  String? receptionId;
  String? receptionCode;
  String? receptionMessage;
  List<EvaluationImageEntity>? images;

  LastEvaluationEntity({
    this.id,
    this.emdadgarId,
    this.defectInfoId,
    this.serviceRequestId,
    this.serviceCategoryId,
    this.distanceToCustomer,
    this.distanceHamlCustomer,
    this.customerKilometer,
    this.isAccepted,
    this.acceptanceCode,
    this.reasonHamlId,
    this.stopTime,
    this.representation,
    this.createNewServiceRequest,
    this.assignDate,
    this.arriveDate,
    this.endWorkDate,
    this.assignTrackerName,
    this.arriveTrackerName,
    this.endWorkTrackerName,
    this.description,
    this.serviceType,
    this.servicesAndLaborsAndPartsEvaluationPayloadEntity,
    this.emdadgarNavganTypeId,
    this.confirmValidation,
    this.defectInfoTitle,
    this.receptionId,
    this.cancelReasonId,
    this.cancelReasonNotPresentId,
    this.payAvarezi,
    this.reasonHamlTitle,
    this.receptionCode,
    this.receptionMessage,
    this.representationCode,
    this.useDakal,
    this.images,
  });

  LastEvaluationEntity copyWith({
    int? serviceRequestId,
    int? serviceType,
    int? id,
    int? emdadgarId,
    int? cancelReasonId,
    int? cancelReasonNotPresentId,
    int? serviceCategoryId,
    double? distanceToCustomer,
    int? customerKilometer,
    bool? isAccepted,
    String? description,
    int? stopTime,
    bool? createNewServiceRequest,
    String? assignDate,
    String? arriveDate,
    String? endWorkDate,
    String? assignTrackerName,
    String? arriveTrackerName,
    String? endWorkTrackerName,
    int? emdadgarNavganTypeId,
    bool? confirmValidation,
    ServicesAndLaborsAndPartsEvaluationPayloadEntity?
    servicesAndLaborsAndPartsEvaluationPayloadEntity,
    int? defectInfoId,
    String? defectInfoTitle,
    double? distanceHamlCustomer,
    int? representationCode,
    int? acceptanceCode,
    int? reasonHamlId,
    String? reasonHamlTitle,
    bool? useDakal,
    bool? payAvarezi,
    bool? representation,
    String? receptionId,
    String? receptionCode,
    String? receptionMessage,
    List<EvaluationImageEntity>? images,
  }) {
    return LastEvaluationEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      id: id ?? this.id,
      emdadgarId: emdadgarId ?? this.emdadgarId,
      cancelReasonId: cancelReasonId ?? this.cancelReasonId,
      cancelReasonNotPresentId:
          cancelReasonNotPresentId ?? this.cancelReasonNotPresentId,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      distanceToCustomer: distanceToCustomer ?? this.distanceToCustomer,
      customerKilometer: customerKilometer ?? this.customerKilometer,
      isAccepted: isAccepted ?? this.isAccepted,
      description: description ?? this.description,
      stopTime: stopTime ?? this.stopTime,
      createNewServiceRequest:
          createNewServiceRequest ?? this.createNewServiceRequest,
      assignDate: assignDate ?? this.assignDate,
      arriveDate: arriveDate ?? this.arriveDate,
      endWorkDate: endWorkDate ?? this.endWorkDate,
      assignTrackerName: assignTrackerName ?? this.assignTrackerName,
      arriveTrackerName: arriveTrackerName ?? this.arriveTrackerName,
      endWorkTrackerName: endWorkTrackerName ?? this.endWorkTrackerName,
      emdadgarNavganTypeId: emdadgarNavganTypeId ?? this.emdadgarNavganTypeId,
      confirmValidation: confirmValidation ?? this.confirmValidation,
      servicesAndLaborsAndPartsEvaluationPayloadEntity:
          servicesAndLaborsAndPartsEvaluationPayloadEntity ??
          this.servicesAndLaborsAndPartsEvaluationPayloadEntity,
      defectInfoId: defectInfoId ?? this.defectInfoId,
      defectInfoTitle: defectInfoTitle ?? this.defectInfoTitle,
      distanceHamlCustomer: distanceHamlCustomer ?? this.distanceHamlCustomer,
      representationCode: representationCode ?? this.representationCode,
      acceptanceCode: acceptanceCode ?? this.acceptanceCode,
      reasonHamlId: reasonHamlId ?? this.reasonHamlId,
      reasonHamlTitle: reasonHamlTitle ?? this.reasonHamlTitle,
      useDakal: useDakal ?? this.useDakal,
      payAvarezi: payAvarezi ?? this.payAvarezi,
      representation: representation ?? this.representation,
      receptionId: receptionId ?? this.receptionId,
      receptionCode: receptionCode ?? this.receptionCode,
      receptionMessage: receptionMessage ?? this.receptionMessage,
      images: images ?? this.images,
    );
  }

  LastEvaluationModel toModel() {
    return LastEvaluationModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      id: id,
      emdadgarId: emdadgarId,
      cancelReasonId: cancelReasonId,
      cancelReasonNotPresentId: cancelReasonNotPresentId,
      serviceCategoryId: serviceCategoryId,
      distanceToCustomer: distanceToCustomer,
      customerKilometer: customerKilometer,
      isAccepted: isAccepted,
      description: description,
      stopTime: stopTime,
      createNewServiceRequest: createNewServiceRequest,
      assignDate: assignDate,
      arriveDate: arriveDate,
      endWorkDate: endWorkDate,
      assignTrackerName: assignTrackerName,
      arriveTrackerName: arriveTrackerName,
      endWorkTrackerName: endWorkTrackerName,
      emdadgarNavganTypeId: emdadgarNavganTypeId,
      confirmValidation: confirmValidation,
      servicesAndLaborsAndPartsEvaluationPayloadEntity:
          servicesAndLaborsAndPartsEvaluationPayloadEntity,
      defectInfoId: defectInfoId,
      defectInfoTitle: defectInfoTitle,
      distanceHamlCustomer: distanceHamlCustomer,
      representationCode: representationCode,
      acceptanceCode: acceptanceCode,
      reasonHamlId: reasonHamlId,
      reasonHamlTitle: reasonHamlTitle,
      useDakal: useDakal,
      payAvarezi: payAvarezi,
      representation: representation,
      receptionId: receptionId,
      receptionCode: receptionCode,
      receptionMessage: receptionMessage,
      images: images,
    );
  }
}

class ServicesAndLaborsAndPartsEvaluationPayloadEntity {
  List<EvaluationServiceEntity>? evaluationServiceEntity;

  ServicesAndLaborsAndPartsEvaluationPayloadEntity({
    this.evaluationServiceEntity,
  });

  ServicesAndLaborsAndPartsEvaluationPayloadEntity copyWith({
    List<EvaluationServiceEntity>? evaluationServiceEntity,
  }) {
    return ServicesAndLaborsAndPartsEvaluationPayloadEntity(
      evaluationServiceEntity: evaluationServiceEntity,
    );
  }

  ServicesAndLaborsAndPartsEvaluationPayloadModel toModel() {
    return ServicesAndLaborsAndPartsEvaluationPayloadModel(
      evaluationServiceEntity: evaluationServiceEntity,
    );
  }
}
