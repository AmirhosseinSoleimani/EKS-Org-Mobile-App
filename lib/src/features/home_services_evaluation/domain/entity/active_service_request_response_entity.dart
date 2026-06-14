import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/active_service_request_response_model.dart';

class ActiveServiceRequestResponseEntity {
  final int? id;
  final int? serviceType;
  final int? planningId;
  final int? emdadgarId;
  final int? trackCode;
  final int? channelType;
  final String? emdadgarFullName;
  final String? firstName;
  final String? lastName;
  final int? requestStatus;
  final String? requestStatusTitle;
  final String? requestState;
  final String? requestStateTitle;
  final String? personType;
  final String? personTypeTitle;
  final bool? subscription;
  final bool? guaranty;
  final String? invoiceDocumentGuid;
  final String? chassisNumber;
  final int? kilometer;
  final String? carName;
  final String? serviceCategoryTitle;
  final String? serviceCategoryGivenTitle;
  final String? insertDateTime;
  final String? requestDateTimeJalali;
  final String? gender;
  final int? callLogId;
  final String? nationalNumber;
  final int? customerDisability;
  final String? customerDisabilityDesc;
  final String? customerDisabilityTitle;
  final double? latitude;
  final double? longitude;
  final String? aidAddress;
  final String? vin;
  final String? licensePlate;
  final int? saipaKilometer;
  final String? description;
  final String? customerMobileNumber;
  final int? carModelId;
  final String? carEngineNumber;
  final String? carGuid;
  final bool? foreigner;
  final String? carColor;
  final String? carColorTitle;
  final String? cancelReasonTitle;
  final bool? vip;
  final String? assignDescription;
  final String? etmamRequestAuthor;
  final String? etmamRequestDate;
  final String? lastFollowUpTitle;
  final String? assignDate;
  final String? assignTime;
  final String? trackGuid;
  final bool? trafficPlan;
  final int? vipConditionId;
  final String? vipConditionTitle;
  final int? cityId;
  final int? evaluationId;
  final double? distanceToCustomer;
  final String? evaluationDescription;
  final String? arriveDateTime;
  final int? evaluationKilometer;
  final String? emdadgarVehicleType;
  final String? emdadgarNavganType;
  final String? emdadgarMobileNumber;
  final double? emdadgarLatitude;
  final double? emdadgarLongitude;
  final List<int>? serviceCategoryIds;
  final List<int>? serviceIds;
  final List<String>? serviceTitles;
  final List<int>? serviceCategoryGivenIds;
  final List<String>? serviceCategoryGivenTitles;
  final List<int>? serviceGivenIds;
  final String? cancelDesc;
  final String? customerKilometer;
  final int? defectId;
  final String? defectTitle;
  final String? insertDateTimeJalali;

  const ActiveServiceRequestResponseEntity({
    this.id,
    this.serviceType,
    this.planningId,
    this.emdadgarId,
    this.trackCode,
    this.channelType,
    this.emdadgarFullName,
    this.firstName,
    this.lastName,
    this.requestStatus,
    this.requestStatusTitle,
    this.requestState,
    this.requestStateTitle,
    this.personType,
    this.personTypeTitle,
    this.subscription,
    this.guaranty,
    this.invoiceDocumentGuid,
    this.chassisNumber,
    this.kilometer,
    this.carName,
    this.serviceCategoryTitle,
    this.serviceCategoryGivenTitle,
    this.insertDateTime,
    this.requestDateTimeJalali,
    this.gender,
    this.callLogId,
    this.nationalNumber,
    this.latitude,
    this.longitude,
    this.aidAddress,
    this.vin,
    this.licensePlate,
    this.saipaKilometer,
    this.description,
    this.customerDisability,
    this.customerMobileNumber,
    this.carModelId,
    this.carEngineNumber,
    this.carGuid,
    this.foreigner,
    this.carColor,
    this.carColorTitle,
    this.vip,
    this.assignDescription,
    this.etmamRequestAuthor,
    this.etmamRequestDate,
    this.lastFollowUpTitle,
    this.assignDate,
    this.assignTime,
    this.trackGuid,
    this.trafficPlan,
    this.vipConditionId,
    this.vipConditionTitle,
    this.cityId,
    this.evaluationId,
    this.distanceToCustomer,
    this.evaluationDescription,
    this.arriveDateTime,
    this.evaluationKilometer,
    this.emdadgarVehicleType,
    this.emdadgarNavganType,
    this.emdadgarMobileNumber,
    this.emdadgarLatitude,
    this.emdadgarLongitude,
    this.serviceCategoryIds,
    this.serviceIds,
    this.serviceTitles,
    this.serviceCategoryGivenIds,
    this.serviceCategoryGivenTitles,
    this.serviceGivenIds,
    this.customerDisabilityDesc,
    this.customerDisabilityTitle,
    this.cancelReasonTitle,
    this.cancelDesc,
    this.customerKilometer,
    this.defectTitle,
    this.defectId,
    this.insertDateTimeJalali,
  });

