import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';

class ReliefRequestModel extends ReliefRequestEntity {
  const ReliefRequestModel({
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
    required super.defectId,
    required super.defectTitle,
    required super.isUrgentRequest,
    required super.emdadServiceTitle,
    super.customerMobileNumber,
    super.description,
    super.carColorTitle,
    super.carEngineNumber,
    super.genderTitle,
    super.personTypeTitle,
  });

  factory ReliefRequestModel.fromJson(Map<String, dynamic> json) {
    return ReliefRequestModel(
      id: json['id'],
      trackCode: json['trackCode'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      aidAddress: json['aidAddress'],
      cityName: json['cityName'],
      provinceName: json['provinceName'],
      carName: json['carName'],
      carProductionYear: json['carProductionYear'],
      licensePlate: json['licensePlate'],
      requestStatus: json['requestStatus'],
      requestStatusTitle: json['requestStatusTitle'],
      requestDateJalali: json['requestDateJalali'],
      requestTime: json['requestTime'],
      defectId: json['defectId'],
      defectTitle: json['defectTitle'],
      isUrgentRequest: json['isUrgentRequest'],
      emdadServiceTitle: json['emdadServiceTitle'],
    );
  }
}
