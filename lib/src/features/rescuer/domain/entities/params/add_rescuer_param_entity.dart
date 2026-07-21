import 'package:eks_sana_plus_org/src/features/rescuer/data/models/params/add_rescuer_param_model.dart';

class AddRescuerParamEntity {
  final String? imageBase64;
  final String firstName;
  final String lastName;
  final String fatherName;
  final String nationalNumber;
  final String birthDate;
  final int? cityIdPlaceOfBirth;
  final int? cityIdIssuingPlace;
  final int? cityIdAddress;
  final int? degree;
  final String? fieldGraduation;
  final int? marital;
  final String address;
  final String? shoesSize;
  final String? clothingSize;
  final String cooperationStartDate;
  final bool isActive;
  final String? licenseCode;
  final String? tel;
  final String mobile;

  const AddRescuerParamEntity({
    this.imageBase64,
    this.firstName = '',
    this.lastName = '',
    this.fatherName = '',
    this.nationalNumber = '',
    this.birthDate = '',
    this.cityIdPlaceOfBirth,
    this.cityIdIssuingPlace,
    this.cityIdAddress,
    this.degree,
    this.fieldGraduation,
    this.marital,
    this.address = '',
    this.shoesSize,
    this.clothingSize,
    this.cooperationStartDate = '',
    this.isActive = true,
    this.licenseCode,
    this.tel,
    this.mobile = '',
  });

  AddRescuerParamEntity copyWith({
    String? imageBase64,
    String? firstName,
    String? lastName,
    String? fatherName,
    String? nationalNumber,
    String? birthDate,
    int? cityIdPlaceOfBirth,
    int? cityIdIssuingPlace,
    int? cityIdAddress,
    int? degree,
    String? fieldGraduation,
    int? marital,
    String? address,
    String? shoesSize,
    String? clothingSize,
    String? cooperationStartDate,
    bool? isActive,
    String? licenseCode,
    String? tel,
    String? mobile,
  }) => AddRescuerParamEntity(
    imageBase64: imageBase64 ?? this.imageBase64,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    fatherName: fatherName ?? this.fatherName,
    nationalNumber: nationalNumber ?? this.nationalNumber,
    birthDate: birthDate ?? this.birthDate,
    cityIdPlaceOfBirth: cityIdPlaceOfBirth ?? this.cityIdPlaceOfBirth,
    cityIdIssuingPlace: cityIdIssuingPlace ?? this.cityIdIssuingPlace,
    cityIdAddress: cityIdAddress ?? this.cityIdAddress,
    degree: degree ?? this.degree,
    fieldGraduation: fieldGraduation ?? this.fieldGraduation,
    marital: marital ?? this.marital,
    address: address ?? this.address,
    shoesSize: shoesSize ?? this.shoesSize,
    clothingSize: clothingSize ?? this.clothingSize,
    cooperationStartDate: cooperationStartDate ?? this.cooperationStartDate,
    isActive: isActive ?? this.isActive,
    licenseCode: licenseCode ?? this.licenseCode,
    tel: tel ?? this.tel,
    mobile: mobile ?? this.mobile,
  );

  AddRescuerParamModel toModel() => AddRescuerParamModel(
    imageBase64: imageBase64,
    firstName: firstName,
    lastName: lastName,
    fatherName: fatherName,
    nationalNumber: nationalNumber,
    birthDate: birthDate,
    cityIdPlaceOfBirth: cityIdPlaceOfBirth,
    cityIdIssuingPlace: cityIdIssuingPlace,
    cityIdAddress: cityIdAddress,
    degree: degree,
    fieldGraduation: fieldGraduation,
    marital: marital,
    address: address,
    shoesSize: shoesSize,
    clothingSize: clothingSize,
    cooperationStartDate: cooperationStartDate,
    isActive: isActive,
    licenseCode: licenseCode,
    tel: tel,
    mobile: mobile,
  );
}
