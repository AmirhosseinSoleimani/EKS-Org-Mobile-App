import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';

class HomeServiceRequestModel extends HomeServiceRequestEntity {
  const HomeServiceRequestModel({
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
    required super.requestDay,
    required super.bookedDateTimeJalali,
    required super.emdadServiceCategoryTitle,
    required super.emdadgarName,
    required super.agencyName,
    required super.agencyCode,
  });

  factory HomeServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceRequestModel(
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
      requestDay: json['requestDay'],
      bookedDateTimeJalali: json['bookedDateTimeJalali'],
      emdadServiceCategoryTitle: json['emdadServiceCategoryTitle'],
      emdadgarName: json['emdadgarName'] ?? '',
      agencyName: json['agencyName'] ?? '',
      agencyCode: json['agencyCode'] ?? '',
    );
  }
}
