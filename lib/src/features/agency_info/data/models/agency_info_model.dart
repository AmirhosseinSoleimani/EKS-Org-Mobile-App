import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';

class AgencyInfoModel extends AgencyInfoEntity {
  const AgencyInfoModel({
    super.id,
    super.code,
    super.name,
    super.type,
    super.typeTitle,
    super.managerFirstName,
    super.managerLastName,
    super.provinceTitle,
    super.cityTitle,
    super.address,
    super.mobileNumber,
    super.telephone,
    super.email,
    super.fax,
    super.postalCode,
    super.nationalNumber,
    super.agencyNationalId,
    super.economicCode,
    super.detailCode,
    super.trackingNumber,
    super.taxStatusTitle,
    super.taxFileCompleted,
    super.statusTitle,
    super.isActive,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTimeJalali,
    super.updateDateTimeJalali,
  });

  factory AgencyInfoModel.fromJson(Map<String, dynamic> json) {
    return AgencyInfoModel(
      id: json['id'] as int?,
      code: _string(json, ['code', 'agencyCode', 'labelAgencyCode']),
      name: _string(json, ['name', 'title', 'agencyInfoTitle', 'agencyInfoName']),
      type: json['type'] as int?,
      typeTitle: _string(json, ['typeTitle', 'agencyTypeTitle']),
      managerFirstName: _string(json, ['managerFirstName']),
      managerLastName: _string(json, ['managerLastName']),
      provinceTitle: _string(json, ['provinceTitle', 'provinceName']),
      cityTitle: _string(json, ['cityTitle', 'cityName']),
      address: _string(json, ['address']),
      mobileNumber: _string(json, ['mobileNumber', 'mobile', 'managerMobileNumber']),
      telephone: _string(json, ['telephone', 'tel', 'phoneNumber']),
      email: _string(json, ['email']),
      fax: _string(json, ['fax']),
      postalCode: _string(json, ['postalCode']),
      nationalNumber: _string(json, ['nationalNo']),
      agencyNationalId: _string(json, ['agencyNationalId']),
      economicCode: _string(json, ['economicCode']),
      detailCode: _string(json, ['detailCode', 'detailedCode']),
      trackingNumber: _string(json, ['trackingNumber']),
      taxStatusTitle: _string(json, ['taxStatusTitle']),
      taxFileCompleted: _boolean(json['taxFileCompleted']),
      statusTitle: _string(json, ['statusTitle']),
      isActive: json['isActive'] as bool?,
      insertUserFullName: _string(json, ['insertUserFullName']),
      updateUserFullName: _string(json, ['updateUserFullName']),
      insertDateTimeJalali: _string(json, ['insertDateTimeJalali']),
      updateDateTimeJalali: _string(json, ['updateDateTimeJalali']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'type': type,
      'typeTitle': typeTitle,
      'managerFirstName': managerFirstName,
      'managerLastName': managerLastName,
      'provinceTitle': provinceTitle,
      'cityTitle': cityTitle,
      'address': address,
      'mobileNumber': mobileNumber,
      'telephone': telephone,
      'email': email,
      'fax': fax,
      'postalCode': postalCode,
      'nationalNumber': nationalNumber,
      'agencyNationalId': agencyNationalId,
      'economicCode': economicCode,
      'detailCode': detailCode,
      'trackingNumber': trackingNumber,
      'taxStatusTitle': taxStatusTitle,
      'taxFileCompleted': taxFileCompleted,
      'statusTitle': statusTitle,
      'isActive': isActive,
      'insertUserFullName': insertUserFullName,
      'updateUserFullName': updateUserFullName,
      'insertDateTimeJalali': insertDateTimeJalali,
      'updateDateTimeJalali': updateDateTimeJalali,
    };
  }

  static String? _string(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }

  static bool? _boolean(Object? value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized == 'true' || normalized == '1') return true;
      if (normalized == 'false' || normalized == '0') return false;
    }
    return null;
  }
}
