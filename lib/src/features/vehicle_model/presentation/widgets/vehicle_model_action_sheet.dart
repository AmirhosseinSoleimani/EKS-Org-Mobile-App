import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:flutter/material.dart';

class VehicleModelActionSheet extends StatelessWidget {
  const VehicleModelActionSheet({
    super.key,
    required this.onServices,
    required this.onEdit,
    required this.onDelete,
    this.isDeleting = false,
  });

  final VoidCallback onServices;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BottomSheetActionTile(
              icon: Icons.miscellaneous_services_outlined,
              title: 'سرویس‌ها',
              onTap: onServices,
            ),
            BottomSheetActionTile(
              icon: Icons.edit_outlined,
              title: 'ویرایش',
              onTap: onEdit,
            ),
            Divider(color: Theme.of(context).dividerColor),
            BottomSheetActionTile(
              icon: Icons.delete_outline,
              title: 'حذف',
              isDestructive: true,
              isLoading: isDeleting,
              enabled: !isDeleting,
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
