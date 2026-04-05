import 'package:eks_sana_plus_org/src/features/requests/data/models/location_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
class RequestModel extends RequestEntity {
  const RequestModel({
    super.id,
    super.requestNo,
    super.requestDate,
    super.status,
    super.statusTitle,
    super.type,
    super.chassisNo,
    super.licensePlate,
    super.distanceTraveledKm,
    super.lastName,
    super.khedmatResanFullName,
    super.khedmatResanCode,
    super.typeTitle,
    super.actions,
    super.defectId,
    super.defectTitle,
    super.defectDescription,
    super.nationalCode,
    super.firstName,
    super.submitDate,
    super.submitTime,
    super.serviceDate,
    super.serviceTime,
    super.hasSubscription,
    super.isGuaranty,
    super.carName,
    super.carModelId,
    super.location,
    super.callLogId,
    super.channelType,
    super.cityId,
    super.vin,
    super.gender,
    super.kilometer,
    super.evaluationKilometer,
    super.customerDisability,
    super.trackCode,
    super.carColor,
    super.customerDisabilityTitle,
    super.customerMobileNumber,
    super.carEngineNumber,
    super.carColorTitle,
    super.foreigner,
    super.vip,
    super.hasEmdadgarInvoice
  });


  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
      requestNo: json['requestNo'],
      requestDate: json['requestDate'],
      status: json['status'],
      statusTitle: json['statusTitle'],
      type: json['type'],
      chassisNo: json['chassisNo'],
      licensePlate: json['licensePlate'],
      distanceTraveledKm: json['distanceTraveledKm'],
      lastName: json['lastName'],
      khedmatResanFullName: json['khedmatResanFullName'],
      khedmatResanCode: json['khedmatResanCode'],
      typeTitle: json['typeTitle'],
      defectId: json['defectId'],
      defectTitle: json['defectTitle'],
      defectDescription: json['defectDescription'],
      nationalCode: json['nationalCode'],
      firstName: json['firstName'],
      submitDate: json['submitDate'],
      submitTime: json['submitTime'],
      serviceDate: json['serviceDate'],
      serviceTime: json['serviceTime'],
      hasSubscription: json['hasSubscription'],
      isGuaranty: json['isGaranty'],
      carName: json['carName'],
      carModelId: json['carModelId'],
      hasEmdadgarInvoice: json['hasEmdadgarInvoice'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      actions: (json['actions'] != null) ? (json['actions'] as List).map((e) =>
          RequestHistoryActionsModel.fromJson(e)).toList() : [],
    );
  }
}

class RequestHistoryActionsModel extends RequestHistoryActionsEntity {
  const RequestHistoryActionsModel({
    super.name,
    super.code,
    super.extra,
  });

  factory RequestHistoryActionsModel.fromJson(Map<String, dynamic> json) {
    return RequestHistoryActionsModel(
        name: json['name'],
        code: json['code'],
        extra: json['extra'],
    );
  }
}
