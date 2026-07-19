import 'package:eks_sana_plus_org/src/features/rescuer/data/models/san_history_model.dart';

class SanHistoryEntity {
  final int? id;
  final String? insertDateTimeJalali;
  final String? referenceId;
  final String? description;
  final String? insertUserName;
  final int? entityType;
  final int? actionType;
  final String? entityTypeTitle;
  final String? currentEntity;

  const SanHistoryEntity({
    this.id,
    this.insertDateTimeJalali,
    this.referenceId,
    this.description,
    this.insertUserName,
    this.entityType,
    this.actionType,
    this.entityTypeTitle,
    this.currentEntity,
  });

  SanHistoryModel toModel() {
    return SanHistoryModel(
      id: id,
      insertDateTimeJalali: insertDateTimeJalali,
      referenceId: referenceId,
      description: description,
      insertUserName: insertUserName,
      entityType: entityType,
      actionType: actionType,
      entityTypeTitle: entityTypeTitle,
      currentEntity: currentEntity,
    );
  }

  SanHistoryEntity copyWith({
    int? id,
    String? insertDateTimeJalali,
    String? referenceId,
    String? description,
    String? insertUserName,
    int? entityType,
    int? actionType,
    String? entityTypeTitle,
    String? currentEntity,
  }) {
    return SanHistoryEntity(
      id: id ?? this.id,
      insertDateTimeJalali:
          insertDateTimeJalali ?? this.insertDateTimeJalali,
      referenceId: referenceId ?? this.referenceId,
      description: description ?? this.description,
      insertUserName: insertUserName ?? this.insertUserName,
      entityType: entityType ?? this.entityType,
      actionType: actionType ?? this.actionType,
      entityTypeTitle: entityTypeTitle ?? this.entityTypeTitle,
      currentEntity: currentEntity ?? this.currentEntity,
    );
  }
}
