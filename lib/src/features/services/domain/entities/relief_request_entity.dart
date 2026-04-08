import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';

import 'abstract/base_request_entity.dart';

class ReliefRequestEntity extends BaseRequestEntity {
  final int defectId;
  final String defectTitle;

  final bool isUrgentRequest;

  final String emdadServiceTitle;

  const ReliefRequestEntity({
    required super.id,
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
    required this.defectId,
    required this.defectTitle,
    required this.isUrgentRequest,
    required this.emdadServiceTitle,
  });

  ReliefRequestEntity copyWith({
    bool? isUrgentRequest,
  }) {
    return ReliefRequestEntity(
      id: id,
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
      id: id,
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
    );
  }
}
