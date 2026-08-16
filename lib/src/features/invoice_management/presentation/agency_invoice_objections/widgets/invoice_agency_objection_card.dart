import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/models/agency_correction_request_status_style.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/utils/invoice_agency_objection_formatter.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/widgets/invoice_agency_objection_review_panel.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/theme/app_semantic_colors.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class InvoiceAgencyObjectionCard extends StatelessWidget {
  const InvoiceAgencyObjectionCard({
    super.key,
    required this.item,
    required this.onDetailsTap,
  });

  final InvoiceAgencyObjectionEntity item;
  final VoidCallback onDetailsTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = theme.extension<AppSemanticColors>()!;
    final statusType = AgencyCorrectionRequestStatusType.resolve(
      status: item.identity?.status,
      title: item.identity?.statusTitle,
    );
    final statusPalette = statusType.palette(
      semanticColors: semanticColors,
      colorScheme: theme.colorScheme,
    );

    return AppSummaryCard(
      title: InvoiceAgencyObjectionFormatter.requestCode(
        item.request?.serviceRequestTrackCode,
      ),
      subtitle: JalaliDateHelper.formatStringJalaliDateTime(
        item.audit?.insertDateTimeJalali,
      ),
      badges: [
        StatusLabel(
          text: InvoiceAgencyObjectionFormatter.display(
            item.identity?.statusTitle,
          ),
          color: statusPalette.textColor,
          backgroundColor: statusPalette.backgroundColor,
          fontSize: 11,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          label: 'نام امدادخواه',
          value: item.request?.emdadkhahFullName,
          icon: Icons.person_outline_rounded,
        ),
        SummaryCardInfo(
          label: 'نام نمایندگی',
          value: InvoiceAgencyObjectionFormatter.agency(item.agency),
          icon: Icons.business_outlined,
        ),
      ],
      afterInfo: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Description(text: item.request?.description),
          Space.h16,
          InvoiceAgencyObjectionReviewPanel(review: item.review),
        ],
      ),
      primaryAction: InkwellButtonWidget(
        title: 'مشاهده جزئیات',
        backgroundColor: theme.colorScheme.onPrimary,
        borderColor: theme.colorScheme.primary,
        titleColor: theme.colorScheme.primary,
        prefixIcon: Icon(
          Icons.remove_red_eye_outlined,
          color: theme.colorScheme.primary,
          size: AppSize.s22,
        ),
        onTap: onDetailsTap,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onTertiaryFixed;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'توضیحات: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: InvoiceAgencyObjectionFormatter.display(text),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
      textDirection: TextDirection.rtl,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
