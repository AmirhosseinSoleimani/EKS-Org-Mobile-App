
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_history_entity.dart';

class PlanHistoryModel extends PlanHistoryEntity {
  const PlanHistoryModel({
    required super.id,
    super.insertDateTimeJalali,
    super.referenceId,
    super.description,
    super.insertUserName,
    super.entityType,
    super.actionType,
    super.entityTypeTitle,
  });

  factory PlanHistoryModel.fromJson(Map<String, dynamic> json) {
    return PlanHistoryModel(
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