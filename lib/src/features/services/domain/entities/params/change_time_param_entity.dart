

import 'package:eks_sana_plus_org/src/features/services/data/models/params/change_time_param_model.dart';

class ChangeTimeParamEntity {
  final int? dateId;
  final int? timeId;
  final int? serviceRequestId;

  ChangeTimeParamEntity({
    this.dateId,
    this.timeId,
    this.serviceRequestId,
  });

  ChangeTimeParamEntity copyWith({
    int? dateId,
    int? timeId,
    int? serviceRequestId,
  }) {
    return ChangeTimeParamEntity(
      dateId: dateId ?? this.dateId,
      timeId: timeId ?? this.timeId,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
    );
  }

  ChangeTimeParamModel toModel() {
    return ChangeTimeParamModel(
      dateId: dateId,
      timeId: timeId,
      serviceRequestId: serviceRequestId,
    );
  }
}
