import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/get_emdadgar_followups_data_param_model.dart';

class GetEmdadgarFollowupsDataParamEntity {
  final int? serviceRequestId;
  final ServiceType serviceType;
  final bool? needHaml;

  const GetEmdadgarFollowupsDataParamEntity({
    required this.serviceType,
    this.serviceRequestId,
    this.needHaml,
  });

  GetEmdadgarFollowupsDataParamEntity copyWith({
    int? serviceRequestId,
    ServiceType? serviceType,
    bool? needHaml,
  }) {
    return GetEmdadgarFollowupsDataParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      needHaml: needHaml ?? this.needHaml,
    );
  }

  GetEmdadgarFollowupsDataParamModel toModel() =>
      GetEmdadgarFollowupsDataParamModel.fromEntity(this);
}
