import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_group_model.dart';

import 'control_event_entity.dart';

class ControlGroupEntity {
  final ControlEventEntity? emdadgarStartedDriving;
  final ControlEventEntity? emdadgarArrived;
  final ControlEventEntity? jobDone;
  final String? durationFromStartDrivingToArrived;
  final String? durationFromArrivedToJobDone;

  const ControlGroupEntity({
    this.emdadgarStartedDriving,
    this.emdadgarArrived,
    this.jobDone,
    this.durationFromStartDrivingToArrived,
    this.durationFromArrivedToJobDone,
  });

  ControlGroupEntity copyWith({
    ControlEventEntity? emdadgarStartedDriving,
    ControlEventEntity? emdadgarArrived,
    ControlEventEntity? jobDone,
    String? durationFromStartDrivingToArrived,
    String? durationFromArrivedToJobDone,
  }) {
    return ControlGroupEntity(
      emdadgarStartedDriving:
          emdadgarStartedDriving ?? this.emdadgarStartedDriving,
      emdadgarArrived: emdadgarArrived ?? this.emdadgarArrived,
      jobDone: jobDone ?? this.jobDone,
      durationFromStartDrivingToArrived: durationFromStartDrivingToArrived ??
          this.durationFromStartDrivingToArrived,
      durationFromArrivedToJobDone:
          durationFromArrivedToJobDone ?? this.durationFromArrivedToJobDone,
    );
  }

  ControlGroupModel toModel() {
    return ControlGroupModel(
      emdadgarStartedDriving: emdadgarStartedDriving?.toModel(),
      emdadgarArrived: emdadgarArrived?.toModel(),
      jobDone: jobDone?.toModel(),
      durationFromStartDrivingToArrived: durationFromStartDrivingToArrived,
      durationFromArrivedToJobDone: durationFromArrivedToJobDone,
    );
  }
}
