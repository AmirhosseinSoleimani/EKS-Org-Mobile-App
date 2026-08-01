import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class VehicleModelCard extends StatelessWidget {
  const VehicleModelCard({
    super.key,
    required this.item,
    required this.onActions,
    this.isActionLoading = false,
  });

  final VehicleModelEntity item;
  final VoidCallback onActions;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
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
              CircleAvatar(
                radius: AppSize.s28,
                backgroundColor: theme.colorScheme.primary.withAlpha(25),
                child: Icon(Icons.commute, color: theme.colorScheme.primary),
              ),
              Space.w8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleLargeText(
                    text: item.title ?? item.name ?? '---',
                    color: theme.colorScheme.onSurface,
                    fontSize: AppSize.s18,
                    textAlign: TextAlign.start,
                  ),
                  Space.h8,
                  BodySmallText(
                    text: 'کد: ${item.code ?? '---'}',
                    color: theme.colorScheme.onTertiaryFixed,
                    fontSize: AppSize.s14,
                  ),
                ],
              ),
              Spacer(),
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
          Row(
            children: [
              Icon(Icons.commute, color: theme.colorScheme.onTertiaryFixed),
              Space.w8,
              TitleMediumText(
                text: 'نوع ناوگان: ${item.navganTypeTitle ?? '---'}',
                color: theme.colorScheme.onTertiaryFixed,
                fontSize: AppSize.s14,
              ),
            ],
          ),
          Space.h8,
          Row(
            children: [
              Icon(Icons.gif_box_outlined, color: theme.colorScheme.onTertiaryFixed),
              Space.w8,
              TitleMediumText(
                text: 'مجهز به انبارک: ${item.hasDepot == true ? 'بله' : 'خیر'}',
                color: theme.colorScheme.onTertiaryFixed,
                fontSize: AppSize.s14,
              ),
            ],
          ),
          Space.h8,
          Divider(color: theme.dividerColor),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت‌کننده: ${item.insertUserFullName ?? '---'}',
                  color: theme.colorScheme.onTertiaryFixed,
                  maxLines: 1,
                ),
              ),
              BodySmallText(
                text: item.insertDateTimeJalali ?? '---',
                color: theme.colorScheme.onTertiaryFixed,
              ),
            ],
          ),
          Space.h14,
          InkwellButtonWidget(
            title: 'عملیات',
            backgroundColor: theme.colorScheme.secondaryContainer,
            titleColor: theme.colorScheme.onTertiaryFixed,
            showLoading: isActionLoading,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: theme.colorScheme.onTertiaryFixed,
            ),
            prefixIcon: Icon(
              Icons.settings_outlined,
              color: theme.colorScheme.onTertiaryFixed,
              size: AppSize.s20,
            ),
            onTap: onActions,
          ),
        ],
      ),
    );
  }
}
