import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:flutter/material.dart';

class NavganActionSheet extends StatelessWidget {
  const NavganActionSheet({
    super.key,
    required this.onAddGrade,
    required this.onAssignServices,
    required this.onVehicleServices,
  });

  final VoidCallback onAddGrade;
  final VoidCallback onAssignServices;
  final VoidCallback onVehicleServices;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BottomSheetActionTile(
              icon: Icons.grading_outlined,
              title: 'الگوی گرید',
              onTap: onAddGrade,
            ),
            BottomSheetActionTile(
              icon: Icons.miscellaneous_services_outlined,
              title: 'اختصاص سرویس‌ها',
              onTap: onAssignServices,
            ),
            BottomSheetActionTile(
              icon: Icons.car_repair_outlined,
              title: 'ایرادات سرویس خودرو',
              onTap: onVehicleServices,
            ),
          ],
        ),
      ),
    );
  }
}