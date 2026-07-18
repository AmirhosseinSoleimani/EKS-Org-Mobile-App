import 'package:eks_sana_plus_org/src/features/agency_info/data/models/person_info_search_model.dart';

class PersonInfoSearchEntity {
  const PersonInfoSearchEntity({
    this.id,
    this.code,
    this.firstName,
    this.lastName,
    this.nationalNumber,
    this.birthDate,
    this.birthDateJalali,
    this.fatherName,
    this.cityIdPlaceOfBirth,
    this.cityNamePlaceOfBirth,
    this.provinceNamePlaceOfBirth,
    this.cityIdIssuingPlace,
    this.cityNameIssuingPlace,
    this.provinceNameIssuingPlace,
    this.degree,
    this.degreeTitle,
    this.fieldGraduation,
    this.marital,
    this.maritalTitle,
    this.mobile,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.updateDateTime,
    this.updateDateTimeJalali,
    this.cityIdAddress,
    this.address,
    this.status,
    this.statusTitle,
    this.licenseCode,
    this.imageGuid,
    this.imageBase64,
    this.isCreateUserInfo,
    this.shoesSize,
    this.clothingSize,
    this.certificatesTitle,
    this.isActive,
    this.isDeleted,
  });

  final int? id;
  final String? code;
  final String? firstName;
  final String? lastName;
  final String? nationalNumber;
  final String? birthDate;
  final String? birthDateJalali;
  final String? fatherName;
  final int? cityIdPlaceOfBirth;
  final String? cityNamePlaceOfBirth;
  final String? provinceNamePlaceOfBirth;
  final int? cityIdIssuingPlace;
  final String? cityNameIssuingPlace;
  final String? provinceNameIssuingPlace;
  final int? degree;
  final String? degreeTitle;
  final String? fieldGraduation;
  final int? marital;
  final String? maritalTitle;
  final String? mobile;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? updateDateTime;
  final String? updateDateTimeJalali;
  final int? cityIdAddress;
  final String? address;
  final int? status;
  final String? statusTitle;
  final String? licenseCode;
  final String? imageGuid;
  final String? imageBase64;
  final bool? isCreateUserInfo;
  final int? shoesSize;
  final String? clothingSize;
  final String? certificatesTitle;
  final bool? isActive;
  final bool? isDeleted;

  PersonInfoSearchModel toModel() {
    return PersonInfoSearchModel(
      id: id,
      code: code,
      firstName: firstName,
      lastName: lastName,
      nationalNumber: nationalNumber,
      birthDate: birthDate,
      birthDateJalali: birthDateJalali,
      fatherName: fatherName,
      cityIdPlaceOfBirth: cityIdPlaceOfBirth,
      cityNamePlaceOfBirth: cityNamePlaceOfBirth,
      provinceNamePlaceOfBirth: provinceNamePlaceOfBirth,
      cityIdIssuingPlace: cityIdIssuingPlace,
      cityNameIssuingPlace: cityNameIssuingPlace,
      provinceNameIssuingPlace: provinceNameIssuingPlace,
      degree: degree,
      degreeTitle: degreeTitle,
      fieldGraduation: fieldGraduation,
      marital: marital,
      maritalTitle: maritalTitle,
      mobile: mobile,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      updateDateTime: updateDateTime,
      updateDateTimeJalali: updateDateTimeJalali,
      cityIdAddress: cityIdAddress,
      address: address,
      status: status,
      statusTitle: statusTitle,
      licenseCode: licenseCode,
      imageGuid: imageGuid,
      imageBase64: imageBase64,
      isCreateUserInfo: isCreateUserInfo,
      shoesSize: shoesSize,
      clothingSize: clothingSize,
      certificatesTitle: certificatesTitle,
      isActive: isActive,
      isDeleted: isDeleted,
    );
  }

  PersonInfoSearchEntity copyWith({
    int? id,
    String? code,
    String? firstName,
    String? lastName,
    String? nationalNumber,
    String? birthDate,
    String? birthDateJalali,
    String? fatherName,
    int? cityIdPlaceOfBirth,
    String? cityNamePlaceOfBirth,
    String? provinceNamePlaceOfBirth,
    int? cityIdIssuingPlace,
    String? cityNameIssuingPlace,
    String? provinceNameIssuingPlace,
    int? degree,
    String? degreeTitle,
    String? fieldGraduation,
    int? marital,
    String? maritalTitle,
    String? mobile,
    String? insertUserFullName,
    String? updateUserFullName,
    String? insertDateTime,
    String? insertDateTimeJalali,
    String? updateDateTime,
    String? updateDateTimeJalali,
    int? cityIdAddress,
    String? address,
    int? status,
    String? statusTitle,
    String? licenseCode,
    String? imageGuid,
    String? imageBase64,
    bool? isCreateUserInfo,
    int? shoesSize,
    String? clothingSize,
    String? certificatesTitle,
    bool? isActive,
    bool? isDeleted,
  }) {
    return PersonInfoSearchEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nationalNumber: nationalNumber ?? this.nationalNumber,
      birthDate: birthDate ?? this.birthDate,
      birthDateJalali: birthDateJalali ?? this.birthDateJalali,
      fatherName: fatherName ?? this.fatherName,
      cityIdPlaceOfBirth: cityIdPlaceOfBirth ?? this.cityIdPlaceOfBirth,
      cityNamePlaceOfBirth: cityNamePlaceOfBirth ?? this.cityNamePlaceOfBirth,
      provinceNamePlaceOfBirth: provinceNamePlaceOfBirth ?? this.provinceNamePlaceOfBirth,
      cityIdIssuingPlace: cityIdIssuingPlace ?? this.cityIdIssuingPlace,
      cityNameIssuingPlace: cityNameIssuingPlace ?? this.cityNameIssuingPlace,
      provinceNameIssuingPlace: provinceNameIssuingPlace ?? this.provinceNameIssuingPlace,
      degree: degree ?? this.degree,
      degreeTitle: degreeTitle ?? this.degreeTitle,
      fieldGraduation: fieldGraduation ?? this.fieldGraduation,
      marital: marital ?? this.marital,
      maritalTitle: maritalTitle ?? this.maritalTitle,
      mobile: mobile ?? this.mobile,
      insertUserFullName: insertUserFullName ?? this.insertUserFullName,
      updateUserFullName: updateUserFullName ?? this.updateUserFullName,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      updateDateTime: updateDateTime ?? this.updateDateTime,
      updateDateTimeJalali: updateDateTimeJalali ?? this.updateDateTimeJalali,
      cityIdAddress: cityIdAddress ?? this.cityIdAddress,
      address: address ?? this.address,
      status: status ?? this.status,
      statusTitle: statusTitle ?? this.statusTitle,
      licenseCode: licenseCode ?? this.licenseCode,
      imageGuid: imageGuid ?? this.imageGuid,
      imageBase64: imageBase64 ?? this.imageBase64,
      isCreateUserInfo: isCreateUserInfo ?? this.isCreateUserInfo,
      shoesSize: shoesSize ?? this.shoesSize,
      clothingSize: clothingSize ?? this.clothingSize,
      certificatesTitle: certificatesTitle ?? this.certificatesTitle,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
