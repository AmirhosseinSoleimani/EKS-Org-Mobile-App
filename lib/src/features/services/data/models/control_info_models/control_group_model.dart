import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_event_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_group_entity.dart';

class ControlGroupModel extends ControlGroupEntity {
  ControlGroupModel({
    super.emdadgarStartedDriving,
    super.emdadgarArrived,
    super.jobDone,
    super.durationFromStartDrivingToArrived,
    super.durationFromArrivedToJobDone,
  });

  factory ControlGroupModel.fromJson(Map<String, dynamic> json) {
    return ControlGroupModel(
      emdadgarStartedDriving: json['emdadgarStartedDriving'] != null
          ? ControlEventModel.fromJson(json['emdadgarStartedDriving'])
          : null,
      emdadgarArrived: json['emdadgarArrived'] != null
          ? ControlEventModel.fromJson(json['emdadgarArrived'])
          : null,
      jobDone: json['jobDone'] != null
          ? ControlEventModel.fromJson(json['jobDone'])
          : null,
      durationFromStartDrivingToArrived:
          json['durationFromStartDrivingToArrived'],
      durationFromArrivedToJobDone: json['durationFromArrivedToJobDone'],
    );
  }
}
