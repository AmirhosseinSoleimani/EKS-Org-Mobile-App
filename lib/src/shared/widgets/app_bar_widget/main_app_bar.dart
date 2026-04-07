import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: colorScheme.onPrimary,
      elevation: 0,
      centerTitle: false,
      title: TitleMediumText(text: title),
      actions: [
        IconButton(
          icon: Icon(
            Icons.person,
            color: colorScheme.tertiaryFixed,
            size: AppSize.s32,
          ),
          onPressed: () {},
        ),
        Space.w8,
        _divider(colorScheme),
        Space.w8,
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: colorScheme.tertiaryFixed,
            size: AppSize.s32,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Container _divider(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      color: colorScheme.tertiaryFixed,
      width: AppSize.s1,
      height: double.infinity,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
