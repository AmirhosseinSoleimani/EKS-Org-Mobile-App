import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class DeploymentLocationCard extends StatelessWidget {
  const DeploymentLocationCard({
    super.key,
    required this.item,
    required this.onActions,
    this.isActionLoading = false,
  });

  final DeploymentLocationEntity item;
  final VoidCallback onActions;
  final bool isActionLoading;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [ Container(
                width: AppSize.s48,
                height: AppSize.s48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  color: theme.colorScheme.primary,
                  size: AppSize.s28,
                ),
              ),
                Space.w12,
                Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p8),
                  child: TitleLargeText(
                    text: item.title ?? '---',
                    color: theme.colorScheme.onSurface,
                    fontSize: AppSize.s16,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],),
              Space.w8,
              StatusLabel(
                text: item.isActive == true ? 'فعال' : 'غیرفعال',
                color: item.isActive == true
                    ? theme.colorScheme.onError
                    : theme.colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
            ],
          ),
          Space.h16,
          _LocationInfoRow(
            icon: Icons.map_outlined,
            label: 'استان/شهر:',
            value:
                '${item.provinceTitle ?? '---'}/${item.cityTitle ?? '---'}',
          ),
          Space.h12,
          _LocationInfoRow(
            icon: Icons.location_on_outlined,
            label: 'آدرس:',
            value: item.address ?? '---',
            maxLines: 2,
          ),
          Space.h12,
          Divider(color: theme.dividerColor),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت‌کننده: ${item.insertFullName ?? '---'}',
                  color: theme.colorScheme.onTertiaryFixed,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              Space.w8,
              BodySmallText(
                text: item.insertDateTimeJalali ?? '---',
                color: theme.colorScheme.onTertiaryFixed,
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
          Space.h14,
          InkwellButtonWidget(
            title: 'عملیات',
            backgroundColor: theme.colorScheme.secondaryContainer,
            titleColor: theme.colorScheme.onTertiaryFixed,
            showLoading: isActionLoading,
            prefixIcon: Icon(
              Icons.settings_outlined,
              color: theme.colorScheme.onTertiaryFixed,
              size: AppSize.s20,
            ),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: theme.colorScheme.onTertiaryFixed,
            ),
            onTap: () {
              if (isActionLoading) return;
              onActions();
            },
          ),
        ],
      ),
    );
  }
}

class _LocationInfoRow extends StatelessWidget {
  const _LocationInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final String value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: theme.colorScheme.onTertiaryFixed,
          size: AppSize.s20,
        ),
        Space.w8,
        TitleMediumText(
          text: label,
          color: theme.colorScheme.onTertiaryFixed,
          fontSize: AppSize.s14,
          fontWeight: FontWeight.w700,
        ),
        Space.w4,
        Expanded(
          child: BodySmallText(
            text: value,
            color: theme.colorScheme.onTertiaryFixed,
            fontSize: AppSize.s14,
            maxLines: maxLines,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
