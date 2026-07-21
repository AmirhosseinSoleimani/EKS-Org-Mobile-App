class AddRescuerParamModel {
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

  const AddRescuerParamModel({required this.imageBase64, required this.firstName, required this.lastName, required this.fatherName, required this.nationalNumber, required this.birthDate, required this.cityIdPlaceOfBirth, required this.cityIdIssuingPlace, required this.cityIdAddress, required this.degree, required this.fieldGraduation, required this.marital, required this.address, required this.shoesSize, required this.clothingSize, required this.cooperationStartDate, required this.isActive, required this.licenseCode, required this.tel, required this.mobile});

  Map<String, dynamic> toJson() => {
    'imageBase64': imageBase64,
    'firstName': firstName,
    'lastName': lastName,
    'fatherName': fatherName,
    'nationalNumber': nationalNumber,
    'birthDate': birthDate,
    'cityIdPlaceOfBirth': cityIdPlaceOfBirth,
    'cityIdIssuingPlace': cityIdIssuingPlace,
    'cityIdAddress': cityIdAddress,
    'degree': degree,
    'fieldGraduation': fieldGraduation,
    'marital': marital,
    'address': address,
    'shoesSize': shoesSize,
    'clothingSize': clothingSize,
    'cooperationStartDate': cooperationStartDate,
    'isActive': isActive,
    'licenseCode': licenseCode,
    'tel': tel,
    'mobile': mobile,
  };
}
