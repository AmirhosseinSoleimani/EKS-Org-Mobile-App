import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_info_entity.dart';

class DefectInfoModel extends DefectInfoEntity {
  const DefectInfoModel({
    required super.id,
    required super.minCost,
    required super.maxCost,
    required super.estimatedTime,
  });

  factory DefectInfoModel.fromJson(Map<String, dynamic> json) {
    return DefectInfoModel(
      id: _toInt(json['id']),
      minCost: _toInt(json['minCost']),
      maxCost: _toInt(json['maxCost']),
      estimatedTime: _toInt(json['estimatedTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'minCost': minCost,
      'maxCost': maxCost,
      'estimatedTime': estimatedTime,
    };
  }

  static bool _toBool(dynamic v) {
    if (v is bool) return v;

    if (v is String) return v.toLowerCase() == 'true' || v == '1';

    if (v is num) return v != 0;

    return false;
  }

  static int _toInt(dynamic v) {
    if (v is int) return v;

    if (v is String) return int.tryParse(v) ?? 0;

    if (v is num) return v.toInt();

    return 0;
  }
}
