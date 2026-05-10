import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:flutter/material.dart';

import '../../pre_invoice_page/widgets/details_invoice_widget.dart';
import '../../pre_invoice_page/widgets/labor_invoice_widget.dart';
import '../../pre_invoice_page/widgets/other_cost_invoice_widget.dart';
import '../../pre_invoice_page/widgets/part_invoice_widget.dart';
import '../../pre_invoice_page/widgets/sum_all_invoice_widget.dart';

class InvoiceBottomSheetContent extends StatelessWidget {
  const InvoiceBottomSheetContent({super.key, required this.invoiceEntity});

  final InvoiceEntity invoiceEntity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SumAllInvoiceWidget.homeService(entity: invoiceEntity.sumAllInvoice),
          const SizedBox(height: 16),
          DetailsInvoiceWidget.homeService(
            entity: invoiceEntity.detailsInvoice,
          ),
          const SizedBox(height: 16),
          if (invoiceEntity.laborInvoice?.laborReception?.isNotEmpty ?? false)
            LaborInvoiceWidget.homeService(entity: invoiceEntity.laborInvoice),
          const SizedBox(height: 16),
          if (invoiceEntity.partInvoice?.partReception?.isNotEmpty ?? false)
            PartInvoiceWidget.homeService(entity: invoiceEntity?.partInvoice),
          const SizedBox(height: 16),
          if (invoiceEntity.otherCosts?.otherCostReceptions?.isNotEmpty ??
              false)
            OtherCostInvoiceWidget.homeService(
              entity: invoiceEntity?.otherCosts,
            ),
        ],
      ),
    );
  }
}
