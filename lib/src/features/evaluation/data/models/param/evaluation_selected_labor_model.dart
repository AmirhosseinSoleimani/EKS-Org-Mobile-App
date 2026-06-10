import 'package:eks_sana_plus_org/src/features/evaluation/data/models/allowable_cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';

import 'evaluation_selected_part_model.dart';

class EvaluationSelectedLaborModel extends EvaluationSelectedLaborEntity {
  const EvaluationSelectedLaborModel({
    required super.labor,
    required super.costCenter,
    required super.price,
    super.evaluationParts = const [],
  });

  factory EvaluationSelectedLaborModel.fromJson(Map<String, dynamic> json) {
    return EvaluationSelectedLaborModel(
      labor: LaborEntity(
        id: _asInt(json['laborId']),
        name: json['name']?.toString(),
        code: json['laborCode']?.toString(),
        overLapCode: json['overLapCode']?.toString(),
        standardTime: _asDouble(json['standardTime']),
        laborGroupId: _asInt(json['laborGroupId']),
        laborGroupTitle: json['laborGroupDesc']?.toString(),
        needImage: _asBoolOrNull(json['needImage']),
        isImageMandatory: _asBoolOrNull(json['isImageMandatory']),
      ),
      costCenter: AllowableCostCenterModel.fromJson(
        Map<String, dynamic>.from(json['costCenter'] ?? {}),
      ),
      price: _asInt(json['price']) ?? 0,
      evaluationParts: _parseEvaluationParts(json['evaluationParts']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'costCenter': costCenter.toModel().toJson(),
      'evaluationParts': evaluationParts
          .map((item) => item.toModel().toJson())
          .toList(),
      'isCausing': false,
      'laborCode': laborCode,
      'laborGroupDesc': laborGroupDesc,
      'laborGroupId': laborGroupId,
      'laborId': laborId,
      'name': name,
      'overLapCode': overLapCode,
      'overLapCodes': overLapCodes,
      'price': price,
      'selecteable': false,
      'standardTime': standardTime,
    };
  }

  static List<EvaluationSelectedPartEntity> _parseEvaluationParts(
      dynamic value,
      ) {
    if (value == null) return [];

    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) {
      return EvaluationSelectedPartModel.fromJson(
        Map<String, dynamic>.from(item),
      );
    })
        .toList();
  }

  static int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  static double? _asDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static bool? _asBoolOrNull(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is num) return value != 0;

    final text = value.toString().toLowerCase().trim();

    if (text == 'true' || text == '1') return true;
    if (text == 'false' || text == '0') return false;

    return null;
  }
}