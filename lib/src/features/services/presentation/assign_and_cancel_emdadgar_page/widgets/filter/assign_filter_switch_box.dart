import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/bottom_sheet/filter_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AssignFilterSwitchBox extends StatelessWidget {
  final AssignFilterType selectedType;
  final ValueChanged<AssignFilterType> onChanged;
  final AssignAndCancelEmdadgarCubit cubit;

  const AssignFilterSwitchBox({
    super.key,
    required this.selectedType,
    required this.onChanged,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: AppSize.s48,
      width: double.infinity,
      padding: const EdgeInsets.all(AppSize.s4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                alignment: selectedType == AssignFilterType.emdadgar
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: itemWidth,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(18),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: _AssignFilterSwitchItem(
                      title: 'نمایندگی ها سایپا یدک',
                      isSelected: selectedType == AssignFilterType.agency,
                        onTap: () {
                          cubit.clearFilterFields();
                          onChanged(AssignFilterType.agency);
                        }

                    ),
                  ),
                  Expanded(
                    child: _AssignFilterSwitchItem(
                      title: 'امدادرسان ها',
                      isSelected: selectedType == AssignFilterType.emdadgar,
                      onTap: () {
                        cubit.clearFilterFields();
                        onChanged(AssignFilterType.emdadgar);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AssignFilterSwitchItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _AssignFilterSwitchItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s8),
      onTap: onTap,
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurface.withAlpha(150),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
