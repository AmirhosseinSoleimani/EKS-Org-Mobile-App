import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class SummaryCardHeader extends StatelessWidget {
  const SummaryCardHeader({
    super.key,
    required this.title,
    this.titleLabel,
    this.subtitle,
    this.leading,
    this.badges = const [],
    this.badgePlacement = SummaryCardBadgePlacement.trailing,
    this.titleMaxLines = 2,
  });

  final String title;
  final String? titleLabel;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> badges;
  final SummaryCardBadgePlacement badgePlacement;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    if (badgePlacement == SummaryCardBadgePlacement.aboveTitle &&
        badges.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Badges(items: badges),
          Space.h12,
          _TitleRow(
            title: title,
            titleLabel: titleLabel,
            subtitle: subtitle,
            leading: leading,
            titleMaxLines: titleMaxLines,
          ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final badgeMaxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth * 0.42
            : 160.0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _TitleRow(
                title: title,
                titleLabel: titleLabel,
                subtitle: subtitle,
                leading: leading,
                titleMaxLines: titleMaxLines,
              ),
            ),
            if (badges.isNotEmpty) ...[
              Space.w8,
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: badgeMaxWidth),
                child: _Badges(items: badges),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.title,
    required this.titleLabel,
    required this.subtitle,
    required this.leading,
    required this.titleMaxLines,
  });

  final String title;
  final String? titleLabel;
  final String? subtitle;
  final Widget? leading;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (leading != null) ...[
          leading!,
          Space.w12,
        ],
        Expanded(
          child: _TitleBlock(
            title: title,
            titleLabel: titleLabel,
            subtitle: subtitle,
            titleMaxLines: titleMaxLines,
          ),
        ),
      ],
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({
    required this.title,
    required this.titleLabel,
    required this.subtitle,
    required this.titleMaxLines,
  });

  final String title;
  final String? titleLabel;
  final String? subtitle;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final normalizedLabel = titleLabel?.trim();
    final normalizedSubtitle = subtitle?.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (normalizedLabel != null && normalizedLabel.isNotEmpty) ...[
          Text(
            normalizedLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w400,
            ),
          ),
          Space.h2,
        ],
        Text(
          _display(title),
          maxLines: titleMaxLines,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: AppSize.s16,
          ),
        ),
        if (normalizedSubtitle != null && normalizedSubtitle.isNotEmpty) ...[
          Space.h4,
          Text(
            normalizedSubtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  static String _display(String value) {
    final normalized = value.trim();
    return normalized.isEmpty ? '---' : normalized;
  }
}

class _Badges extends StatelessWidget {
  const _Badges({required this.items});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: AppSize.s8,
      runSpacing: AppSize.s8,
      children: items,
    );
  }
}
