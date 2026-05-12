import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_times_param_entity.dart';


class GetTimesParamModel extends GetTimesParamEntity {
  GetTimesParamModel({
    super.serviceRequestId,
    super.planningId,
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceRequestId': serviceRequestId,
      'planningId': planningId,
    };
  }
}
