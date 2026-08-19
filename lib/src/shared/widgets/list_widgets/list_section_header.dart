import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:flutter/material.dart';

class ListSectionHeader extends StatelessWidget {
  const ListSectionHeader({
    super.key,
    required this.title,
    this.countText,
    this.accentColor,
  });

  final String title;
  final String? countText;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final normalizedCount = countText?.trim();

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (normalizedCount != null && normalizedCount.isNotEmpty) ...[
          Space.w8,
          StatusLabel(
            text: normalizedCount,
            color: accentColor ?? theme.colorScheme.primary,
            fontSize: 11,
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p10,
              vertical: AppPadding.p4,
            ),
          ),
        ],
      ],
    );
  }
}
