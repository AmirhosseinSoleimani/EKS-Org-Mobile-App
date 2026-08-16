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
    this.invoiceGuid,
    this.paymentTypeTitle,
    this.paymentType,
    this.sumAllInvoice,
    this.detailsInvoice,
    this.laborInvoice,
    this.partInvoice,
    this.options,
    this.otherCostInvoice,
    this.otherCosts,
    this.optionServiceInvoice,
    this.emdadgarEvaluationId,
    this.services,
    this.serviceInvoice,
  });

  final String? invoiceTitle;
  final String? invoiceGuid;
  final String? paymentTypeTitle;
  final int? paymentType;
  final int? emdadgarEvaluationId;
  final SumAllInvoiceEntity? sumAllInvoice;
  final DetailsInvoiceEntity? detailsInvoice;
  final ServiceInvoiceEntity? serviceInvoice;
  final LaborInvoiceEntity? laborInvoice;
  final PartInvoiceEntity? partInvoice;
  final OtherCostInvoiceEntity? otherCostInvoice;
  final OtherCostInvoiceEntity? otherCosts;
  final ServiceInvoiceEntity? optionServiceInvoice;
  final List<ServiceReceptionEntity>? services;
  final List<dynamic>? options;

  InvoiceModel toModel() {
    return InvoiceModel(
      invoiceTitle: invoiceTitle,
      invoiceGuid: invoiceGuid,
      paymentTypeTitle: paymentTypeTitle,
      paymentType: paymentType,
      emdadgarEvaluationId: emdadgarEvaluationId,
      sumAllInvoice: sumAllInvoice?.toModel(),
      detailsInvoice: detailsInvoice?.toModel(),
      serviceInvoice: serviceInvoice?.toModel(),
      laborInvoice: laborInvoice?.toModel(),
      partInvoice: partInvoice?.toModel(),
      otherCostInvoice: otherCostInvoice?.toModel(),
      otherCosts: otherCosts?.toModel(),
      optionServiceInvoice: optionServiceInvoice?.toModel(),
      services: services?.map((item) => item.toModel()).toList(),
      options: options,
    );
  }
}
