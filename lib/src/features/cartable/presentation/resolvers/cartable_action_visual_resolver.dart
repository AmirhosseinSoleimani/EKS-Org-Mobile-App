import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class CartableActionVisual {
  final IconData? icon;
  final String? svgAssetPath;
  final Color color;

  const CartableActionVisual({
    required this.color,
    this.icon,
    this.svgAssetPath,
  });
}

abstract final class CartableActionVisualResolver {
  static CartableActionVisual resolve({
    required BuildContext context,
    required CartableItemActionEntity action,
  }) {
    final iconCssClass = action.iconCssClass?.trim().toLowerCase() ?? '';

    return CartableActionVisual(
      icon: _resolveIcon(iconCssClass),
      svgAssetPath: _resolveSvgAssetPath(iconCssClass),
      color: _resolveColor(context, action.buttonCssClass),
    );
  }

  static String? _resolveSvgAssetPath(String iconCssClass) {
    if (iconCssClass.contains('fa-share')) {
      return SvgManager.forwardIcon;
    }

    return null;
  }

  static IconData? _resolveIcon(String? iconCssClass) {
    final value = iconCssClass?.trim().toLowerCase() ?? '';

    if (value.contains('fa-search')) {
      return Icons.search_rounded;
    }

    if (value.contains('fa-share')) {
      return null;
    }

    if (value.contains('fa-check')) {
      return Icons.check_circle_outline_rounded;
    }

    if (value.contains('fa-times')) {
      return Icons.close_rounded;
    }

    if (value.contains('fa-archive')) {
      return Icons.archive_outlined;
    }

    if (value.contains('fa-file')) {
      return Icons.description_outlined;
    }

    if (value.contains('fa-external-link-alt')) {
      return Icons.open_in_new_rounded;
    }

    if (value.contains('fa-clock')) {
      return Icons.schedule_rounded;
    }

    if (value.contains('fa-retweet')) {
      return Icons.sync_alt_rounded;
    }

    if (value.contains('fa-headphones-alt')) {
      return Icons.headset_mic_outlined;
    }

    return Icons.more_horiz_rounded;
  }

  static Color _resolveColor(BuildContext context, String? buttonCssClass) {
    final colorScheme = Theme.of(context).colorScheme;

    final value = buttonCssClass?.trim().toLowerCase() ?? '';

    if (value.contains('btn-danger')) {
      return colorScheme.error;
    }

    if (value.contains('btn-success')) {
      return const Color(0xFF2E7D32);
    }

    if (value.contains('btn-warning')) {
      return const Color(0xFFF59E0B);
    }

    if (value.contains('btn-purple')) {
      return const Color(0xFF7E57C2);
    }

    if (value.contains('btn-secondary')) {
      return colorScheme.onSurfaceVariant;
    }

    if (value.contains('btn-info')) {
      return const Color(0xFF0288D1);
    }

    if (value.contains('btn-primary')) {
      return colorScheme.primary;
    }

    return colorScheme.primary;
  }
}
