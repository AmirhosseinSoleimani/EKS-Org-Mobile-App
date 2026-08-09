import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/utils/invoice_presentation_formatter.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/widgets/invoice_amount_summary.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class CustomerInvoiceSummaryCard extends StatelessWidget {
  const CustomerInvoiceSummaryCard({
    super.key,
    required this.item,
    required this.serviceColor,
    required this.primaryActionTitle,
    required this.onPrimaryAction,
    required this.onDetails,
    this.isPrimaryLoading = false,
  });

  final InvoiceRecordEntity item;
  final Color serviceColor;
  final String primaryActionTitle;
  final VoidCallback onPrimaryAction;
  final VoidCallback onDetails;
  final bool isPrimaryLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final identity = item.identity;
    final state = item.state;
    final agency = item.agency;
    final amounts = item.amounts;
    final audit = item.audit;

    final requestTrackCode =
        identity?.requestTrackCode ?? identity?.serviceRequestTrackCode;

    return AppSummaryCard(
      titleLabel: 'شماره درخواست',
      title: 'REQ-$requestTrackCode}',
      badges: [
        StatusLabel(
          text: InvoicePresentationFormatter.display(state?.invoiceStatusTitle),
          color: InvoicePresentationFormatter.statusColor(
            context,
            state?.invoiceStatus,
          ),
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.person_outline_rounded,
          label: 'نام امدادخواه',
          value: item.customer?.fullName,
        ),
        SummaryCardInfo(
          icon: Icons.apartment_outlined,
          label: 'نام نمایندگی',
          value: InvoicePresentationFormatter.agency(
            agency?.agencyName ?? agency?.representationName,
            agency?.agencyCode ?? agency?.representationCode,
          ),
        ),
        SummaryCardInfo(
          icon: Icons.calendar_today_outlined,
          label: 'تاریخ',
          value: JalaliDateHelper.formatStringJalaliDateTime(
            identity?.serviceRequestInsertDataTimeJalali ??
                identity?.customerInvoiceDateTimeJalali,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
      afterInfo: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: AppSize.s8,
            runSpacing: AppSize.s8,
            children: [
              if (state?.ownerTypeTitle?.trim().isNotEmpty == true)
                StatusLabel(
                  text: state!.ownerTypeTitle!.trim(),
                  color: const Color(0xFF2E7D32),
                ),
              if (state?.isGaranty == true)
                const StatusLabel(
                  text: 'دارای گارانتی',
                  color: Color(0xFF2E7D32),
                ),
              if (state?.subscription == true)
                const StatusLabel(text: 'اشتراکی', color: Color(0xFF1565C0)),
            ],
          ),
          Space.h16,
          InvoiceAmountSummary(
            customerAmount: amounts?.customerTotalPrice,
            companyAmount: amounts?.companyTotalPrice,
            highlightColor: serviceColor,
          ),
        ],
      ),
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: audit?.insertUserName,
          date: JalaliDateHelper.formatStringJalaliDateTime(
            audit?.insertDateTimeJalali,
          ),
          dateTextDirection: TextDirection.rtl,
        ),
      ],
      primaryActionFlex: 50,
      operationActionFlex: 50,
      actionSpacing: AppSize.s8,
      primaryAction: InkwellButtonWidget(
        title: primaryActionTitle,
        backgroundColor: serviceColor,
        showLoading: isPrimaryLoading,
        prefixIcon: const Icon(
          Icons.receipt_long_outlined,
          color: Colors.white,
          size: AppSize.s24,
        ),
        onTap: isPrimaryLoading ? null : onPrimaryAction,
      ),
      operationAction: InkwellButtonWidget(
        title: 'جزئیات',

        backgroundColor: theme.colorScheme.secondaryContainer,
        titleColor: theme.colorScheme.onSurfaceVariant,
        prefixIcon: Icon(
          Icons.info_outline_rounded,
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight:  FontWeight.w500,
          size: AppSize.s24,
        ),
        onTap: onDetails,
      ),
    );
  }
}
