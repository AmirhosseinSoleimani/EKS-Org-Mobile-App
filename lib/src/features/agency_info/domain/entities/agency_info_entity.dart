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

  AgencyInfoEntity copyWith({
    int? id,
    String? code,
    String? name,
    int? type,
    String? typeTitle,
    String? managerFirstName,
    String? managerLastName,
    String? provinceTitle,
    String? cityTitle,
    String? address,
    String? mobileNumber,
    String? telephone,
    String? postalCode,
    String? nationalNumber,
    String? economicCode,
    String? detailCode,
    String? trackingNumber,
    String? taxStatusTitle,
    bool? isActive,
    String? insertUserFullName,
    String? updateUserFullName,
    String? insertDateTimeJalali,
    String? updateDateTimeJalali,
  }) {
    return AgencyInfoEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      typeTitle: typeTitle ?? this.typeTitle,
      managerFirstName: managerFirstName ?? this.managerFirstName,
      managerLastName: managerLastName ?? this.managerLastName,
      provinceTitle: provinceTitle ?? this.provinceTitle,
      cityTitle: cityTitle ?? this.cityTitle,
      address: address ?? this.address,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      telephone: telephone ?? this.telephone,
      postalCode: postalCode ?? this.postalCode,
      nationalNumber: nationalNumber ?? this.nationalNumber,
      economicCode: economicCode ?? this.economicCode,
      detailCode: detailCode ?? this.detailCode,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      taxStatusTitle: taxStatusTitle ?? this.taxStatusTitle,
      isActive: isActive ?? this.isActive,
      insertUserFullName: insertUserFullName ?? this.insertUserFullName,
      updateUserFullName: updateUserFullName ?? this.updateUserFullName,
      insertDateTimeJalali:
          insertDateTimeJalali ?? this.insertDateTimeJalali,
      updateDateTimeJalali:
          updateDateTimeJalali ?? this.updateDateTimeJalali,
    );
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
