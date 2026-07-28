import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_ui_mapper.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_list_card.dart';
import 'package:flutter/material.dart';

class GradePatternCard extends StatelessWidget {
  const GradePatternCard({
    super.key,
    required this.item,
    required this.onDetails,
    required this.onOperations,
    this.isDetailsLoading = false,
  });

  final GradePatternEntity item;
  final VoidCallback onDetails;
  final VoidCallback onOperations;
  final bool isDetailsLoading;

  @override
  Widget build(BuildContext context) {
    return GradePatternListCard(
      item: item.toUiModel(),
      isDetailsLoading: isDetailsLoading,
      onDetails: onDetails,
      onAction: onOperations,
    );
  }
}
