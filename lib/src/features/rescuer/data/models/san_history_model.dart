import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/san_history_entity.dart';

class SanHistoryModel extends SanHistoryEntity {
  const SanHistoryModel({
    super.id,
    super.insertDateTimeJalali,
    super.referenceId,
    super.description,
    super.insertUserName,
    super.entityType,
    super.actionType,
    super.entityTypeTitle,
    super.currentEntity,
  });

  factory SanHistoryModel.fromJson(Map<String, dynamic> json) {
    return SanHistoryModel(
      id: (json['id'] as num?)?.toInt(),
      insertDateTimeJalali: json['insertDateTimeJalali']?.toString(),
      referenceId: json['referenceId']?.toString(),
      description: json['description']?.toString(),
      insertUserName: json['insertUserName']?.toString(),
      entityType: (json['entityType'] as num?)?.toInt(),
      actionType: (json['actionType'] as num?)?.toInt(),
      entityTypeTitle: json['entityTypeTitle']?.toString(),
      currentEntity: json['currentEntity']?.toString(),
    );
  }
}
