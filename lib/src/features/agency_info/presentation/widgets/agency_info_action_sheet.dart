import 'package:eks_sana_plus_org/src/features/agency_info/presentation/cubit/agency_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_sheet_item.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AgencyInfoActionSheet extends StatelessWidget {
  const AgencyInfoActionSheet({
    super.key,
    required this.onActionSelected,
    this.loadingActionType,
    this.isActive,
  });

  final ValueChanged<AgencyInfoActionType> onActionSelected;
  final AgencyInfoActionType? loadingActionType;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final divider = Divider(
      height: AppSize.s1,
      thickness: AppSize.s1,
      color: theme.colorScheme.onInverseSurface,
    );

    return OperationBottomSheet(
      entries: [
        OperationBottomSheetEntry(
          child: AgencyInfoActionSheetItem(
            icon: Icons.article_outlined,
            title: 'قراردادها',
            isLoading: _isLoading(AgencyInfoActionType.contracts),
            onTap: () => _select(AgencyInfoActionType.contracts),
          ),
        ),
        OperationBottomSheetEntry(
          child: AgencyInfoActionSheetItem(
            icon: Icons.group_outlined,
            title: 'امدادرسان‌های فعلی',
            isLoading: _isLoading(AgencyInfoActionType.activeReliefWorkers),
            onTap: () => _select(AgencyInfoActionType.activeReliefWorkers),
          ),
        ),
        OperationBottomSheetEntry(
          child: AgencyInfoActionSheetItem(
            icon: Icons.local_shipping_outlined,
            title: 'خودروهای فعلی',
            isLoading: _isLoading(AgencyInfoActionType.activeVehicles),
            onTap: () => _select(AgencyInfoActionType.activeVehicles),
          ),
        ),
        OperationBottomSheetEntry(
          child: AgencyInfoActionSheetItem(
            icon: Icons.toggle_on_outlined,
            title: isActive == false
                ? 'تغییر وضعیت به فعال'
                : 'تغییر وضعیت به غیر فعال',
            isLoading: _isLoading(AgencyInfoActionType.changeStatus),
            onTap: () => _select(AgencyInfoActionType.changeStatus),
          ),
        ),
        OperationBottomSheetEntry(
          child: AgencyInfoActionSheetItem(
            icon: Icons.build_circle_outlined,
            title: 'نوع خدمات',
            isLoading: _isLoading(AgencyInfoActionType.serviceType),
            onTap: () => _select(AgencyInfoActionType.serviceType),
          ),
        ),
        OperationBottomSheetEntry(
          child: AgencyInfoActionSheetItem(
            icon: Icons.speaker_notes_outlined,
            title: 'اطلاعات تکمیلی',
            isLoading: _isLoading(AgencyInfoActionType.complementaryInfo),
            onTap: () => _select(AgencyInfoActionType.complementaryInfo),
          ),
          dividerAfter: divider,
        ),
        OperationBottomSheetEntry(
          child: AgencyInfoActionSheetItem(
            icon: Icons.history_rounded,
            title: 'تاریخچه',
            isLoading: _isLoading(AgencyInfoActionType.history),
            onTap: () => _select(AgencyInfoActionType.history),
          ),
          dividerAfter: divider,
        ),
        OperationBottomSheetEntry(
          child: AgencyInfoActionSheetItem(
            icon: Icons.delete_outline_rounded,
            title: 'حذف',
            isDestructive: true,
            isLoading: _isLoading(AgencyInfoActionType.delete),
            onTap: () => _select(AgencyInfoActionType.delete),
          ),
        ),
      ],
    );
  }

  bool get _hasLoading => loadingActionType != null;

  bool _isLoading(AgencyInfoActionType actionType) {
    return loadingActionType == actionType;
  }

  void _select(AgencyInfoActionType actionType) {
    if (_hasLoading) return;
    onActionSelected(actionType);
  }
}
