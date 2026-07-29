import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class DeploymentLocationFormAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DeploymentLocationFormAppBar({
    super.key,
    required this.title,
    required this.onClose,
  });

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: colorScheme.onPrimary,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 16,
      title: TitleMediumText(
        text: title,
        fontWeight: FontWeight.w700,
      ),
      actions: [
        IconButton(
          tooltip: 'بستن',
          onPressed: onClose,
          icon: Icon(
            Icons.close_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
