import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_service_request_entity.dart';

import 'control_group_entity.dart';

class ControlInfoEntity {
  final ControlGroupEntity? emdadgar;
  final ControlGroupEntity? systemUser;
  final ControlGroupEntity? system;
  final ControlInfoServiceRequestEntity? serviceRequest;

  const ControlInfoEntity({
    this.emdadgar,
    this.systemUser,
    this.system,
    this.serviceRequest,
  });

  ControlInfoEntity copyWith({
    ControlGroupEntity? emdadgar,
    ControlGroupEntity? systemUser,
    ControlGroupEntity? system,
    ControlInfoServiceRequestEntity? serviceRequest,
  }) {
    return ControlInfoEntity(
      emdadgar: emdadgar ?? this.emdadgar,
      systemUser: systemUser ?? this.systemUser,
      system: system ?? this.system,
      serviceRequest: serviceRequest ?? this.serviceRequest,
    );
  }

  ControlInfoModel toModel() {
    return ControlInfoModel(
      emdadgar: emdadgar?.toModel(),
      systemUser: systemUser?.toModel(),
      system: system?.toModel(),
      serviceRequest: serviceRequest?.toModel(),
    );
  }
}
