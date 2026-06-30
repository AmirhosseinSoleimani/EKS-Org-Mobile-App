import 'package:eks_sana_plus_org/src/features/evaluation/data/models/last_evaluation_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/services_and_labors_and_parts_evaluation_payload_entity.dart';

class ResponseLastEvaluationEntity {
  final LastEvaluationEntity? lastEvaluation;
  final bool? avarezi;
  final bool? dakal;
  final bool? stopTime;
  final bool? isPeymankar;
  final bool? invoiceOnlineMode;

  const ResponseLastEvaluationEntity({
    this.lastEvaluation,
    this.avarezi,
    this.dakal,
    this.stopTime,
    this.isPeymankar,
    this.invoiceOnlineMode,
  });

  ResponseLastEvaluationEntity copyWith({
    LastEvaluationEntity? lastEvaluation,
    bool? avarezi,
    bool? dakal,
    bool? stopTime,
    bool? isPeymankar,
    bool? invoiceOnlineMode,
  }) {
    return ResponseLastEvaluationEntity(
      lastEvaluation: lastEvaluation ?? this.lastEvaluation,
      avarezi: avarezi ?? this.avarezi,
      dakal: dakal ?? this.dakal,
      stopTime: stopTime ?? this.stopTime,
      isPeymankar: isPeymankar ?? this.isPeymankar,
      invoiceOnlineMode: invoiceOnlineMode ?? this.invoiceOnlineMode,
    );
  }

  ResponseLastEvaluationModel toModel() {
    return ResponseLastEvaluationModel(
      lastEvaluation: lastEvaluation?.toModel(),
      avarezi: avarezi,
      dakal: dakal,
      stopTime: stopTime,
      isPeymankar: isPeymankar,
      invoiceOnlineMode: invoiceOnlineMode,
    );
  }
}

class LastEvaluationEntity {
  final int? emdadServiceCategoryId;
  final int? defectInfoId;
  final String? defectInfoTitle;
  final double? distanceHamlCustomer;
  final int? representationCode;
  final int? acceptanceCode;
  final int? reasonHamlId;
  final bool? useDakal;
  final bool? payAvarezi;
  final bool? representation;
  final String? serviceTypeTitle;
  final int? id;
  final int? emdadgarId;
  final int? serviceCategoryId;
  final double? distanceToCustomer;
  final int? customerKilometer;
  final String? description;
  final int? stopTime;
  final bool? createNewServiceRequest;
  final String? assignDate;
  final String? arriveDate;
  final String? endWorkDate;
  final String? assignTrackerName;
  final String? arriveTrackerName;
  final String? endWorkTrackerName;
  final int? emdadgarNavganTypeId;
  final bool? confirmValidation;
  final bool? isImageMandatory;
  final bool? needImage;
  final ServicesAndLaborsAndPartsEvaluationPayloadEntity?
  servicesAndLaborsAndPartsEvaluationPayload;
  final List<dynamic>? evaluationImages;
  final int? serviceRequestId;
  final int? serviceType;

  const LastEvaluationEntity({
    this.emdadServiceCategoryId,
    this.defectInfoId,
    this.defectInfoTitle,
    this.distanceHamlCustomer,
    this.representationCode,
    this.acceptanceCode,
    this.reasonHamlId,
    this.useDakal,
    this.payAvarezi,
    this.representation,
    this.serviceTypeTitle,
    this.id,
    this.emdadgarId,
    this.serviceCategoryId,
    this.distanceToCustomer,
    this.customerKilometer,
    this.description,
    this.stopTime,
    this.createNewServiceRequest,
    this.assignDate,
    this.arriveDate,
    this.endWorkDate,
    this.assignTrackerName,
    this.arriveTrackerName,
    this.endWorkTrackerName,
    this.emdadgarNavganTypeId,
    this.confirmValidation,
    this.isImageMandatory,
    this.needImage,
    this.servicesAndLaborsAndPartsEvaluationPayload,
    this.evaluationImages,
    this.serviceRequestId,
    this.serviceType,
  });

  LastEvaluationEntity copyWith({
    int? emdadServiceCategoryId,
    int? defectInfoId,
    String? defectInfoTitle,
    double? distanceHamlCustomer,
    int? representationCode,
    int? acceptanceCode,
    int? reasonHamlId,
    bool? useDakal,
    bool? payAvarezi,
    bool? representation,
    String? serviceTypeTitle,
    int? id,
    int? emdadgarId,
    int? serviceCategoryId,
    double? distanceToCustomer,
    int? customerKilometer,
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
    bool? isImageMandatory,
    bool? needImage,
    ServicesAndLaborsAndPartsEvaluationPayloadEntity?
    servicesAndLaborsAndPartsEvaluationPayload,
    List<dynamic>? evaluationImages,
    int? serviceRequestId,
    int? serviceType,
  }) {
    return LastEvaluationEntity(
      emdadServiceCategoryId:
          emdadServiceCategoryId ?? this.emdadServiceCategoryId,
      defectInfoId: defectInfoId ?? this.defectInfoId,
      defectInfoTitle: defectInfoTitle ?? this.defectInfoTitle,
      distanceHamlCustomer: distanceHamlCustomer ?? this.distanceHamlCustomer,
      representationCode: representationCode ?? this.representationCode,
      acceptanceCode: acceptanceCode ?? this.acceptanceCode,
      reasonHamlId: reasonHamlId ?? this.reasonHamlId,
      useDakal: useDakal ?? this.useDakal,
      payAvarezi: payAvarezi ?? this.payAvarezi,
      representation: representation ?? this.representation,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
      id: id ?? this.id,
      emdadgarId: emdadgarId ?? this.emdadgarId,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      distanceToCustomer: distanceToCustomer ?? this.distanceToCustomer,
      customerKilometer: customerKilometer ?? this.customerKilometer,
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
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
      needImage: needImage ?? this.needImage,
      servicesAndLaborsAndPartsEvaluationPayload:
          servicesAndLaborsAndPartsEvaluationPayload ??
          this.servicesAndLaborsAndPartsEvaluationPayload,
      evaluationImages: evaluationImages ?? this.evaluationImages,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  LastEvaluationModel toModel() {
    return LastEvaluationModel(
      emdadServiceCategoryId: emdadServiceCategoryId,
      defectInfoId: defectInfoId,
      defectInfoTitle: defectInfoTitle,
      distanceHamlCustomer: distanceHamlCustomer,
      representationCode: representationCode,
      acceptanceCode: acceptanceCode,
      reasonHamlId: reasonHamlId,
      useDakal: useDakal,
      payAvarezi: payAvarezi,
      representation: representation,
      serviceTypeTitle: serviceTypeTitle,
      id: id,
      emdadgarId: emdadgarId,
      serviceCategoryId: serviceCategoryId,
      distanceToCustomer: distanceToCustomer,
      customerKilometer: customerKilometer,
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
      isImageMandatory: isImageMandatory,
      needImage: needImage,
      servicesAndLaborsAndPartsEvaluationPayload:
          servicesAndLaborsAndPartsEvaluationPayload?.toModel(),
      evaluationImages: evaluationImages,
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
    );
  }
}
