import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_contract_model.dart';

class AgencyContractEntity {
  const AgencyContractEntity({
    this.id,
    this.agencyId,
    this.title,
    this.contractNo,
    this.contractGuid,
    this.fileBase64,
    this.fileType,
    this.fileTypeTitle,
    this.startDate,
    this.startDateJalali,
    this.expireDate,
    this.expireDateJalali,
  });

  final int? id;
  final int? agencyId;
  final String? title;
  final String? contractNo;
  final String? contractGuid;
  final String? fileBase64;
  final int? fileType;
  final String? fileTypeTitle;
  final String? startDate;
  final String? startDateJalali;
  final String? expireDate;
  final String? expireDateJalali;

  bool get isActive {
    final expirationDate = DateTime.tryParse(expireDate?.trim() ?? '');

    if (expirationDate == null) {
      return false;
    }

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final contractExpirationDate = DateTime(
      expirationDate.year,
      expirationDate.month,
      expirationDate.day,
    );

    return !contractExpirationDate.isBefore(today);
  }

  AgencyContractModel toModel() {
    return AgencyContractModel(
      id: id,
      agencyId: agencyId,
      title: title,
      contractNo: contractNo,
      contractGuid: contractGuid,
      fileBase64: fileBase64,
      fileType: fileType,
      fileTypeTitle: fileTypeTitle,
      startDate: startDate,
      startDateJalali: startDateJalali,
      expireDate: expireDate,
      expireDateJalali: expireDateJalali,
    );
  }

  AgencyContractEntity copyWith({
    int? id,
    int? agencyId,
    String? title,
    String? contractNo,
    String? contractGuid,
    String? fileBase64,
    int? fileType,
    String? fileTypeTitle,
    String? startDate,
    String? startDateJalali,
    String? expireDate,
    String? expireDateJalali,
  }) {
    return AgencyContractEntity(
      id: id ?? this.id,
      agencyId: agencyId ?? this.agencyId,
      title: title ?? this.title,
      contractNo: contractNo ?? this.contractNo,
      contractGuid: contractGuid ?? this.contractGuid,
      fileBase64: fileBase64 ?? this.fileBase64,
      fileType: fileType ?? this.fileType,
      fileTypeTitle: fileTypeTitle ?? this.fileTypeTitle,
      startDate: startDate ?? this.startDate,
      startDateJalali: startDateJalali ?? this.startDateJalali,
      expireDate: expireDate ?? this.expireDate,
      expireDateJalali: expireDateJalali ?? this.expireDateJalali,
    );
  }
}