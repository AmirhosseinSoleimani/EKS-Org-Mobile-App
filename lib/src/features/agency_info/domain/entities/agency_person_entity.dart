import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_person_model.dart';

class AgencyPersonEntity {
  const AgencyPersonEntity({
    this.id,
    this.agencyInfoId,
    this.personInfoId,
    this.contractStartDate,
    this.contractStartDateJalali,
    this.status,
    this.aidPersonMobile,
    this.statusTitle,
    this.jobPosition,
    this.issuanceOnIdCard,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.code,
    this.firstName,
    this.lastName,
    this.nationalNumber,
    this.cityNameIssuingPlace,
    this.provinceNameIssuingPlace,
    this.fieldGraduation,
    this.maritalTitle,
    this.mobile,
    this.address,
    this.activityType,
    this.isActive,
    this.isDeleted,
  });

  final int? id;
  final int? agencyInfoId;
  final int? personInfoId;
  final String? contractStartDate;
  final String? contractStartDateJalali;
  final int? status;
  final String? aidPersonMobile;
  final String? statusTitle;
  final String? jobPosition;
  final bool? issuanceOnIdCard;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? code;
  final String? firstName;
  final String? lastName;
  final String? nationalNumber;
  final String? cityNameIssuingPlace;
  final String? provinceNameIssuingPlace;
  final String? fieldGraduation;
  final String? maritalTitle;
  final String? mobile;
  final String? address;
  final int? activityType;
  final bool? isActive;
  final bool? isDeleted;

  AgencyPersonModel toModel() {
    return AgencyPersonModel(
      id: id,
      agencyInfoId: agencyInfoId,
      personInfoId: personInfoId,
      contractStartDate: contractStartDate,
      contractStartDateJalali: contractStartDateJalali,
      status: status,
      aidPersonMobile: aidPersonMobile,
      statusTitle: statusTitle,
      jobPosition: jobPosition,
      issuanceOnIdCard: issuanceOnIdCard,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      code: code,
      firstName: firstName,
      lastName: lastName,
      nationalNumber: nationalNumber,
      cityNameIssuingPlace: cityNameIssuingPlace,
      provinceNameIssuingPlace: provinceNameIssuingPlace,
      fieldGraduation: fieldGraduation,
      maritalTitle: maritalTitle,
      mobile: mobile,
      address: address,
      activityType: activityType,
      isActive: isActive,
      isDeleted: isDeleted,
    );
  }

  AgencyPersonEntity copyWith({
    int? id,
    int? agencyInfoId,
    int? personInfoId,
    String? contractStartDate,
    String? contractStartDateJalali,
    int? status,
    String? aidPersonMobile,
    String? statusTitle,
    String? jobPosition,
    bool? issuanceOnIdCard,
    String? insertUserFullName,
    String? updateUserFullName,
    String? insertDateTime,
    String? insertDateTimeJalali,
    String? code,
    String? firstName,
    String? lastName,
    String? nationalNumber,
    String? cityNameIssuingPlace,
    String? provinceNameIssuingPlace,
    String? fieldGraduation,
    String? maritalTitle,
    String? mobile,
    String? address,
    int? activityType,
    bool? isActive,
    bool? isDeleted,
  }) {
    return AgencyPersonEntity(
      id: id ?? this.id,
      agencyInfoId: agencyInfoId ?? this.agencyInfoId,
      personInfoId: personInfoId ?? this.personInfoId,
      contractStartDate: contractStartDate ?? this.contractStartDate,
      contractStartDateJalali: contractStartDateJalali ?? this.contractStartDateJalali,
      status: status ?? this.status,
      aidPersonMobile: aidPersonMobile ?? this.aidPersonMobile,
      statusTitle: statusTitle ?? this.statusTitle,
      jobPosition: jobPosition ?? this.jobPosition,
      issuanceOnIdCard: issuanceOnIdCard ?? this.issuanceOnIdCard,
      insertUserFullName: insertUserFullName ?? this.insertUserFullName,
      updateUserFullName: updateUserFullName ?? this.updateUserFullName,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      code: code ?? this.code,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nationalNumber: nationalNumber ?? this.nationalNumber,
      cityNameIssuingPlace: cityNameIssuingPlace ?? this.cityNameIssuingPlace,
      provinceNameIssuingPlace: provinceNameIssuingPlace ?? this.provinceNameIssuingPlace,
      fieldGraduation: fieldGraduation ?? this.fieldGraduation,
      maritalTitle: maritalTitle ?? this.maritalTitle,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      activityType: activityType ?? this.activityType,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
