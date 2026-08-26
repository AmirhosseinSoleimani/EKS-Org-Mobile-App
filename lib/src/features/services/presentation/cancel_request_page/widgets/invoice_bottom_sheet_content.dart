import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

import '../../pre_invoice_page/widgets/details_invoice_widget.dart';
import '../../pre_invoice_page/widgets/labor_invoice_widget.dart';
import '../../pre_invoice_page/widgets/other_cost_invoice_widget.dart';
import '../../pre_invoice_page/widgets/part_invoice_widget.dart';
import '../../pre_invoice_page/widgets/sum_all_invoice_widget.dart';

class InvoiceBottomSheetContent extends StatelessWidget {
  const InvoiceBottomSheetContent({
    super.key,
    required this.invoiceEntity,
    required this.serviceType,
  });

  final InvoiceEntity invoiceEntity;
  final ServiceType serviceType;

  @override
  Widget build(BuildContext context) {
    final isHomeService = serviceType == ServiceType.homeService;
    final optionTitles = _optionTitles(invoiceEntity.options);

    return SafeArea(
      child: Column(
        children: [
          if (isHomeService)
            SumAllInvoiceWidget.homeService(entity: invoiceEntity.sumAllInvoice)
          else
            SumAllInvoiceWidget.aidService(entity: invoiceEntity.sumAllInvoice),
          const SizedBox(height: 16),
          if (isHomeService)
            DetailsInvoiceWidget.homeService(entity: invoiceEntity.detailsInvoice)
          else
            DetailsInvoiceWidget.aidService(entity: invoiceEntity.detailsInvoice),
          const SizedBox(height: 16),
          if (invoiceEntity.laborInvoice?.laborReception?.isNotEmpty ?? false) ...[
            if (isHomeService)
              LaborInvoiceWidget.homeService(entity: invoiceEntity.laborInvoice)
            else
              LaborInvoiceWidget.aidService(entity: invoiceEntity.laborInvoice),
            const SizedBox(height: 16),
          ],
          if (invoiceEntity.partInvoice?.partReception?.isNotEmpty ?? false) ...[
            if (isHomeService)
              PartInvoiceWidget.homeService(entity: invoiceEntity.partInvoice)
            else
              PartInvoiceWidget.aidService(entity: invoiceEntity.partInvoice),
            const SizedBox(height: 16),
          ],
          if (invoiceEntity.otherCosts?.otherCostReceptions?.isNotEmpty ?? false) ...[
            if (isHomeService)
              OtherCostInvoiceWidget.homeService(entity: invoiceEntity.otherCosts)
            else
              OtherCostInvoiceWidget.aidService(entity: invoiceEntity.otherCosts),
            const SizedBox(height: 16),
          ],
          if (optionTitles.isNotEmpty) _OptionsSection(titles: optionTitles),
        ],
      ),
    );
  }

  List<String> _optionTitles(List<dynamic>? options) {
    if (options == null || options.isEmpty) return const [];

    return options
        .map((option) {
          if (option is String) return option.trim();
          if (option is Map) {
            final map = Map<String, dynamic>.from(option);
            final value = map['title'] ??
                map['Title'] ??
                map['name'] ??
                map['Name'] ??
                map['serviceTitle'] ??
                map['ServiceTitle'];
            return value?.toString().trim() ?? '';
          }
          return option?.toString().trim() ?? '';
        })
        .where((title) => title.isNotEmpty)
        .toList(growable: false);
  }
}

class _OptionsSection extends StatelessWidget {
  const _OptionsSection({required this.titles});

  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(color: accentColor.withValues(alpha: .16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مزایای اشتراک',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Space.h8,
            Text(
              'با توجه به اشتراک موجود از آپشن های ذیل بهره مند هستید:',
              style: theme.textTheme.bodyMedium,
            ),
            Space.h8,
            for (final title in titles)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•'),
                    Space.w8,
                    Expanded(child: Text(title)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
