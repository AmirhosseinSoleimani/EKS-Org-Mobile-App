import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/evaluation_selected_part_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';

class EvaluationSelectedPartEntity {
  final PartEntity part;
  final PartMarkEntity mark;
  final AllowableCostCenterEntity costCenter;
  final int count;
  final int price;
  final bool hasReusable;
  final bool isReusable;
  final bool isCausing;

  const EvaluationSelectedPartEntity({
    required this.part,
    required this.mark,
    required this.costCenter,
    required this.count,
    required this.price,
    this.hasReusable = false,
    this.isReusable = false,
    this.isCausing = false,
  });

  String get partName => part.name ?? '';
  String get serial => part.serial ?? '';
  int? get partGroupId => part.partGroupId;
  String get markName => mark.mark ?? '';
  String get costCenterName => costCenter.name ?? '';
  String get allowIllegalMarkReason =>
      mark.allowIllegalMarkReason?.toString() ?? '';

  EvaluationSelectedPartEntity copyWith({
    PartEntity? part,
    PartMarkEntity? mark,
    AllowableCostCenterEntity? costCenter,
    int? count,
    int? price,
    bool? hasReusable,
    bool? isReusable,
    bool? isCausing,
  }) {
    return EvaluationSelectedPartEntity(
      part: part ?? this.part,
      mark: mark ?? this.mark,
      costCenter: costCenter ?? this.costCenter,
      count: count ?? this.count,
      price: price ?? this.price,
      hasReusable: hasReusable ?? this.hasReusable,
      isReusable: isReusable ?? this.isReusable,
      isCausing: isCausing ?? this.isCausing,
    );
  }

  EvaluationSelectedPartModel toModel() {
    return EvaluationSelectedPartModel(
      part: part,
      mark: mark,
      costCenter: costCenter,
      count: count,
      price: price,
      hasReusable: hasReusable,
      isReusable: isReusable,
      isCausing: isCausing,
    );
  }
}