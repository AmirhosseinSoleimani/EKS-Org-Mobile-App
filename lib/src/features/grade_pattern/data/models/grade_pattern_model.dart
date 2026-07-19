import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_detail_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';

class GradePatternModel extends GradePatternEntity {
  const GradePatternModel({
    super.id,
    super.code,
    super.name,
    super.details,
    super.isActive,
  });

  factory GradePatternModel.fromJson(Map<String, dynamic> json) {
    final rawDetails = json['details'];
    return GradePatternModel(
      id: _toInt(json['id']),
      code: _toInt(json['code']),
      name: json['name']?.toString(),
      isActive: json['isActive'] is bool ? json['isActive'] as bool : true,
      details: rawDetails is List
          ? rawDetails
              .whereType<Map>()
              .map((item) => GradePatternDetailModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ))
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'code': code,
      'name': name,
      'details': details.map((item) => item.toModel().toJson()).toList(),
      'isActive': isActive,
    };
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
