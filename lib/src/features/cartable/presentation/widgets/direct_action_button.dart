import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/resolvers/cartable_action_visual_resolver.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DirectActionButton extends StatelessWidget {
  final String text;
  final CartableItemActionEntity? action;
  final IconData? defaultIcon;
  final bool isFilled;
  final bool showIcon;
  final VoidCallback? onPressed;

  const DirectActionButton({
    super.key,
    required this.text,
    required this.action,
    required this.isFilled,
    required this.onPressed,
    this.defaultIcon,
    this.showIcon = true,
  });

  bool get isEnabled {
    return action != null && onPressed != null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final actionAppearance = action == null
        ? null
        : CartableActionVisualResolver.resolve(
            context: context,
            action: action!,
          );

    final actionColor = actionAppearance?.color ?? colorScheme.onSurfaceVariant;

    final disabledColor = colorScheme.onSurface.withAlpha(65);

    final buttonMainColor = isEnabled ? actionColor : disabledColor;

    final buttonBackgroundColor = _getBackgroundColor(
      colorScheme: colorScheme,
      actionColor: actionColor,
    );

    final contentColor = _getContentColor(
      colorScheme: colorScheme,
      buttonMainColor: buttonMainColor,
    );

    final buttonBorder = _getBorder(
      colorScheme: colorScheme,
      actionColor: actionColor,
    );

    return Material(
      color: buttonBackgroundColor,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppSize.s8),
        splashColor: buttonMainColor.withAlpha(25),
        child: Container(
          height: AppSize.s40,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            border: buttonBorder,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showIcon) ...[
                _buildIcon(appearance: actionAppearance, color: contentColor),
                const SizedBox(width: AppSize.s6),
              ],
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: contentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor({
    required ColorScheme colorScheme,
    required Color actionColor,
  }) {
    if (!isFilled) {
      return Colors.transparent;
    }

    if (!isEnabled) {
      return colorScheme.onSurface.withAlpha(15);
    }

    return actionColor;
  }

  Color _getContentColor({
    required ColorScheme colorScheme,
    required Color buttonMainColor,
  }) {
    if (isFilled && isEnabled) {
      return colorScheme.onPrimary;
    }

    return buttonMainColor;
  }

  Border? _getBorder({
    required ColorScheme colorScheme,
    required Color actionColor,
  }) {
    if (isFilled) {
      return null;
    }

    final borderColor = isEnabled
        ? actionColor
        : colorScheme.onSurface.withAlpha(35);

    return Border.all(color: borderColor);
  }

  Widget _buildIcon({
    required CartableActionVisual? appearance,
    required Color color,
  }) {
    final svgAssetPath = appearance?.svgAssetPath;

    if (svgAssetPath != null) {
      return SvgPicture.asset(
        svgAssetPath,
        width: AppSize.s18,
        height: AppSize.s18,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    final icon = appearance?.icon ?? defaultIcon;

    if (icon == null) {
      return const SizedBox.shrink();
    }

    return Icon(icon, size: AppSize.s18, color: color);
  }
}
