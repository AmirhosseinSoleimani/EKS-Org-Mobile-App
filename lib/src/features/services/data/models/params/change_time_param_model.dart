import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/change_time_param_entity.dart';

class ChangeTimeParamModel extends ChangeTimeParamEntity {
  ChangeTimeParamModel({super.dateId, super.timeId, super.serviceRequestId});

  Map<String, dynamic> toJson() {
    return {
      'dateId': dateId,
      'timeId': timeId,
      'serviceRequestId': serviceRequestId,
    };
  }
}