  ActiveServiceRequestResponseEntity copyWith({
    int? id,
    int? serviceType,
    int? planningId,
    int? emdadgarId,
    int? trackCode,
    int? channelType,
    String? emdadgarFullName,
    String? firstName,
    String? lastName,
    int? requestStatus,
    String? requestStatusTitle,
    String? requestState,
    String? requestStateTitle,
    String? personType,
    String? personTypeTitle,
    String? insertDateTime,
    bool? subscription,
    bool? guaranty,
    String? invoiceDocumentGuid,
    String? chassisNumber,
    int? kilometer,
    String? carName,
    String? serviceCategoryTitle,
    String? serviceCategoryGivenTitle,
    String? requestDateTimeJalali,
    String? gender,
    int? callLogId,
    String? nationalNumber,
    double? latitude,
    double? longitude,
    String? aidAddress,
    String? vin,
    String? licensePlate,
    int? saipaKilometer,
    String? description,
    int? customerDisability,
    String? customerDisabilityTitle,
    String? customerDisabilityDesc,
    String? customerMobileNumber,
    int? carModelId,
    String? carEngineNumber,
    String? carGuid,
    bool? foreigner,
    String? cancelReasonTitle,
    String? cancelDesc,
    String? carColor,
    String? carColorTitle,
    bool? vip,
    String? assignDescription,
    String? etmamRequestAuthor,
    String? etmamRequestDate,
    String? lastFollowUpTitle,
    String? assignDate,
    String? assignTime,
    String? trackGuid,
    bool? trafficPlan,
    int? vipConditionId,
    String? vipConditionTitle,
    int? cityId,
    int? evaluationId,
    double? distanceToCustomer,
    String? evaluationDescription,
    String? arriveDateTime,
    int? evaluationKilometer,
    String? emdadgarVehicleType,
    String? emdadgarNavganType,
    String? emdadgarMobileNumber,
    double? emdadgarLatitude,
    double? emdadgarLongitude,
    List<int>? serviceCategoryIds,
    List<int>? serviceIds,
    List<String>? serviceTitles,
    List<int>? serviceCategoryGivenIds,
    List<String>? serviceCategoryGivenTitles,
    List<int>? serviceGivenIds,
    String? customerKilometer,
    int? defectId,
    String? defectTitle,
    String? insertDateTimeJalali,
  }) {
    return ActiveServiceRequestResponseEntity(
      id: id ?? this.id,
      defectId: defectId ?? this.defectId,
      defectTitle: defectTitle ?? this.defectTitle,
      serviceType: serviceType ?? this.serviceType,
      planningId: planningId ?? this.planningId,
      emdadgarId: emdadgarId ?? this.emdadgarId,
      trackCode: trackCode ?? this.trackCode,
      channelType: channelType ?? this.channelType,
      emdadgarFullName: emdadgarFullName ?? this.emdadgarFullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      requestStatus: requestStatus ?? this.requestStatus,
      requestStatusTitle: requestStatusTitle ?? this.requestStatusTitle,
      requestState: requestState ?? this.requestState,
      requestStateTitle: requestStateTitle ?? this.requestStateTitle,
      personType: personType ?? this.personType,
      personTypeTitle: personTypeTitle ?? this.personTypeTitle,
      subscription: subscription ?? this.subscription,
      guaranty: guaranty ?? this.guaranty,
      invoiceDocumentGuid: invoiceDocumentGuid ?? this.invoiceDocumentGuid,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      kilometer: kilometer ?? this.kilometer,
      carName: carName ?? this.carName,
      serviceCategoryTitle: serviceCategoryTitle ?? this.serviceCategoryTitle,
      serviceCategoryGivenTitle:
          serviceCategoryGivenTitle ?? this.serviceCategoryGivenTitle,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      requestDateTimeJalali:
          requestDateTimeJalali ?? this.requestDateTimeJalali,
      gender: gender ?? this.gender,
      callLogId: callLogId ?? this.callLogId,
      nationalNumber: nationalNumber ?? this.nationalNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      aidAddress: aidAddress ?? this.aidAddress,
      vin: vin ?? this.vin,
      licensePlate: licensePlate ?? this.licensePlate,
      saipaKilometer: saipaKilometer ?? this.saipaKilometer,
      description: description ?? this.description,
      customerDisability: customerDisability ?? this.customerDisability,
      customerDisabilityTitle:
          customerDisabilityTitle ?? this.customerDisabilityTitle,
      customerDisabilityDesc:
          customerDisabilityDesc ?? this.customerDisabilityDesc,
      customerMobileNumber: customerMobileNumber ?? this.customerMobileNumber,
      carModelId: carModelId ?? this.carModelId,
      carEngineNumber: carEngineNumber ?? this.carEngineNumber,
      carGuid: carGuid ?? this.carGuid,
      foreigner: foreigner ?? this.foreigner,
      cancelReasonTitle: cancelReasonTitle ?? this.cancelReasonTitle,
      cancelDesc: cancelDesc ?? this.cancelDesc,
      carColor: carColor ?? this.carColor,
      carColorTitle: carColorTitle ?? this.carColorTitle,
      vip: vip ?? this.vip,
      assignDescription: assignDescription ?? this.assignDescription,
      etmamRequestAuthor: etmamRequestAuthor ?? this.etmamRequestAuthor,
      etmamRequestDate: etmamRequestDate ?? this.etmamRequestDate,
      lastFollowUpTitle: lastFollowUpTitle ?? this.lastFollowUpTitle,
      assignDate: assignDate ?? this.assignDate,
      assignTime: assignTime ?? this.assignTime,
      trackGuid: trackGuid ?? this.trackGuid,
      trafficPlan: trafficPlan ?? this.trafficPlan,
      vipConditionId: vipConditionId ?? this.vipConditionId,
      vipConditionTitle: vipConditionTitle ?? this.vipConditionTitle,
      cityId: cityId ?? this.cityId,
      evaluationId: evaluationId ?? this.evaluationId,
      distanceToCustomer: distanceToCustomer ?? this.distanceToCustomer,
      evaluationDescription:
          evaluationDescription ?? this.evaluationDescription,
      arriveDateTime: arriveDateTime ?? this.arriveDateTime,
      evaluationKilometer: evaluationKilometer ?? this.evaluationKilometer,
      emdadgarVehicleType: emdadgarVehicleType ?? this.emdadgarVehicleType,
      emdadgarNavganType: emdadgarNavganType ?? this.emdadgarNavganType,
      emdadgarMobileNumber: emdadgarMobileNumber ?? this.emdadgarMobileNumber,
      emdadgarLatitude: emdadgarLatitude ?? this.emdadgarLatitude,
      emdadgarLongitude: emdadgarLongitude ?? this.emdadgarLongitude,
      serviceCategoryIds: serviceCategoryIds ?? this.serviceCategoryIds,
      serviceIds: serviceIds ?? this.serviceIds,
      serviceTitles: serviceTitles ?? this.serviceTitles,
      serviceCategoryGivenIds:
          serviceCategoryGivenIds ?? this.serviceCategoryGivenIds,
      serviceCategoryGivenTitles:
          serviceCategoryGivenTitles ?? this.serviceCategoryGivenTitles,
      serviceGivenIds: serviceGivenIds ?? this.serviceGivenIds,
      customerKilometer: customerKilometer ?? this.customerKilometer,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
    );
  }

