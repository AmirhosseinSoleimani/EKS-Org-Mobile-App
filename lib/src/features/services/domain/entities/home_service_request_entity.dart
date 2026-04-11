import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';

import 'abstract/base_request_entity.dart';

class HomeServiceRequestEntity extends BaseRequestEntity {
  final String requestDay;
  final String bookedDateTimeJalali;

  final String emdadServiceCategoryTitle;
  final String emdadgarName;

  final String agencyName;
  final String agencyCode;

  final String? requestDateTime;
  final String? requestDayTime;
  final bool? vip;
  final String? vipConditionTitle;
  final String? emdadProductTitle;

  const HomeServiceRequestEntity({
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
    super.customerMobileNumber,
    super.description,
    super.carColorTitle,
    super.carEngineNumber,
    super.genderTitle,
    super.personTypeTitle,
    required this.requestDay,
    required this.bookedDateTimeJalali,
    required this.emdadServiceCategoryTitle,
    required this.emdadgarName,
    required this.agencyName,
    required this.agencyCode,
    this.requestDateTime,
    this.requestDayTime,
    this.vip,
    this.vipConditionTitle,
    this.emdadProductTitle,
  });

  HomeServiceRequestEntity copyWith({
    String? requestDay,
    String? bookedDateTimeJalali,
  }) {
    return HomeServiceRequestEntity(
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
      requestDay: requestDay ?? this.requestDay,
      bookedDateTimeJalali: bookedDateTimeJalali ?? this.bookedDateTimeJalali,
      emdadServiceCategoryTitle: emdadServiceCategoryTitle,
      emdadgarName: emdadgarName,
      agencyName: agencyName,
      agencyCode: agencyCode,
    );
  }

  HomeServiceRequestModel toModel() {
    return HomeServiceRequestModel(
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
      requestDay: requestDay,
      bookedDateTimeJalali: bookedDateTimeJalali,
      emdadServiceCategoryTitle: emdadServiceCategoryTitle,
      emdadgarName: emdadgarName,
      agencyName: agencyName,
      agencyCode: agencyCode,
    );
  }
}
