import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
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

    return AppSummaryCard(
      title: item.title ?? '---',
      subtitle: 'کد ناوگان: ${item.code ?? '---'}',
      leading: CircleAvatar(
        radius: AppSize.s28,
        backgroundColor: theme.colorScheme.primary.withAlpha(25),
        child: Icon(
          Icons.commute,
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
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: JalaliDateHelper.formatStringJalaliDateTime(
            item.insertDateTimeJalali,
          ),
        ),
        SummaryCardMeta(
          label: 'آخرین ویرایش',
          value: item.updateUserFullName,
          date: JalaliDateHelper.formatStringJalaliDateTime(
            item.updateDateTimeJalali,
          ),
        ),
      ],
      onOperation: onActions,
    );
  }
}
