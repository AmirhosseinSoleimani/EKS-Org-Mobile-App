import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/change_time_request_param.dart';

class ChangeTimeRequestParamModel extends ChangeTimeRequestParam {
  const ChangeTimeRequestParamModel({
    super.serviceRequestId,
    super.trackGuid,
    super.dateId,
    super.timeId,
    super.skipCount,
  });

  factory ChangeTimeRequestParamModel.fromEntity(ChangeTimeRequestParam entity) {
    return ChangeTimeRequestParamModel(
      trackGuid: entity.trackGuid,
      serviceRequestId: entity.serviceRequestId,
      dateId: entity.dateId,
      timeId: entity.timeId,
      skipCount: entity.skipCount,
    );
  }

  Map<String, dynamic> toJson() => {
    'TrackGuid': trackGuid,
    'ServiceRequestId': serviceRequestId,
    'DateId': dateId,
    'TimeId': timeId,
    'SkipCount': skipCount,
  };
}