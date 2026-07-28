import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_ui_mapper.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_details_sheet.dart'
    as shared;
import 'package:flutter/material.dart';

class GradePatternDetailsSheet extends StatelessWidget {
  const GradePatternDetailsSheet({
    super.key,
    required this.item,
  });

  final GradePatternEntity item;

  @override
  Widget build(BuildContext context) {
    return shared.GradePatternDetailsSheet(item: item.toUiModel());
  }
}
