class VehicleHistoryEntity {
  const VehicleHistoryEntity({
    required this.id,
    this.insertDateTimeJalali,
    this.referenceId,
    this.description,
    this.insertUserName,
    this.entityType,
    this.actionType,
    this.entityTypeTitle,
  });

  final int id;
  final String? insertDateTimeJalali;
  final String? referenceId;
  final String? description;
  final String? insertUserName;
  final int? entityType;
  final int? actionType;
  final String? entityTypeTitle;
}
