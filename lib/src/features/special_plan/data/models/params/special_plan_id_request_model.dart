import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_id_param_entity.dart';

class SpecialPlanIdRequestModel {
  const SpecialPlanIdRequestModel({required this.id});

  factory SpecialPlanIdRequestModel.fromParam(
    SpecialPlanIdParamEntity param,
  ) => SpecialPlanIdRequestModel(id: param.id);

  final int id;

  Map<String, dynamic> toDeleteJson() => {'id': id};
}
