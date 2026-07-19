import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_history_entity.dart';

class AgencyHistoryModel extends AgencyHistoryEntity {
  const AgencyHistoryModel({
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

  factory AgencyHistoryModel.fromJson(Map<String, dynamic> json) {
    return AgencyHistoryModel(
      id: AgencyInfoJsonHelper.integer(json['id']),
      insertDateTimeJalali: AgencyInfoJsonHelper.string(json['insertDateTimeJalali']),
      referenceId: AgencyInfoJsonHelper.string(json['referenceId']),
      description: AgencyInfoJsonHelper.string(json['description']),
      insertUserName: AgencyInfoJsonHelper.string(json['insertUserName']),
      entityType: AgencyInfoJsonHelper.integer(json['entityType']),
      actionType: AgencyInfoJsonHelper.integer(json['actionType']),
      entityTypeTitle: AgencyInfoJsonHelper.string(json['entityTypeTitle']),
      currentEntity: AgencyInfoJsonHelper.string(json['currentEntity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'insertDateTimeJalali': insertDateTimeJalali,
      'referenceId': referenceId,
      'description': description,
      'insertUserName': insertUserName,
      'entityType': entityType,
      'actionType': actionType,
      'entityTypeTitle': entityTypeTitle,
      'currentEntity': currentEntity,
    };
  }
}
