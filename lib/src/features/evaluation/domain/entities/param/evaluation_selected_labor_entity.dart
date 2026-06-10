import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/evaluation_selected_labor_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';

class EvaluationSelectedLaborEntity {
  final LaborEntity labor;
  final AllowableCostCenterEntity costCenter;
  final int price;
  final List<EvaluationSelectedPartEntity> evaluationParts;

  const EvaluationSelectedLaborEntity({
    required this.labor,
    required this.costCenter,
    required this.price,
    this.evaluationParts = const [],
  });

  int? get laborId => labor.id;
  String get name => labor.name ?? '';
  String get laborCode => labor.code ?? '';
  int? get laborGroupId => labor.laborGroupId;
  String get laborGroupDesc => labor.laborGroupTitle ?? '';
  String get overLapCode => labor.overLapCode ?? '';
  double? get standardTime => labor.standardTime;

  List<String> get overLapCodes {
    if (overLapCode.trim().isEmpty) return [];

    return overLapCode
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  EvaluationSelectedLaborEntity copyWith({
    LaborEntity? labor,
    AllowableCostCenterEntity? costCenter,
    int? price,
    List<EvaluationSelectedPartEntity>? evaluationParts,
  }) {
    return EvaluationSelectedLaborEntity(
      labor: labor ?? this.labor,
      costCenter: costCenter ?? this.costCenter,
      price: price ?? this.price,
      evaluationParts: evaluationParts ?? this.evaluationParts,
    );
  }

  EvaluationSelectedLaborModel toModel() {
    return EvaluationSelectedLaborModel(
      labor: labor,
      costCenter: costCenter,
      price: price,
      evaluationParts: evaluationParts,
    );
  }
}