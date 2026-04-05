import 'package:eks_sana_plus_org/src/features/requests/data/models/params/get_times_param_model.dart';

class GetTimesParam {
  final String? trackGuid;
  final int? serviceRequestId;
  final int? skipCount;

  const GetTimesParam({
    this.trackGuid,
    this.serviceRequestId,
    this.skipCount,
  });

  GetTimesParam copyWith({
    String? trackGuid,
    int? serviceRequestId,
    int? skipCount,
  }) {
    return GetTimesParam(
      trackGuid: trackGuid ?? this.trackGuid,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      skipCount: skipCount ?? this.skipCount,
    );
  }

  GetTimesParamModel toModel() => GetTimesParamModel(
        trackGuid: trackGuid,
        serviceRequestId: serviceRequestId,
        skipCount: skipCount,
      );
}
