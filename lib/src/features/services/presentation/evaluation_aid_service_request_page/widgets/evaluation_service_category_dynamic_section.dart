import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/enums/evaluation_service_category_view_type.dart';
import 'package:flutter/material.dart';

class EvaluationServiceCategoryDynamicSection extends StatelessWidget {
  final ServiceCategoryEntity? selectedServiceCategory;
  final Widget laborAndPartSection;
  final Widget transportSection;

  const EvaluationServiceCategoryDynamicSection({
    super.key,
    required this.selectedServiceCategory,
    required this.laborAndPartSection,
    required this.transportSection,
  });

  @override
  Widget build(BuildContext context) {
    final viewType = selectedServiceCategory.evaluationViewType;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: switch (viewType) {
        EvaluationServiceCategoryViewType.laborAndPart => KeyedSubtree(
          key: const ValueKey('laborAndPartSection'),
          child: laborAndPartSection,
        ),
        EvaluationServiceCategoryViewType.transport => KeyedSubtree(
          key: const ValueKey('transportSection'),
          child: transportSection,
        ),
        EvaluationServiceCategoryViewType.none => const SizedBox(
          key: ValueKey('emptyServiceCategorySection'),
        ),
      },
    );
  }
}
