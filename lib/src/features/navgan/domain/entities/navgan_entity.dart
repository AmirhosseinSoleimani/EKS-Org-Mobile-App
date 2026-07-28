class NavganEntity {
  const NavganEntity({
    this.id,
    this.emdadgarNavganType,
    this.title,
    this.code,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.updateDateTime,
    this.updateDateTimeJalali,
    this.isActive,
  });

  final int? id;
  final int? emdadgarNavganType;
  final String? title;
  final String? code;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? updateDateTime;
  final String? updateDateTimeJalali;
  final bool? isActive;
}
