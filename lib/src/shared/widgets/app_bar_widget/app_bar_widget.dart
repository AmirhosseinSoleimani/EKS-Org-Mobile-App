import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final String? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Widget? leading;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const AppBarWidget({
    super.key,
    this.showBackButton = true,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.onPrimary,
      centerTitle: showBackButton ? false : true,
      automaticallyImplyLeading: false,
      leading: leading ?? (showBackButton
              ?  Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        IconManager.arrowBack,
                        color: colorScheme.onSurface,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                )
              : IconButton(
                  onPressed: () {
                    scaffoldKey?.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: AppSize.s32,
                    color: colorScheme.onTertiary,
                  ),
                )),
      title: showBackButton
          ? '$title'.headlineMedium(context,
              fontSize: AppSize.s16, fontWeight: FontWeight.w700)
          : _defaultTitle(context),
      actions: actions ?? (showBackButton ? null : _defaultActions(context: context)),
    );
  }

  Widget _defaultTitle(BuildContext context) {
    return Image.asset(
      ImageManager.logoSingle,
      width: AppSize.s60,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          IconManager.errorImage,
          size: AppSize.s24,
        );
      },
    );
  }

  List<Widget> _defaultActions({required BuildContext context}) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: AppPadding.p8),
        child: InkWell(
          onTap: () {
            try {
              const url = "tel:096550";
              launchUrl(Uri.parse(url));
            } catch(e) {
              throw 'Could not launch $e';
            }
          },
          child: SvgWidget(
            src: const SvgAsset(
                SvgManager.headset,
            ),
            width: AppSize.s32,
            height: AppSize.s32,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
