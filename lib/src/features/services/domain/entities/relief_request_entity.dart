import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';

import 'abstract/base_request_entity.dart';

class ReliefRequestEntity extends BaseRequestEntity {
  final int defectId;
  final String defectTitle;

  final bool isUrgentRequest;

  final String emdadServiceTitle;

  final String? hamlReasonTitle;
  final String? wheelQuestionTitle;

  final String? emdadgarAssignDistanceTitle;
  final String? emdadgarAssignDurationTitle;

  final String? assignDate;
  final String? assignTime;

  final String? dispatcher;

  const ReliefRequestEntity({
    required super.trackCode,
    required super.firstName,
    required super.lastName,
    required super.latitude,
    required super.longitude,
    required super.aidAddress,
    required super.cityName,
    required super.provinceName,
    required super.carName,
    required super.carProductionYear,
    required super.licensePlate,
    required super.requestStatus,
    required super.requestStatusTitle,
    required super.requestDateJalali,
    required super.requestTime,
    super.customerMobileNumber,
    super.description,
    super.carColorTitle,
    super.carEngineNumber,
    super.genderTitle,
    super.personTypeTitle,
    required this.defectId,
    required this.defectTitle,
    required this.isUrgentRequest,
    required this.emdadServiceTitle,
    this.hamlReasonTitle,
    this.wheelQuestionTitle,
    this.emdadgarAssignDistanceTitle,
    this.emdadgarAssignDurationTitle,
    this.assignDate,
    this.assignTime,
    this.dispatcher,
  });

  ReliefRequestEntity copyWith({
    bool? isUrgentRequest,
  }) {
    return ReliefRequestEntity(
      trackCode: trackCode,
      firstName: firstName,
      lastName: lastName,
      latitude: latitude,
      longitude: longitude,
      aidAddress: aidAddress,
      cityName: cityName,
      provinceName: provinceName,
      carName: carName,
      carProductionYear: carProductionYear,
      licensePlate: licensePlate,
      requestStatus: requestStatus,
      requestStatusTitle: requestStatusTitle,
      requestDateJalali: requestDateJalali,
      requestTime: requestTime,
      defectId: defectId,
      defectTitle: defectTitle,
      isUrgentRequest: isUrgentRequest ?? this.isUrgentRequest,
      emdadServiceTitle: emdadServiceTitle,
    );
  }

  ReliefRequestModel toModel() {
    return ReliefRequestModel(
      trackCode: trackCode,
      firstName: firstName,
      lastName: lastName,
      latitude: latitude,
      longitude: longitude,
      aidAddress: aidAddress,
      cityName: cityName,
      provinceName: provinceName,
      carName: carName,
      carProductionYear: carProductionYear,
      licensePlate: licensePlate,
      requestStatus: requestStatus,
      requestStatusTitle: requestStatusTitle,
      requestDateJalali: requestDateJalali,
      requestTime: requestTime,
      defectId: defectId,
      defectTitle: defectTitle,
      isUrgentRequest: isUrgentRequest,
      emdadServiceTitle: emdadServiceTitle,
      customerMobileNumber: customerMobileNumber,
      description: description,
      carColorTitle: carColorTitle,
      carEngineNumber: carEngineNumber,
      genderTitle: genderTitle,
      personTypeTitle: personTypeTitle,
    );
  }
}
