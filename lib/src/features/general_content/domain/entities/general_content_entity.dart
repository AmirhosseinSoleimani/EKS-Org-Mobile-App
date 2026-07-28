class GeneralContentEntity {
  const GeneralContentEntity({
    this.id,
    this.title,
    this.description,
    this.contentType,
    this.contentTypeText,
    this.receiverType,
    this.receiverTypeText,
    this.applyDate,
    this.applyDateJalali,
    this.startDate,
    this.startDateJalali,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.updateDateTime,
    this.updateDateTimeJalali,
    this.isActive,
  });

  final int? id;
  final String? title;
  final String? description;
  final int? contentType;
  final String? contentTypeText;
  final int? receiverType;
  final String? receiverTypeText;
  final String? applyDate;
  final String? applyDateJalali;
  final String? startDate;
  final String? startDateJalali;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? updateDateTime;
  final String? updateDateTimeJalali;
  final bool? isActive;
}
