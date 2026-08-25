import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/utils/invoice_presentation_formatter.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/models/emdadgar_invoice_status_style.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/color_extension.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/theme/app_semantic_colors.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class EmdadgarInvoiceSummaryCard extends StatelessWidget {
  const EmdadgarInvoiceSummaryCard({
    super.key,
    required this.item,
    required this.selected,
    required this.onSelectionChanged,
    required this.onInvoiceTap,
    required this.onOperationsTap,
    this.selectionEnabled = true,
  });

  final EmdadgarInvoiceRecordEntity item;
  final bool selected;
  final ValueChanged<bool> onSelectionChanged;
  final VoidCallback? onInvoiceTap;
  final VoidCallback onOperationsTap;
  final bool selectionEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<AppSemanticColors>()!;
    final statusType = EmdadgarInvoiceStatusType.resolve(
      status: item.state?.invoiceStatus,
      title: _statusTitle,
    );
    final statusPalette = statusType.palette(
      semanticColors: semanticColors,
      colorScheme: theme.colorScheme,
    );
    final secondaryBadgeColor = theme.colorScheme.onPrimaryFixed;
    final successColor = theme.colorScheme.onError;

    return AppSummaryCard(
      title: _requestTitle,
      subtitle: _headerDate,
      leading: selectionEnabled
          ? Checkbox(
              value: selected,
              activeColor: theme.colorScheme.primary,
              side: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: .55),
              ),
              onChanged: (value) => onSelectionChanged(value ?? false),
            )
          : null,
      badges: [
        StatusLabel(
          text: _statusTitle,
          color: statusPalette.textColor,
          backgroundColor: statusPalette.backgroundColor,
        ),
        StatusLabel(
          text: _ownerTitle,
          color: secondaryBadgeColor,
          backgroundColor: theme.colorScheme.secondaryContainer,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          label: 'نام امدادخواه',
          value: item.customer?.fullName,
          icon: Icons.person_outline,
        ),
        SummaryCardInfo(
          label: 'نام نمایندگی',
          value: _agencyTitle,
          icon: Icons.business_outlined,
        ),
        SummaryCardInfo(
          label: 'تاریخ فاکتور',
          value: _invoiceDate,
          icon: Icons.calendar_today_outlined,
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
              StatusLabel(
                text: item.state?.subscription == true ? 'مشترک' : 'غیر مشترک',
                color: item.state?.subscription == true
                    ? successColor
                    : theme.colorScheme.onPrimaryFixed,
                backgroundColor: item.state?.subscription == true
                    ? Color.lerp(theme.colorScheme.onPrimary, successColor, .14)
                    : theme.colorScheme.secondaryContainer,
              ),
              StatusLabel(
                text: item.state?.isGaranty == true
                    ? 'دارای گارانتی'
                    : 'بدون گارانتی',
                color: item.state?.isGaranty == true
                    ? successColor
                    : theme.colorScheme.onPrimaryFixed,
                backgroundColor: item.state?.isGaranty == true
                    ? Color.lerp(theme.colorScheme.onPrimary, successColor, .14)
                    : theme.colorScheme.secondaryContainer,
              ),
            ],
          ),
          Space.h16,
          _RepresentativeAmount(amount: _representativeAmount),
        ],
      ),
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.audit?.insertUserName,
          date: JalaliDateHelper.formatStringJalaliDateTime(
            item.audit?.insertDateTimeJalali,
          ),
          dateTextDirection: TextDirection.rtl,
        ),
      ],
      primaryActionFlex: 50,
      operationActionFlex: 50,
      actionSpacing: AppSize.s8,
      primaryAction: InkwellButtonWidget(
        title: 'صورت وضعیت',
        onTap: onInvoiceTap,
        prefixIcon: Icon(
          Icons.receipt_long_outlined,
          size: AppSize.s20,
          color: theme.colorScheme.onPrimary,
        ),
      ),
      onOperation: onOperationsTap,
    );
  }

  String get _requestTitle {
    final code = item.identity?.requestTrackCode ??
        item.identity?.serviceRequestTrackCode;
    return code == null ? 'REQ----' : 'REQ-$code';
  }

  String get _statusTitle {
    final value = item.state?.invoiceStatusTitle?.trim();
    return value == null || value.isEmpty ? 'ارزیابی شده' : value;
  }


  String get _ownerTitle {
    final value = item.state?.ownerTypeTitle?.trim();
    return value == null || value.isEmpty ? 'نماینده' : value;
  }

  String get _agencyTitle {
    final name = item.agency?.agencyName ?? item.agency?.representationName;
    final code = item.agency?.agencyCode ?? item.agency?.representationCode;
    final normalizedName = name?.trim();
    final normalizedCode = code?.trim();

    if (normalizedName == null || normalizedName.isEmpty) {
      return normalizedCode ?? '---';
    }
    if (normalizedCode == null || normalizedCode.isEmpty) return normalizedName;
    return '$normalizedName ($normalizedCode)';
  }

  String get _headerDate {
    return JalaliDateHelper.formatStringJalaliDateTime(
      item.audit?.insertDateTimeJalali ??
          item.identity?.serviceRequestInsertDataTimeJalali ??
          item.identity?.requestDateTimeJalali,
    );
  }

  String get _invoiceDate {
    return JalaliDateHelper.formatStringJalaliDateTime(
      item.identity?.customerInvoiceDateTimeJalali,
    );
  }

  int? get _representativeAmount {
    return item.settlement?.amounts?.totalPrice ??
        item.amounts?.companyTotalPrice;
  }
}

class _RepresentativeAmount extends StatelessWidget {
  const _RepresentativeAmount({required this.amount});

  final int? amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'جمع مبلغ پرداختی به نماینده:',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Space.w8,
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                InvoicePresentationFormatter.rial(amount),
                textDirection: TextDirection.rtl,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary.darken(),
                  fontWeight: FontWeight.w800,
                  fontSize: AppSize.s18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
