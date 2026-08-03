import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_list_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_group_header.dart';
import 'package:flutter/material.dart';

class VehicleModelServiceGroupSection extends StatelessWidget {
  const VehicleModelServiceGroupSection({
    super.key,
    required this.group,
    required this.onToggle,
    required this.onSettings,
    required this.isSettingsLoading,
    this.enabled = true,
  });

  final VehicleServiceGroupEntity group;
  final ValueChanged<EmdadServiceCategoryEntity> onToggle;
  final ValueChanged<EmdadServiceCategoryEntity> onSettings;
  final bool Function(EmdadServiceCategoryEntity category) isSettingsLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final title = group.serviceTypeTitle?.trim();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title?.isNotEmpty == true) ...[
            SelectionGroupHeader(
              title: title!,
              icon: _groupIcon(title),
            ),
            Space.h12,
          ],
          ...group.emdadCategories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p8),
              child: SelectableListItem(
                title: category.title ?? '---',
                selected: category.selected,
                enabled: enabled,
                onTap: () => onToggle(category),
                suffix: enabled && category.selected
                    ? _SettingsAction(
                        isLoading: isSettingsLoading(category),
                        onTap: () => onSettings(category),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _groupIcon(String title) {
    if (title.contains('امدادی')) return Icons.car_repair_outlined;
    if (title.contains('محل')) return Icons.home_repair_service_outlined;
    return Icons.miscellaneous_services_outlined;
  }
}

class _SettingsAction extends StatelessWidget {
  const _SettingsAction({
    required this.isLoading,
    required this.onTap,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: AppSize.s32,
      height: AppSize.s32,
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.all(AppPadding.p6),
              child: CircularProgressIndicator(
                strokeWidth: AppSize.s2,
                color: primary,
              ),
            )
          : IconButton(
              onPressed: onTap,
              tooltip: 'محدودیت عیوب',
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                Icons.settings_outlined,
                size: AppSize.s20,
                color: primary,
              ),
            ),
    );
  }
}
