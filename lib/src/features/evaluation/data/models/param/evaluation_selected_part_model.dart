import 'package:eks_sana_plus_org/src/features/evaluation/data/models/allowable_cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
class EvaluationSelectedPartModel extends EvaluationSelectedPartEntity {
  const EvaluationSelectedPartModel({
    required super.part,
    required super.mark,
    required super.costCenter,
    required super.count,
    required super.price,
    super.hasReusable = false,
    super.isReusable = false,
    super.isCausing = false,
  });

  factory EvaluationSelectedPartModel.fromJson(Map<String, dynamic> json) {
    return EvaluationSelectedPartModel(
      part: PartEntity(
        name: json['name']?.toString(),
        serial: json['serial']?.toString(),
        partGroupId: _asInt(json['partGroupId']),
        partGroupName: json['partGroupName']?.toString(),
      ),
      mark: PartMarkEntity(
        mark: json['mark']?.toString(),
      ),
      costCenter: AllowableCostCenterModel.fromJson(
        Map<String, dynamic>.from(json['costCenter'] ?? {}),
      ),
      count: _asInt(json['count']) ?? 1,
      price: _asInt(json['price']) ?? 0,
      hasReusable: _asBool(json['hasReusable']),
      isReusable: _asBool(json['isReusable']),
      isCausing: _asBool(json['isCausing']),
    );
  }

  Map<String, dynamic> toJson({
    int? laborId,
  }) {
    return {
      'allowIllegalMarkReason': '',
      'costCenter': costCenter.toModel().toJson(),
      'count': count,
      'hasReusable': hasReusable,
      'isCausing': isCausing,
      'isReusable': isReusable,
      'laborId': laborId,
      'mark': markName,
      'name': partName,
      'partGroupId': partGroupId,
      'price': price,
      'serial': serial,
    };
  }

  static int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  static bool _asBool(dynamic value, {bool fallback = false}) {
    if (value == null) return fallback;
    if (value is bool) return value;
    if (value is num) return value != 0;

    final text = value.toString().toLowerCase().trim();

    if (text == 'true' || text == '1') return true;
    if (text == 'false' || text == '0') return false;

    return fallback;
  }
}