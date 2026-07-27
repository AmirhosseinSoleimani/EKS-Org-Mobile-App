import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class BottomSheetActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const BottomSheetActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.onTertiaryFixed;

    return ListTile(
      leading: Icon(icon, color: color),
      title: BodyMediumText(
        text: title,
        color: color,
        fontWeight: FontWeight.w600,
      ),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }
}
