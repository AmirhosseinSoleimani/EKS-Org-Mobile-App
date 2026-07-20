class AddAgencyInfoRequestModel {
  const AddAgencyInfoRequestModel({
    required this.code,
    required this.name,
    required this.nationalNo,
    required this.economicCode,
    required this.mobile,
    required this.cityId,
    required this.postalCode,
    required this.address,
    this.type,
    this.managerFirstName,
    this.managerLastName,
    this.tel,
    this.fax,
    this.email,
    this.hasTax = false,
    this.shabaNumber,
    this.isActive = true,
  });

  final String code;
  final String name;
  final int? type;
  final String? managerFirstName;
  final String? managerLastName;
  final String nationalNo;
  final String economicCode;
  final String? tel;
  final String mobile;
  final String? fax;
  final String? email;
  final bool hasTax;
  final int cityId;
  final String postalCode;
  final String? shabaNumber;
  final bool isActive;
  final String address;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'type': type?.toString(),
      'managerFirstName': managerFirstName ?? '',
      'managerLastName': managerLastName ?? '',
      'nationalNo': nationalNo,
      'economicCode': economicCode,
      'tel': tel ?? '',
      'mobile': mobile,
      'fax': fax ?? '',
      'email': email ?? '',
      'hasTax': hasTax,
      'cityId': cityId,
      'postalCode': postalCode,
      'shabaNumber': shabaNumber ?? '',
      'isActive': isActive,
      'address': address,
    };
  }
}
