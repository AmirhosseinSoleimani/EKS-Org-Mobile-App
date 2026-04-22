import 'package:eks_sana_plus_org/src/features/services/data/models/params/chassis_param_model.dart';

class ChassisParamEntity {
  final String? chassisNumber;


  const ChassisParamEntity({
    this.chassisNumber,
  });

  ChassisParamEntity copyWith({
    String? chassisNumber,
  }) {
    return ChassisParamEntity(
      chassisNumber: chassisNumber ?? this.chassisNumber,
    );
  }

  ChassisParamModel toModel() {
    return ChassisParamModel(
      chassisNumber: chassisNumber,
    );
  }
}
