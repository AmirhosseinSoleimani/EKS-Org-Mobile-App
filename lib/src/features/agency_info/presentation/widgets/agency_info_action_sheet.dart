import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_sheet_item.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyInfoActionSheet extends StatelessWidget {
  const AgencyInfoActionSheet({
    super.key,
    required this.onActionSelected,
  });

  final ValueChanged<AgencyInfoActionType> onActionSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AgencyInfoActionSheetItem(
            icon: Icons.article_outlined,
            title: 'قراردادها',
            onTap: () => _select(context, AgencyInfoActionType.contracts),
          ),
          AgencyInfoActionSheetItem(
            icon: Icons.group_outlined,
            title: 'امدادرسان‌های فعلی',
            onTap: () => _select(context, AgencyInfoActionType.activeReliefWorkers),
          ),
          AgencyInfoActionSheetItem(
            icon: Icons.local_shipping_outlined,
            title: 'خودروهای فعلی',
            onTap: () => _select(context, AgencyInfoActionType.activeVehicles),
          ),
          AgencyInfoActionSheetItem(
            icon: Icons.toggle_on_outlined,
            title: 'تغییر وضعیت به غیر فعال',
            onTap: () => _select(context, AgencyInfoActionType.changeStatus),
          ),
          AgencyInfoActionSheetItem(
            icon: Icons.build_circle_outlined,
            title: 'نوع خدمات',
            onTap: () => _select(context, AgencyInfoActionType.serviceType),
          ),
          AgencyInfoActionSheetItem(
            icon: Icons.speaker_notes_outlined,
            title: 'اطلاعات تکمیلی',
            onTap: () => _select(context, AgencyInfoActionType.complementaryInfo),
          ),
          Divider(
            height: AppSize.s1,
            thickness: AppSize.s1,
            color: theme.colorScheme.onInverseSurface,
          ),
          AgencyInfoActionSheetItem(
            icon: Icons.history_rounded,
            title: 'تاریخچه',
            onTap: () => _select(context, AgencyInfoActionType.history),
          ),
          Divider(
            height: AppSize.s1,
            thickness: AppSize.s1,
            color: theme.colorScheme.onInverseSurface,
          ),
          AgencyInfoActionSheetItem(
            icon: Icons.delete_outline_rounded,
            title: 'حذف',
            isDestructive: true,
            onTap: () => _select(context, AgencyInfoActionType.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle(ThemeData theme) {
    return Container(
      width: AppSize.s60,
      height: AppSize.s4,
      decoration: BoxDecoration(
        color: theme.colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    );
  }

  void _select(BuildContext context, AgencyInfoActionType actionType) {
    Navigator.of(context).pop();
    onActionSelected(actionType);
  }
}
