import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/create_follow_up_param_entity.dart';

class CreateFollowUpParamModel extends CreateFollowUpParamEntity {
  const CreateFollowUpParamModel({
    super.serviceRequestId,
    super.serviceType,
    super.resultStatusId,
    super.sourceType,
    super.description,
    super.followUpDateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'ServiceRequestId': serviceRequestId,
      'ServiceType': serviceType,
      'ResultStatusId': resultStatusId,
      'SourceType': sourceType,
      'Description': description,
      'FollowUpDateTime': followUpDateTime,
    };
  }
}
