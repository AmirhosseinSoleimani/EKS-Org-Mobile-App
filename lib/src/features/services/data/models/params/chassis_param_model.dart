import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/chassis_param_entity.dart';

class ChassisParamModel extends ChassisParamEntity {
  const ChassisParamModel({
    super.chassisNumber,
  });

  factory ChassisParamModel.fromJson(Map<String, dynamic> json) {
    return ChassisParamModel(
      chassisNumber: json['chassisNumber'],
    );
  }

  Map<String, dynamic> toJson() => {"chassisNumber": chassisNumber};

}
