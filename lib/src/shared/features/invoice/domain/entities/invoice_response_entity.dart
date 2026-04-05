import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_response_model.dart';
import 'details_invoice_entity.dart';
import 'labor_invoice_entity.dart';
import 'other_cost_invoice_entity.dart';
import 'part_invoice_entity.dart';
import 'sum_all_invoice_entity.dart';

class InvoiceResponseEntity {
  const InvoiceResponseEntity({
    this.invoiceTitle,
    this.sumAllInvoice,
    this.detailsInvoice,
    this.laborInvoice,
    this.partInvoice,
    this.options,
    this.otherCosts,
    this.emdadgarEvaluationId,
  });

  final String? invoiceTitle;
  final int? emdadgarEvaluationId;
  final SumAllInvoiceEntity? sumAllInvoice;
  final DetailsInvoiceEntity? detailsInvoice;
  final LaborInvoiceEntity? laborInvoice;
  final PartInvoiceEntity? partInvoice;
  final List<dynamic>? options;
  final OtherCostInvoiceEntity? otherCosts;

  InvoiceResponseModel toModel() {
    return InvoiceResponseModel(
      emdadgarEvaluationId: emdadgarEvaluationId,
      invoiceTitle: invoiceTitle,
      sumAllInvoice: sumAllInvoice?.toModel(),
      detailsInvoice: detailsInvoice?.toModel(),
      laborInvoice: laborInvoice?.toModel(),
      partInvoice: partInvoice?.toModel(),
      options: options,
      otherCosts: otherCosts?.toModel(),
    );
  }
}











