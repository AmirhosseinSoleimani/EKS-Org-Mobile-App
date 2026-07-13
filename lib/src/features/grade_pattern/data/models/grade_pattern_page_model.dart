import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_page_entity.dart';

class GradePatternPageModel extends GradePatternPageEntity {
  const GradePatternPageModel({
    required super.records,
    required super.count,
  });

  factory GradePatternPageModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json['Data'] is Map<String, dynamic>
            ? json['Data'] as Map<String, dynamic>
            : json;
    final records = data['records'] ?? data['Records'];
    final count = data['count'] ?? data['Count'];

    return GradePatternPageModel(
      count: count is int ? count : int.tryParse(count?.toString() ?? '') ?? 0,
      records: records is List
          ? records
              .whereType<Map>()
              .map((item) => GradePatternModel.fromJson(
                    Map<String, dynamic>.from(item),
                  ))
              .toList()
          : const [],
    );
  }
}
