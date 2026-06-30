import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'details_invoice_entity.dart';
import 'labor_invoice_entity.dart';
import 'other_cost_invoice_entity.dart';
import 'part_invoice_entity.dart';
import 'service_invoice_entity.dart';
import 'sum_all_invoice_entity.dart';

class InvoiceEntity {
  const InvoiceEntity({
    this.invoiceTitle,
    this.sumAllInvoice,
    this.detailsInvoice,
    this.laborInvoice,
    this.partInvoice,
    this.options,
    this.otherCosts,
    this.emdadgarEvaluationId,
    this.services,
    this.serviceInvoice,
  });

  final String? invoiceTitle;
  final int? emdadgarEvaluationId;
  final SumAllInvoiceEntity? sumAllInvoice;
  final DetailsInvoiceEntity? detailsInvoice;
  final ServiceInvoiceEntity? serviceInvoice;
  final LaborInvoiceEntity? laborInvoice;
  final PartInvoiceEntity? partInvoice;
  final OtherCostInvoiceEntity? otherCosts;
  final List<ServiceReceptionEntity>? services;
  final List<dynamic>? options;

  InvoiceModel toModel() {
    return InvoiceModel(
      invoiceTitle: invoiceTitle,
      emdadgarEvaluationId: emdadgarEvaluationId,
      sumAllInvoice: sumAllInvoice?.toModel(),
      detailsInvoice: detailsInvoice?.toModel(),
      serviceInvoice: serviceInvoice?.toModel(),
      laborInvoice: laborInvoice?.toModel(),
      partInvoice: partInvoice?.toModel(),
      otherCosts: otherCosts?.toModel(),
      services: services?.map((e) => e.toModel()).toList(),
      options: options,
    );
  }
}











