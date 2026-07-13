import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_history_model.dart';

class VehicleHistoryEntity {
  final int? id;
  final String? insertDateTimeJalali;
  final String? referenceId;
  final String? description;
  final String? insertUserName;
  final int? entityType;
  final int? actionType;
  final String? entityTypeTitle;

  const VehicleHistoryEntity({
    this.id,
    this.insertDateTimeJalali,
    this.referenceId,
    this.description,
    this.insertUserName,
    this.entityType,
    this.actionType,
    this.entityTypeTitle,
  });

  VehicleHistoryModel toModel() {
    return VehicleHistoryModel(
      id: id,
      insertDateTimeJalali: insertDateTimeJalali,
      referenceId: referenceId,
      description: description,
      insertUserName: insertUserName,
      entityType: entityType,
      actionType: actionType,
      entityTypeTitle: entityTypeTitle,
    );
  }

  VehicleHistoryEntity copyWith({
    int? id,
    String? insertDateTimeJalali,
    String? referenceId,
    String? description,
    String? insertUserName,
    int? entityType,
    int? actionType,
    String? entityTypeTitle,
  }) {
    return VehicleHistoryEntity(
      id: id ?? this.id,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      referenceId: referenceId ?? this.referenceId,
      description: description ?? this.description,
      insertUserName: insertUserName ?? this.insertUserName,
      entityType: entityType ?? this.entityType,
      actionType: actionType ?? this.actionType,
      entityTypeTitle: entityTypeTitle ?? this.entityTypeTitle,
    );
  }
}
