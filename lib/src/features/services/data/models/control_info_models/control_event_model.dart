import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_event_entity.dart';

class   ControlEventModel extends  ControlEventEntity{
  ControlEventModel({
    super.id,
    super.followUpDateTime,
    super.actionType,
    super.authorType,
    super.authorId,
    super.authorFullName,
    super.sourceType,
    super.resultStatusId,
    super.resultStatusTitle,
    super.description,
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
    super.serviceRequestId,
    super.serviceType,
  });

  factory ControlEventModel.fromJson(Map<String, dynamic> json) {
    return ControlEventModel(
      id: json['id'],
      followUpDateTime: json['followUpDateTime'],
      actionType: json['actionType'],
      authorType: json['authorType'],
      authorId: json['authorId'],
      authorFullName: json['authorFullName'],
      sourceType: json['sourceType'],
      resultStatusId: json['resultStatusId'],
      resultStatusTitle: json['resultStatusTitle'],
      description: json['description'],
      isDeleted: json['isDeleted'],
      followUpDateJalali: json['followUpDateJalali'],
      followUpTime: json['followUpTime'],
      actionTypeName: json['actionTypeName'],
      actionTypeTitle: json['actionTypeTitle'],
      authorTypeName: json['authorTypeName'],
      authorTypeTitle: json['authorTypeTitle'],
      sourceTypeName: json['sourceTypeName'],
      sourceTypeTitle: json['sourceTypeTitle'],
      insertDateTime: json['insertDateTime'],
      serviceRequestId: json['serviceRequestId'],
      serviceType: json['serviceType'],
    );
  }

}