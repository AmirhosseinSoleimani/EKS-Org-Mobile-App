import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/common/utils/invoice_presentation_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/key_value_row.dart';
import 'package:flutter/material.dart';

class InvoiceRecordDetailsSheet extends StatelessWidget {
  const InvoiceRecordDetailsSheet({
    super.key,
    required this.item,
  });

  final InvoiceRecordEntity item;

  @override
  Widget build(BuildContext context) {
    final identity = item.identity;
    final state = item.state;
    final agency = item.agency;
    final vehicle = item.vehicle;
    final operation = item.operation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'جزئیات درخواست',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        Space.h16,
        KeyValueRow(
          label: 'شماره درخواست',
          value: InvoicePresentationFormatter.requestCode(
            identity?.requestTrackCode ?? identity?.serviceRequestTrackCode,
          ),
        ),
        KeyValueRow(
          label: 'امدادخواه',
          value: InvoicePresentationFormatter.display(item.customer?.fullName),
        ),
        KeyValueRow(
          label: 'نمایندگی',
          value: InvoicePresentationFormatter.agency(
            agency?.agencyName ?? agency?.representationName,
            agency?.agencyCode ?? agency?.representationCode,
          ),
        ),
        KeyValueRow(
          label: 'امدادگر',
          value: InvoicePresentationFormatter.display(agency?.emdadgarName),
        ),
        KeyValueRow(
          label: 'خودرو',
          value: InvoicePresentationFormatter.display(vehicle?.carName),
        ),
        KeyValueRow(
          label: 'شماره شاسی',
          value: InvoicePresentationFormatter.display(vehicle?.chassisNumber),
        ),
        KeyValueRow(
          label: 'خدمت',
          value: InvoicePresentationFormatter.display(state?.serviceTitle),
        ),
        KeyValueRow(
          label: 'دسته خدمت',
          value: InvoicePresentationFormatter.display(
            state?.serviceCategoryTitle,
          ),
        ),
        KeyValueRow(
          label: 'ایراد',
          value: InvoicePresentationFormatter.display(
            vehicle?.serviceRequestDefectTitle ?? vehicle?.defectInfoTitle,
          ),
        ),
        KeyValueRow(
          label: 'وضعیت فاکتور',
          value: InvoicePresentationFormatter.display(
            state?.invoiceStatusTitle,
          ),
        ),
        KeyValueRow(
          label: 'نوع مالک',
          value: InvoicePresentationFormatter.display(state?.ownerTypeTitle),
        ),
        KeyValueRow(
          label: 'روز/تعطیل',
          value: InvoicePresentationFormatter.display(
            operation?.nightOrHolidayTitle,
          ),
        ),
        KeyValueRow(
          label: 'تاریخ درخواست',
          value: JalaliDateHelper.formatStringJalaliDateTime(
            identity?.serviceRequestInsertDataTimeJalali,
          ),
        ),
      ],
    );
  }
}
