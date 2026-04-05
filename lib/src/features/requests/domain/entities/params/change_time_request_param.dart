import 'package:eks_sana_plus_org/src/features/requests/data/models/params/change_time_request_param_model.dart';

class ChangeTimeRequestParam {
  final String? trackGuid;
  final int? serviceRequestId;
  final int? dateId;
  final int? timeId;
  final int? skipCount;

  const ChangeTimeRequestParam({
    this.serviceRequestId,
    this.trackGuid,
    this.dateId,
    this.timeId,
    this.skipCount,
  });

  ChangeTimeRequestParam copyWith({
    String? trackGuid,
    int? serviceRequestId,
    int? dateId,
    int? timeId,
    int? skipCount,
  }) {
    return ChangeTimeRequestParam(
      trackGuid: trackGuid ?? this.trackGuid,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      dateId: dateId ?? this.dateId,
      timeId: timeId ?? this.timeId,
      skipCount: skipCount ?? this.skipCount,
    );
  }

  ChangeTimeRequestParamModel toModel() {
    return ChangeTimeRequestParamModel(
      trackGuid: trackGuid,
      serviceRequestId: serviceRequestId,
      dateId: dateId,
      timeId: timeId,
      skipCount: skipCount,
    );
  }
}

