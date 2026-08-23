import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
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

    return AppSummaryCard(
      title: item.deviceName ?? '---',
      leading: CircleAvatar(
        radius: AppSize.s24,
        backgroundColor: theme.colorScheme.primary.withAlpha(25),
        child: Icon(
          Icons.router_outlined,
          color: theme.colorScheme.primary,
        ),
      ),
      badges: [
        StatusLabel(
          text: item.isActive == true ? 'فعال' : 'غیرفعال',
          color: item.isActive == true
              ? theme.colorScheme.onError
              : theme.colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.sim_card_outlined,
          label: 'شماره سیمکارت',
          value: item.simNumber,
        ),
        SummaryCardInfo(
          icon: CupertinoIcons.barcode,
          label: 'سریال دستگاه',
          value: item.avlSerial,
        ),
        SummaryCardInfo(
          icon: Icons.memory_outlined,
          label: 'IMEI',
          value: item.imei,
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: JalaliDateHelper.formatStringJalaliDateTime(
            item.insertDateTimeJalali,
          ),
        ),
      ],
      onOperation: () => _showActionsSheet(context),
    );
  }

  void _showActionsSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    BottomSheetMessage.showCustom(
      backgroundColor: Colors.white,
      context: context,
      content: OperationBottomSheet(
        entries: [
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.edit_outlined,
              title: 'ویرایش',
              onTap: onEdit,
            ),
            dividerAfter: Divider(
              height: AppSize.s1,
              thickness: AppSize.s1,
              color: colorScheme.onInverseSurface,
            ),
          ),
          OperationBottomSheetEntry(
            child: BottomSheetActionTile(
              icon: Icons.delete_forever_outlined,
              title: 'حذف',
              onTap: onDelete,
              isDestructive: true,
            ),
          ),
        ],
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }
}
