import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_actions.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_info_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_meta_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class AppSummaryCard extends StatelessWidget {
  const AppSummaryCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.badges = const [],
    this.badgePlacement = SummaryCardBadgePlacement.trailing,
    this.infoItems = const [],
    this.beforeInfo,
    this.afterInfo,
    this.metaItems = const [],
    this.primaryAction,
    this.onOperation,
    this.isOperationLoading = false,
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.fromLTRB(
      AppPadding.p16,
      AppPadding.p16,
      AppPadding.p16,
      AppPadding.p14,
    ),
    this.primaryActionFlex = 56,
    this.operationActionFlex = 44,
    this.actionSpacing = AppSize.s16,
    this.titleMaxLines = 2,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> badges;
  final SummaryCardBadgePlacement badgePlacement;
  final List<SummaryCardInfo> infoItems;
  final Widget? beforeInfo;
  final Widget? afterInfo;
  final List<SummaryCardMeta> metaItems;
  final Widget? primaryAction;
  final VoidCallback? onOperation;
  final bool isOperationLoading;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final int primaryActionFlex;
  final int operationActionFlex;
  final double actionSpacing;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.06),
            blurRadius: AppSize.s16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummaryCardHeader(
                  title: title,
                  subtitle: subtitle,
                  leading: leading,
                  badges: badges,
                  badgePlacement: badgePlacement,
                  titleMaxLines: titleMaxLines,
                ),
                if (beforeInfo != null) ...[
                  Space.h16,
                  beforeInfo!,
                ],
                if (infoItems.isNotEmpty) ...[
                  Space.h8,
                  ...infoItems.map(
                    (item) => SummaryCardInfoRow(item: item),
                  ),
                ],
                if (afterInfo != null) ...[
                  Space.h8,
                  afterInfo!,
                ],
                if (metaItems.isNotEmpty) ...[
                  Space.h16,
                  Divider(
                    height: AppSize.s1,
                    color: theme.dividerColor,
                  ),
                  Space.h16,
                  for (var index = 0; index < metaItems.length; index++) ...[
                    SummaryCardMetaRow(item: metaItems[index]),
                    if (index != metaItems.length - 1) Space.h8,
                  ],
                ],

                if (primaryAction != null || onOperation != null) ...[
                  Space.h24,
                  SummaryCardActions(
                    primaryAction: primaryAction,
                    onOperation: onOperation,
                    isOperationLoading: isOperationLoading,
                    primaryActionFlex: primaryActionFlex,
                    operationActionFlex: operationActionFlex,
                    spacing: actionSpacing,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

