import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class GeneralContentFormAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GeneralContentFormAppBar({
    super.key,
    required this.title,
    this.onClose,
  });

  final String title;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colorScheme.onPrimary,
      surfaceTintColor: colorScheme.onPrimary,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: TitleMediumText(
        text: title,
        color: colorScheme.onTertiaryFixed,
        fontWeight: FontWeight.w700,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).dividerColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onClose ?? () => Navigator.of(context).maybePop(),
          icon: Icon(
            Icons.close_rounded,
            color: colorScheme.onTertiaryFixed,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
