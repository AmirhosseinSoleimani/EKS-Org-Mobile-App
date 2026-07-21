import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_detail_row.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyInfoDetailsSection extends StatelessWidget {
  const AgencyInfoDetailsSection({
    super.key,
    required this.item,
  });

  final AgencyInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppPadding.p16),
      children: [
        AgencyInfoSummaryCard(item: item),
        Space.h16,
        Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: Column(
            children: [
              AgencyInfoDetailRow(label: 'نوع', value: item.typeTitle),
              AgencyInfoDetailRow(label: 'مدیر', value: item.managerFullName),
              AgencyInfoDetailRow(label: 'استان', value: item.provinceTitle),
              AgencyInfoDetailRow(label: 'شهر', value: item.cityTitle),
              AgencyInfoDetailRow(label: 'موبایل', value: item.mobileNumber),
              AgencyInfoDetailRow(label: 'تلفن', value: item.telephone),
              AgencyInfoDetailRow(label: 'کد پستی', value: item.postalCode),
              AgencyInfoDetailRow(label: 'شناسه ملی', value: item.nationalNumber),
              AgencyInfoDetailRow(label: 'کد اقتصادی', value: item.economicCode),
              AgencyInfoDetailRow(label: 'کد تفصیلی', value: item.detailCode),
              AgencyInfoDetailRow(label: 'کد رهگیری', value: item.trackingNumber),
              AgencyInfoDetailRow(label: 'وضعیت مالیاتی', value: item.taxStatusTitle),
              AgencyInfoDetailRow(label: 'آدرس', value: item.address),
            ],
          ),
        ),
        Space.h16,
        Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: Column(
            children: [
              AgencyInfoDetailRow(label: 'ثبت کننده', value: item.insertUserFullName),
              AgencyInfoDetailRow(label: 'تاریخ ثبت', value: item.insertDateTimeJalali),
              AgencyInfoDetailRow(label: 'ویرایش کننده', value: item.updateUserFullName),
              AgencyInfoDetailRow(label: 'تاریخ ویرایش', value: item.updateDateTimeJalali),
            ],
          ),
        ),
      ],
    );
  }
}
