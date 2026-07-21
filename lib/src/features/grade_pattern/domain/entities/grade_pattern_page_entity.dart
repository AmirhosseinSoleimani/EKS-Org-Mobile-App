import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';

class GradePatternPageEntity {
  const GradePatternPageEntity({
    required this.records,
    required this.count,
  });

  final List<GradePatternEntity> records;
  final int count;
}
