import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/sum_all_invoice_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';

import 'details_invoice_model.dart';
import 'labor_invoice_model.dart';
import 'other_cost_invoice_model.dart';
import 'part_invoice_model.dart';
import 'service_invoice_model.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    super.invoiceTitle,
    super.sumAllInvoice,
    super.detailsInvoice,
    super.laborInvoice,
    super.partInvoice,
    super.options,
    super.otherCosts,
    super.emdadgarEvaluationId,
    super.serviceInvoice,
    super.services,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      invoiceTitle: json['invoiceTitle'],
      emdadgarEvaluationId: json['emdadgarEvaluationId'],
      sumAllInvoice: json['sumAllInvoice'] != null
          ? SumAllInvoiceModel.fromJson(json['sumAllInvoice'])
          : null,
      detailsInvoice: json['detailInvoice'] != null
          ? DetailsInvoiceModel.fromJson(json['detailInvoice'])
          : null,
      serviceInvoice: json['serviceInvoice'] != null
          ? ServiceInvoiceModel.fromJson(json['serviceInvoice'])
          : null,
      laborInvoice: json['laborInvoice'] != null
          ? LaborInvoiceModel.fromJson(json['laborInvoice'])
          : null,
      partInvoice: json['partInvoice'] != null
          ? PartInvoiceModel.fromJson(json['partInvoice'])
          : null,
      otherCosts: json['otherCosts'] != null
          ? OtherCostInvoiceModel.fromJson(json['otherCosts'])
          : null,
      services: json['services'] != null
          ? (json['services'] as List)
              .map((e) => ServiceReceptionModel.fromJson(e))
              .toList()
          : null,
      options: json['options'] as List<dynamic>?,
    );
  }
}











