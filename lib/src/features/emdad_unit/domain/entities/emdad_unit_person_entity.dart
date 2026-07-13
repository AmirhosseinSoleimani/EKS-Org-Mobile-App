class EmdadUnitPersonEntity {
  const EmdadUnitPersonEntity({
    this.id,
    this.emdadUnitId,
    this.emdadUnitTitle,
    this.agencyInfoId,
    this.agencyInfoTitle,
    this.agencyPersonId,
    this.personInfoId,
    this.code,
    this.mobile,
    this.firstName,
    this.lastName,
    this.nationalNumber,
    this.isActive,
  });

  final int? id;
  final int? emdadUnitId;
  final String? emdadUnitTitle;
  final int? agencyInfoId;
  final String? agencyInfoTitle;
  final int? agencyPersonId;
  final int? personInfoId;
  final String? code;
  final String? mobile;
  final String? firstName;
  final String? lastName;
  final String? nationalNumber;
  final bool? isActive;

  String get fullName => [firstName, lastName]
      .where((item) => item != null && item.trim().isNotEmpty)
      .join(' ');
}
