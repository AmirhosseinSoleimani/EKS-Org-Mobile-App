
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/add_part_button.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/widgets/selected_part_item.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class LaborSection extends StatelessWidget {
  final EvaluationLaborResponseEntity labor;
  final int laborIndex;

  final VoidCallback onAddPart;
  final Function(BuildContext, int, EvaluationPartResponseEntity, int)
  onEditPart;
  final Function(BuildContext, EvaluationPartResponseEntity, int, bool?)
  onDeletePart;

  const LaborSection({
    super.key,
    required this.labor,
    required this.laborIndex,
    required this.onAddPart,
    required this.onEditPart,
    required this.onDeletePart,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final parts = labor.parts ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            BodyMediumText(text: labor.laborName ?? ''),
            Space.h16,
            BodyMediumText(text:  'قیمت: ${labor.laborPrice?.toRialPrice()}', textAlign: TextAlign.right,),
          ],),
        ),

        if (parts.isNotEmpty) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: parts.length,
            itemBuilder: (context, index) {
              return SelectedPartListItem(
                part: parts[index],
                onEdit: () =>
                    onEditPart(context, laborIndex, parts[index], index),
                onDelete: () =>
                    onDeletePart(context, parts[index], laborIndex, true),
              );
            },
          ),

          const SizedBox(height: 8),

          AddPartButton(color: colorScheme, onTap: onAddPart),
        ],
      ],
    );
  }
}
