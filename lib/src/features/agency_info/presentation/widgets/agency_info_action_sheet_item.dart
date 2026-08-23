import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:flutter/material.dart';

class AgencyInfoActionSheetItem extends StatelessWidget {
  const AgencyInfoActionSheetItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
    this.isLoading = false,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BottomSheetActionTile(
      icon: icon,
      title: title,
      onTap: onTap,
      isDestructive: isDestructive,
      isLoading: isLoading,
      enabled: enabled,
    );
  }
}
