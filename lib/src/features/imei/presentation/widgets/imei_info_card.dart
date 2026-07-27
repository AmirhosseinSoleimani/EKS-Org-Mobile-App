import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImeiInfoCard extends StatelessWidget {
  const ImeiInfoCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  final ImeiInfoEntity item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: AppSize.s24,
                backgroundColor: theme.colorScheme.primary.withAlpha(25),
                child: Icon(
                  Icons.router_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),

              Space.w12,
              TitleLargeText(
                text: item.deviceName ?? '---',
                color: theme.colorScheme.onSurface,
                fontSize: AppSize.s18,
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
          _InfoRow(
            icon: Icons.sim_card_outlined,
            title: 'شماره سیمکارت',
            value: item.simNumber,
          ),
          Space.h12,
          _InfoRow(
            icon: CupertinoIcons.barcode,
            title: 'سریال دستگاه',
            value: item.avlSerial,
          ),
          Space.h12,
          _InfoRow(
            icon: Icons.memory_outlined,
            title: 'IMEI',
            value: item.imei,
          ),
          Space.h14,
          Divider(color: theme.dividerColor),
          Space.h14,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت کننده: ${item.insertUserFullName ?? '---'}',
                  color: theme.colorScheme.onPrimaryFixed,
                  fontWeight: FontWeight.w400,
                ),
              ),
              BodySmallText(
                text: JalaliDateHelper.formatStringJalaliDateTime(
                    item.insertDateTimeJalali),
                color: theme.colorScheme.onPrimaryFixed,
              ),
            ],
          ),
          Space.h14,
          InkwellButtonWidget(
            title: 'عملیات',
            height: AppSize.s42,
            backgroundColor: theme.colorScheme.secondaryContainer,
            titleColor: theme.colorScheme.onSurface,
            prefixIcon: Icon(
              Icons.settings_outlined,
              size: AppSize.s20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            suffixIcon: Icon(
              Icons.expand_more_outlined,
              size: AppSize.s20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            onTap: () => _showActionsSheet(context),
          )
        ],
      ),
    );
  }

  void _showActionsSheet(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    BottomSheetMessage.showCustom(
        backgroundColor: Colors.white,
        context: context,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetActionTile(
              icon: Icons.edit_outlined,
              title: 'ویرایش',
              onTap: onEdit,
            ),
            Divider(color: colorScheme.onInverseSurface,),
            BottomSheetActionTile(
              icon: Icons.delete_forever_outlined,
              title: 'حذف',
              onTap: onDelete,
              isDestructive: true,
            ),
          ],
        ),
        actionWidget: SizedBox.shrink());
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
          color: colorScheme.onTertiaryFixed,
          fontWeight: FontWeight.w700,
        ),
        Expanded(
          child: BodyMediumText(
            text: value?.trim().isNotEmpty == true ? value! : '---',
            color: colorScheme.onTertiaryFixed,
            fontWeight: FontWeight.w400,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

