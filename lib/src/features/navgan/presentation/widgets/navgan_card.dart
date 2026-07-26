import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class NavganCard extends StatelessWidget {
  const NavganCard({
    super.key,
    required this.item,
    required this.onActions,
  });

  final NavganEntity item;
  final VoidCallback onActions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              StatusLabel(
                text: item.isActive == true ? 'فعال' : 'غیرفعال',
                backgroundColor: item.isActive == true
                    ? theme.colorScheme.primary.withOpacity(0.14)
                    : theme.colorScheme.error.withOpacity(0.12),
                color: item.isActive == true
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: TitleLargeText(
                  text: item.title ?? '---',
                  color: theme.colorScheme.onSurface,
                  fontSize: AppSize.s18,
                  textAlign: TextAlign.end,
                ),
              ),
              Space.w12,
              CircleAvatar(
                radius: AppSize.s24,
                backgroundColor: theme.colorScheme.secondaryContainer,
                child: Icon(
                  Icons.local_shipping_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          Space.h16,
          _InfoRow(
            icon: Icons.qr_code_2_outlined,
            title: 'کد',
            value: item.code,
          ),
          Space.h12,
          _InfoRow(
            icon: Icons.category_outlined,
            title: 'نوع ناوگان',
            value: item.emdadgarNavganType?.toString(),
          ),
          Space.h14,
          Divider(color: theme.colorScheme.outlineVariant),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت کننده: ${item.insertUserFullName ?? '---'}',
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              BodySmallText(
                text: item.insertDateTimeJalali ?? '---',
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          Space.h14,
          Align(
            alignment: Alignment.centerLeft,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: IconButton(
                onPressed: onActions,
                icon: Icon(
                  Icons.more_horiz_rounded,
                  color: theme.colorScheme.primary,
                ),
                tooltip: 'عملیات',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.onSurfaceVariant, size: AppSize.s20),
        Space.w8,
        BodyMediumText(
          text: '$title: ',
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
        Expanded(
          child: BodyMediumText(
            text: value?.trim().isNotEmpty == true ? value! : '---',
            color: colorScheme.onSurfaceVariant,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
