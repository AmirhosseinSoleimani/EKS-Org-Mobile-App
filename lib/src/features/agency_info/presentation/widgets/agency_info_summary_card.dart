import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class AgencyInfoSummaryCard extends StatelessWidget {
  const AgencyInfoSummaryCard({
    super.key,
    required this.item,
    this.onTap,
    this.onAction,
    this.trailing,
  });

  final AgencyInfoEntity item;
  final VoidCallback? onTap;
  final VoidCallback? onAction;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isActive = item.isActive ?? false;
    final colorScheme = Theme.of(context).colorScheme;
    return AppSummaryCard(
      title: item.title,
      onTap: onTap,
      badges: trailing != null
          ? [trailing!]
          : [
              StatusLabel(text: isActive ? 'فعال' : 'غیرفعال', color: isActive ? colorScheme.onError : colorScheme.error),
              if (item.typeTitle?.trim().isNotEmpty == true)
                StatusLabel(text: item.typeTitle!.trim(), color: colorScheme.onPrimaryFixed, backgroundColor: Color(0xFFCBE7F5),),

            ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.badge_outlined,
          label: 'کد نمایندگی',
          value: item.code,
        ),
        SummaryCardInfo(
          icon: Icons.person_outline_rounded,
          label: 'نام مدیر',
          value: item.managerFullName,
        ),
        SummaryCardInfo(
          icon: Icons.contact_mail_outlined,
          label: 'کد ملی مدیر',
          value: item.nationalNumber,
        ),
        SummaryCardInfo(
          icon: Icons.monetization_on_outlined,
          label: 'کد اقتصادی',
          value: item.economicCode,
        ),
        SummaryCardInfo(
          icon: Icons.phone_android_outlined,
          label: 'شماره تماس',
          value: item.mobileNumber ?? item.telephone,
        ),
        SummaryCardInfo(
          icon: Icons.location_on_outlined,
          label: 'آدرس',
          value: _join([item.provinceTitle, item.cityTitle, item.address]),
          maxLines: 2,
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.updateUserFullName ?? item.insertUserFullName,
          date: item.updateDateTimeJalali ?? item.insertDateTimeJalali,
        ),
      ],
      onOperation: onAction,
    );
  }

  static String? _join(List<String?> values) {
    final result = values
        .where((value) => value?.trim().isNotEmpty == true)
        .map((value) => value!.trim())
        .join('، ');
    return result.isEmpty ? null : result;
  }
}