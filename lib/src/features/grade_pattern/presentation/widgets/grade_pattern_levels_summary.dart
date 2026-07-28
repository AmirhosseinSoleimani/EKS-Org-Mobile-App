import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_ui_mapper.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_levels_summary.dart'
    as shared;
import 'package:flutter/material.dart';

class GradePatternLevelsSummary extends StatelessWidget {
  const GradePatternLevelsSummary({super.key, required this.details});

  final List<GradePatternDetailEntity> details;

  @override
  Widget build(BuildContext context) {
    return shared.GradePatternLevelsSummary(
      details: details.map((item) => item.toUiModel()).toList(),
    );
  }
}
