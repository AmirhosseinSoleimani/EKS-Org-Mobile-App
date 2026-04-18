abstract class BaseRequestEntity {
  final int? id;
  final int? trackCode;

  final String? firstName;
  final String? lastName;

  final String? chassisNumber;
  final int? kilometer;
  final String? nationalNumber;

  final double? latitude;
  final double? longitude;

  final String? aidAddress;

  final String? cityName;
  final String? provinceName;

  final String? carName;
  final int? carProductionYear;

  final String? licensePlate;

  final int? requestStatus;
  final String? requestStatusTitle;

  final String? requestDateJalali;
  final String? requestTime;

  final String? customerMobileNumber;
  final String? description;
  final String? carColorTitle;
  final String? carEngineNumber;
  final String? genderTitle;
  final String? personTypeTitle;
  final String? dispatcher;
  final bool? isGuaranty;
  final bool? isSubscription;

  //em info
  final String? emFullName;
  final String? emMobileNumber1;
  final String? emVehicleTypeTitle;
  final int? emVehicleType;
  final String? emVehicleSubTypeTitle;
  final int? emVehicleSubType;
  final String? emRepresentationName;
  final String? emRepresentationCode;

  const BaseRequestEntity({
    this.id,
    this.trackCode,
    this.firstName,
    this.lastName,
    this.latitude,
    this.longitude,
    this.aidAddress,
    this.cityName,
    this.provinceName,
    this.carName,
    this.carProductionYear,
    this.licensePlate,
    this.requestStatus,
    this.requestStatusTitle,
    this.requestDateJalali,
    this.requestTime,
    this.chassisNumber,
    this.kilometer,
    this.nationalNumber,
    this.customerMobileNumber,
    this.description,
    this.carColorTitle,
    this.carEngineNumber,
    this.genderTitle,
    this.personTypeTitle,
    this.emFullName,
    this.emMobileNumber1,
    this.emVehicleTypeTitle,
    this.emVehicleType,
    this.emVehicleSubTypeTitle,
    this.emVehicleSubType,
    this.dispatcher,
    this.emRepresentationName,
    this.emRepresentationCode,
    this.isGuaranty = false,
    this.isSubscription = false,
  });
}
