import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_model.dart';

class AgencyInfoEntity {
  const AgencyInfoEntity({
    this.id,
    this.code,
    this.name,
    this.type,
    this.typeTitle,
    this.managerFirstName,
    this.managerLastName,
    this.provinceTitle,
    this.cityTitle,
    this.address,
    this.mobileNumber,
    this.telephone,
    this.postalCode,
    this.nationalNumber,
    this.economicCode,
    this.detailCode,
    this.trackingNumber,
    this.taxStatusTitle,
    this.isActive,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTimeJalali,
    this.updateDateTimeJalali,
  });

  final int? id;
  final String? code;
  final String? name;
  final int? type;
  final String? typeTitle;
  final String? managerFirstName;
  final String? managerLastName;
  final String? provinceTitle;
  final String? cityTitle;
  final String? address;
  final String? mobileNumber;
  final String? telephone;
  final String? postalCode;
  final String? nationalNumber;
  final String? economicCode;
  final String? detailCode;
  final String? trackingNumber;
  final String? taxStatusTitle;
  final bool? isActive;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTimeJalali;
  final String? updateDateTimeJalali;

  String get title {
    final trimmedName = name?.trim();
    if (trimmedName != null && trimmedName.isNotEmpty) {
      return trimmedName;
    }

    final trimmedCode = code?.trim();
    if (trimmedCode != null && trimmedCode.isNotEmpty) {
      return trimmedCode;
    }

    return '---';
  }

  String get managerFullName {
    return [managerFirstName, managerLastName]
        .where((item) => item?.trim().isNotEmpty == true)
        .join(' ')
        .trim();
  }

  AgencyInfoModel toModel() {
    return AgencyInfoModel(
      id: id,
      code: code,
      name: name,
      type: type,
      typeTitle: typeTitle,
      managerFirstName: managerFirstName,
      managerLastName: managerLastName,
      provinceTitle: provinceTitle,
      cityTitle: cityTitle,
      address: address,
      mobileNumber: mobileNumber,
      telephone: telephone,
      postalCode: postalCode,
      nationalNumber: nationalNumber,
      economicCode: economicCode,
      detailCode: detailCode,
      trackingNumber: trackingNumber,
      taxStatusTitle: taxStatusTitle,
      isActive: isActive,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTimeJalali: insertDateTimeJalali,
      updateDateTimeJalali: updateDateTimeJalali,
    );
  }
}
