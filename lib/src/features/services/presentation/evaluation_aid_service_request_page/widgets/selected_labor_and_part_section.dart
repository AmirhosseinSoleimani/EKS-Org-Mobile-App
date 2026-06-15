import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'selected_labor_list_item.dart';

class SelectedLaborAndPartSection extends StatelessWidget {
  final ValueListenable<List<EvaluationSelectedLaborEntity>>
  selectedLaborsListenable;
  final ValueListenable<Set<int>> expandedLaborIdsListenable;

  final VoidCallback onAddLabor;
  final ValueChanged<EvaluationSelectedLaborEntity> onAddPart;
  final ValueChanged<EvaluationSelectedLaborEntity> onEditLabor;
  final ValueChanged<EvaluationSelectedLaborEntity> onDeleteLabor;
  final ValueChanged<EvaluationSelectedLaborEntity> onToggleShowMoreParts;

  const SelectedLaborAndPartSection({
    super.key,
    required this.selectedLaborsListenable,
    required this.expandedLaborIdsListenable,
    required this.onAddLabor,
    required this.onAddPart,
    required this.onEditLabor,
    required this.onDeleteLabor,
    required this.onToggleShowMoreParts,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleLargeText(
            text: 'اجرت و قطعه',
            fontSize: 16,
            textAlign: TextAlign.start,
          ),
          Space.h32,
          InkwellButtonWidget(
            title: 'افزودن اجرت',
            prefixIcon: Icon(Icons.add, color: colorScheme.primary),
            titleColor: colorScheme.primary,
            borderColor: colorScheme.primary,
            splashColor: colorScheme.primary.withAlpha(50),
            backgroundColor: Colors.transparent,
            onTap: onAddLabor,
            height: 45,
          ),
          Space.h16,
          _buildSelectedLaborsList(),
        ],
      ),
    );
  }

  Widget _buildSelectedLaborsList() {
    return ValueListenableBuilder<List<EvaluationSelectedLaborEntity>>(
      valueListenable: selectedLaborsListenable,
      builder: (context, labors, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: labors.isEmpty
              ? const SizedBox(key: ValueKey('emptySelectedLabors'))
              : ValueListenableBuilder<Set<int>>(
                  key: const ValueKey('selectedLaborsList'),
                  valueListenable: expandedLaborIdsListenable,
                  builder: (context, expandedIds, _) {
                    return Column(
                      children: List.generate(labors.length, (index) {
                        final labor = labors[index];
                        final laborId = labor.laborId;
                        final isExpanded =
                            laborId != null && expandedIds.contains(laborId);

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == labors.length - 1 ? 0 : 12,
                          ),
                          child: SelectedLaborListItem(
                            labor: labor,
                            isPartsExpanded: isExpanded,
                            onAddPart: () => onAddPart(labor),
                            onEdit: () => onEditLabor(labor),
                            onDelete: () => onDeleteLabor(labor),
                            onToggleShowMoreParts: () =>
                                onToggleShowMoreParts(labor),
                          ),
                        );
                      }),
                    );
                  },
                ),
        );
      },
    );
  }
}
