import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';

class SpecialPlanPageEntity {
  const SpecialPlanPageEntity({
    this.records = const [],
    this.count = 0,
  });

  final List<SpecialPlanEntity> records;
  final int count;
}
