import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_history_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class PlanHistoryTile extends StatelessWidget {
  const PlanHistoryTile({
    super.key,
    required this.history,
  });

  final PlanHistoryEntity history;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p14),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(color: colorScheme.onInverseSurface),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.07),
            blurRadius: AppSize.s18,
            offset: const Offset(0, AppSize.s8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BodySmallText(
                text: _formatDateTime(history.insertDateTimeJalali),
                textDirection: TextDirection.ltr,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              BodySmallText(
                text: 'ثبت کننده',
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
              Space.w4,
              Flexible(
                child: BodySmallText(
                  text: _dash(history.insertUserName),
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Space.h12,
          BodyMediumText(
            text: _dash(history.description),
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            lineHeight: 1.7,
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String? value) {
    final text = value?.trim();
    if (text == null || text.isEmpty) return '---';

    final parts = text.split(RegExp(r'\s+'));
    final date = parts.isNotEmpty ? parts.first.replaceAll('-', '/') : '---';
    final time = parts.length > 1 ? parts[1] : '';
    return time.isEmpty ? date : '$date - $time';
  }

  String _dash(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? '---' : text;
  }
}
