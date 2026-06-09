import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';

class EvaluationSelectedPartEntity {
  final PartEntity part;
  final PartMarkEntity mark;
  final AllowableCostCenterEntity costCenter;
  final int count;
  final num price;

  const EvaluationSelectedPartEntity({
    required this.part,
    required this.mark,
    required this.costCenter,
    required this.count,
    required this.price,
  });

  String get partName => part.name ?? '';
  String get markName => mark.mark ?? '';
  String get costCenterName => costCenter.name ?? '';
}