  ActiveServiceRequestResponseModel toModel() {
    return ActiveServiceRequestResponseModel(
      defectId: defectId,
      defectTitle: defectTitle,
      id: id,
      serviceType: serviceType,
      planningId: planningId,
      emdadgarId: emdadgarId,
      trackCode: trackCode,
      channelType: channelType,
      emdadgarFullName: emdadgarFullName,
      firstName: firstName,
      lastName: lastName,
      requestStatus: requestStatus,
      requestStatusTitle: requestStatusTitle,
      requestState: requestState,
      requestStateTitle: requestStateTitle,
      personType: personType,
      personTypeTitle: personTypeTitle,
      subscription: subscription,
      guaranty: guaranty,
      invoiceDocumentGuid: invoiceDocumentGuid,
      chassisNumber: chassisNumber,
      kilometer: kilometer,
      carName: carName,
      serviceCategoryTitle: serviceCategoryTitle,
      serviceCategoryGivenTitle: serviceCategoryGivenTitle,
      insertDateTime: insertDateTime,
      requestDateTimeJalali: requestDateTimeJalali,
      gender: gender,
      callLogId: callLogId,
      nationalNumber: nationalNumber,
      latitude: latitude,
      longitude: longitude,
      aidAddress: aidAddress,
      vin: vin,
      licensePlate: licensePlate,
      saipaKilometer: saipaKilometer,
      description: description,
      customerDisability: customerDisability,
      customerDisabilityTitle: customerDisabilityTitle,
      customerDisabilityDesc: customerDisabilityDesc,
      customerMobileNumber: customerMobileNumber,
      carModelId: carModelId,
      carEngineNumber: carEngineNumber,
      carGuid: carGuid,
      foreigner: foreigner,
      cancelReasonTitle: cancelReasonTitle,
      cancelDesc: cancelDesc,
      carColor: carColor,
      carColorTitle: carColorTitle,
      vip: vip,
      assignDescription: assignDescription,
      etmamRequestAuthor: etmamRequestAuthor,
      etmamRequestDate: etmamRequestDate,
      lastFollowUpTitle: lastFollowUpTitle,
      assignDate: assignDate,
      assignTime: assignTime,
      trackGuid: trackGuid,
      trafficPlan: trafficPlan,
      vipConditionId: vipConditionId,
      vipConditionTitle: vipConditionTitle,
      cityId: cityId,
      evaluationId: evaluationId,
      distanceToCustomer: distanceToCustomer,
      evaluationDescription: evaluationDescription,
      arriveDateTime: arriveDateTime,
      evaluationKilometer: evaluationKilometer,
      emdadgarVehicleType: emdadgarVehicleType,
      emdadgarNavganType: emdadgarNavganType,
      emdadgarMobileNumber: emdadgarMobileNumber,
      emdadgarLatitude: emdadgarLatitude,
      emdadgarLongitude: emdadgarLongitude,
      serviceCategoryIds: serviceCategoryIds,
      serviceIds: serviceIds,
      serviceTitles: serviceTitles,
      serviceCategoryGivenIds: serviceCategoryGivenIds,
      serviceCategoryGivenTitles: serviceCategoryGivenTitles,
      serviceGivenIds: serviceGivenIds,
      customerKilometer: customerKilometer,
      insertDateTimeJalali: insertDateTimeJalali,
    );
  }
}
