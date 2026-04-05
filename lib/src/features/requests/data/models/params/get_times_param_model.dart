import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/get_times_param.dart';

class GetTimesParamModel extends GetTimesParam {
  const GetTimesParamModel({
    super.trackGuid,
    super.serviceRequestId,
    super.skipCount,
  });

  Map<String, dynamic> toJson() => {
        'TrackGuid': trackGuid,
        'ServiceRequestId': serviceRequestId,
        'SkipCount': skipCount,
      };

  factory GetTimesParamModel.fromJson(Map<String, dynamic> json) {
    return GetTimesParamModel(
      trackGuid: json['TrackGuid'] as String?,
      serviceRequestId: json['ServiceRequestId'] as int?,
      skipCount: json['SkipCount'] as int?,
    );
  }
}
