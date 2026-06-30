
import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_group_model.dart';

import 'control_event_entity.dart';

class ControlGroupEntity {
  final ControlEventEntity? emdadgarStartedDriving;
  final ControlEventEntity? emdadgarArrived;
  final ControlEventEntity? jobDone;

  const ControlGroupEntity({
    this.emdadgarStartedDriving,
    this.emdadgarArrived,
    this.jobDone,
  });

  ControlGroupEntity copyWith({
    ControlEventEntity? emdadgarStartedDriving,
    ControlEventEntity? emdadgarArrived,
    ControlEventEntity? jobDone,
  }) {
    return ControlGroupEntity(
      emdadgarStartedDriving:
      emdadgarStartedDriving ?? this.emdadgarStartedDriving,
      emdadgarArrived: emdadgarArrived ?? this.emdadgarArrived,
      jobDone: jobDone ?? this.jobDone,
    );
  }

  ControlGroupModel toModel() {
    return ControlGroupModel(
      emdadgarStartedDriving: emdadgarStartedDriving?.toModel(),
      emdadgarArrived: emdadgarArrived?.toModel(),
      jobDone: jobDone?.toModel(),
    );
  }
}
