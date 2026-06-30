import 'package:eks_sana_plus_org/src/features/services/domain/entities/follow_up_status_type_entity.dart';

class FollowUpStatusTypeModel extends FollowUpStatusTypeEntity {
  const FollowUpStatusTypeModel({
    super.id,
    super.code,
    super.title,
    super.sourceType,
    super.changesRequestStatus,
    super.serviceRequestResultStatus,
    super.isActive,
    super.isDeleted,
    super.sourceTypeName,
    super.sourceTypeTitle,
    super.serviceRequestResultStatusName,
    super.serviceRequestResultStatusTitle,
  });

  factory FollowUpStatusTypeModel.fromJson(Map<String, dynamic> json) {
    return FollowUpStatusTypeModel(
      id: json['id'],
      code: json['code'],
      title: json['title'],
      sourceType: json['sourceType'],
      changesRequestStatus: json['changesRequestStatus'],
      serviceRequestResultStatus: json['serviceRequestResultStatus'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      sourceTypeName: json['sourceTypeName'],
      sourceTypeTitle: json['sourceTypeTitle'],
      serviceRequestResultStatusName: json['serviceRequestResultStatusName'],
      serviceRequestResultStatusTitle: json['serviceRequestResultStatusTitle'],
    );
  }
}
