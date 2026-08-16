import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/utils/invoice_agency_objection_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class InvoiceAgencyObjectionDetailsSheet extends StatelessWidget {
  const InvoiceAgencyObjectionDetailsSheet({
    super.key,
    required this.item,
  });

  final InvoiceAgencyObjectionEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p8,
          AppPadding.p16,
          AppPadding.p24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'جزئیات درخواست اصلاحی',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
            Space.h20,
            _DetailRow(
              label: 'شماره درخواست',
              value: InvoiceAgencyObjectionFormatter.requestCode(
                item.request?.serviceRequestTrackCode,
              ),
            ),
            _DetailRow(
              label: 'نام امدادخواه',
              value: item.request?.emdadkhahFullName,
            ),
            _DetailRow(
              label: 'شماره تماس',
              value: item.request?.callMobileNumber,
            ),
            _DetailRow(
              label: 'خودرو',
              value: item.request?.carName,
            ),
            _DetailRow(
              label: 'شماره شاسی',
              value: item.request?.chassisNumber,
            ),
            _DetailRow(
              label: 'نمایندگی',
              value: InvoiceAgencyObjectionFormatter.agency(item.agency),
            ),
            _DetailRow(
              label: 'امدادگر',
              value: item.agency?.aidPerName,
            ),
            _DetailRow(
              label: 'استان / شهر',
              value: _location(),
            ),
            _DetailRow(
              label: 'وضعیت',
              value: item.identity?.statusTitle,
            ),
            _DetailRow(
              label: 'آدرس امداد',
              value: item.request?.aidAddress,
              maxLines: 3,
            ),
            _DetailRow(
              label: 'توضیحات',
              value: item.request?.description,
              maxLines: 4,
            ),
            _DetailRow(
              label: 'بررسی کننده',
              value: item.review?.checkAuthorFullName,
            ),
            _DetailRow(
              label: 'توضیحات بررسی',
              value: item.review?.checkAuthorDescription,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  String _location() {
    final values = <String>[
      if (item.agency?.provinceName?.trim().isNotEmpty == true)
        item.agency!.provinceName!.trim(),
      if (item.agency?.cityName?.trim().isNotEmpty == true)
        item.agency!.cityName!.trim(),
    ];
    return values.isEmpty ? '---' : values.join(' / ');
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.maxLines = 2,
  });

  final String label;
  final String? value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.s110,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Space.w8,
          Expanded(
            child: Text(
              InvoiceAgencyObjectionFormatter.display(value),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
