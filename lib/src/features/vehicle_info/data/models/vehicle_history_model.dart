import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_history_entity.dart';

class VehicleHistoryModel extends VehicleHistoryEntity {
  const VehicleHistoryModel({
    required super.id,
    super.insertDateTimeJalali,
    super.referenceId,
    super.description,
    super.insertUserName,
    super.entityType,
    super.actionType,
    super.entityTypeTitle,
  });

  factory VehicleHistoryModel.fromJson(Map<String, dynamic> json) {
    return VehicleHistoryModel(
      id: json['id'] as int? ?? 0,
      insertDateTimeJalali: json['insertDateTimeJalali'] as String?,
      referenceId: json['referenceId']?.toString(),
      description: json['description'] as String?,
      insertUserName: json['insertUserName'] as String?,
      entityType: json['entityType'] as int?,
      actionType: json['actionType'] as int?,
      entityTypeTitle: json['entityTypeTitle'] as String?,
    );
  }
}
