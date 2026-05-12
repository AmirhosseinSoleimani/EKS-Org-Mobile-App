import 'package:eks_sana_plus_org/src/features/services/data/models/params/get_times_param_model.dart';

class GetTimesParamEntity {
  final int? serviceRequestId;
  final int? planningId;

  GetTimesParamEntity({this.serviceRequestId, this.planningId});

  GetTimesParamEntity copyWith({int? serviceRequestId, int? planningId}) {
    return GetTimesParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      planningId: planningId ?? this.planningId,
    );
  }

  GetTimesParamModel toModel() {
    return GetTimesParamModel(
      serviceRequestId: serviceRequestId,
      planningId: planningId,
    );
  }
}
