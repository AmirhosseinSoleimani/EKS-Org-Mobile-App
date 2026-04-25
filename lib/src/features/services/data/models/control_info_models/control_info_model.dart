import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_group_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_info_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_entity.dart';

class ControlInfoModel extends ControlInfoEntity {
  ControlInfoModel({
    super.emdadgar,
    super.systemUser,
    super.system,
    super.serviceRequest,
  });

  factory ControlInfoModel.fromJson(Map<String, dynamic> json) {
    return ControlInfoModel(
      emdadgar: json['emdadgar'] != null
          ? ControlGroupModel.fromJson(json['emdadgar'])
          : null,
      systemUser: json['systemUser'] != null
          ? ControlGroupModel.fromJson(json['systemUser'])
          : null,
      system: json['system'] != null
          ? ControlGroupModel.fromJson(json['system'])
          : null,
      serviceRequest: json['serviceRequest'] != null
          ? ControlInfoServiceRequestModel.fromJson(json['serviceRequest'])
          : null,
    );
  }
}
