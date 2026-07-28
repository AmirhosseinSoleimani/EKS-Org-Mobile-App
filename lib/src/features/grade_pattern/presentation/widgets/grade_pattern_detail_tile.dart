import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_ui_mapper.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_detail_tile.dart'
    as shared;
import 'package:flutter/material.dart';

class GradePatternDetailTile extends StatelessWidget {
  const GradePatternDetailTile({super.key, required this.detail});

  final GradePatternDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return shared.GradePatternDetailTile(detail: detail.toUiModel());
  }
}
