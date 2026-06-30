import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_emdadgar_followups_data_param_entity.dart';

class GetEmdadgarFollowupsDataParamModel
    extends GetEmdadgarFollowupsDataParamEntity {
  const GetEmdadgarFollowupsDataParamModel({
    required super.serviceType,
    super.serviceRequestId,
    super.needHaml,
  });

  factory GetEmdadgarFollowupsDataParamModel.fromEntity(
    GetEmdadgarFollowupsDataParamEntity entity,
  ) {
    return GetEmdadgarFollowupsDataParamModel(
      serviceRequestId: entity.serviceRequestId,
      serviceType: entity.serviceType,
      needHaml: entity.needHaml,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "serviceRequestId": serviceRequestId,
      "serviceType": serviceType.value,
      "needHaml": needHaml ?? false,
    };
  }
}
