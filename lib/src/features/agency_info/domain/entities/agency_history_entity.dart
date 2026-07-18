import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_history_model.dart';

class AgencyHistoryEntity {
  const AgencyHistoryEntity({
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

  final int? id;
  final String? insertDateTimeJalali;
  final String? referenceId;
  final String? description;
  final String? insertUserName;
  final int? entityType;
  final int? actionType;
  final String? entityTypeTitle;
  final String? currentEntity;

  AgencyHistoryModel toModel() {
    return AgencyHistoryModel(
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

  AgencyHistoryEntity copyWith({
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
    return AgencyHistoryEntity(
      id: id ?? this.id,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
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
