import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';

class FollowupModel extends FollowupEntity {
  const FollowupModel({
    super.id,
    super.followUpDateTime,
    super.actionType,
    super.authorType,
    super.authorId,
    super.authorFullName,
    super.sourceType,
    super.resultStatusId,
    super.resultStatusTitle,
    super.isDeleted,
    super.followUpDateJalali,
    super.followUpTime,
    super.actionTypeName,
    super.actionTypeTitle,
    super.authorTypeName,
    super.authorTypeTitle,
    super.sourceTypeName,
    super.sourceTypeTitle,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.insertTime,
    super.serviceRequestId,
    super.serviceType,
  });

  factory FollowupModel.fromJson(Map<String, dynamic> json) {
    return FollowupModel(
      id: json["id"],
      followUpDateTime: json["followUpDateTime"],
      actionType: json["actionType"],
      authorType: json["authorType"],
      authorId: json["authorId"],
      authorFullName: json["authorFullName"],
      sourceType: json["sourceType"],
      resultStatusId: json["resultStatusId"],
      resultStatusTitle: json["resultStatusTitle"],
      isDeleted: json["isDeleted"],
      followUpDateJalali: json["followUpDateJalali"],
      followUpTime: json["followUpTime"],
      actionTypeName: json["actionTypeName"],
      actionTypeTitle: json["actionTypeTitle"],
      authorTypeName: json["authorTypeName"],
      authorTypeTitle: json["authorTypeTitle"],
      sourceTypeName: json["sourceTypeName"],
      sourceTypeTitle: json["sourceTypeTitle"],
      insertDateTime: json["insertDateTime"],
      insertDateTimeJalali: json["insertDateTimeJalali"],
      insertTime: json["insertTime"],
      serviceRequestId: json["serviceRequestId"],
      serviceType: json["serviceType"],
    );
  }
}
