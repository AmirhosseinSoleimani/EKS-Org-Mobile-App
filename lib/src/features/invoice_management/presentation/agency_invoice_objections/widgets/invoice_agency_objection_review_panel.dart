import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/utils/invoice_agency_objection_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class InvoiceAgencyObjectionReviewPanel extends StatelessWidget {
  const InvoiceAgencyObjectionReviewPanel({
    super.key,
    required this.review,
  });

  final InvoiceAgencyObjectionReviewEntity? review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onPrimaryFixed;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'بررسی کننده: ${InvoiceAgencyObjectionFormatter.display(review?.checkAuthorFullName)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Space.w8,
              Expanded(
                child: Text(
                  'تاریخ بررسی: ${JalaliDateHelper.formatStringJalaliDateTime(review?.checkAuthorDateTimeJalali)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Space.h8,
          Divider(height: AppSize.s1, color: theme.dividerColor),
          Space.h12,
          Text(
            InvoiceAgencyObjectionFormatter.display(
              review?.checkAuthorDescription,
            ),
            textAlign: TextAlign.start,
            textDirection: TextDirection.rtl,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
