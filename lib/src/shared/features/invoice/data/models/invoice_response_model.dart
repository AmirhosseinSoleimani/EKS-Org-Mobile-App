import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/sum_all_invoice_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_response_entity.dart';

import 'details_invoice_model.dart';
import 'labor_invoice_model.dart';
import 'other_cost_invoice_model.dart';
import 'part_invoice_model.dart';

class InvoiceResponseModel extends InvoiceResponseEntity {
  const InvoiceResponseModel({
    super.invoiceTitle,
    super.sumAllInvoice,
    super.detailsInvoice,
    super.laborInvoice,
    super.partInvoice,
    super.options,
    super.otherCosts,
    super.emdadgarEvaluationId,
  });

  factory InvoiceResponseModel.fromJson(Map<String, dynamic> json) {
    return InvoiceResponseModel(
        invoiceTitle: json['invoiceTitle'],
        emdadgarEvaluationId: json['emdadgarEvaluationId'],
        sumAllInvoice: json['sumAllInvoice'] != null ? SumAllInvoiceModel.fromJson(json['sumAllInvoice']) : null,
        detailsInvoice: json['detailInvoice'] != null ? DetailsInvoiceModel.fromJson(json['detailInvoice']) : null,
        laborInvoice: json['laborInvoice'] != null ? LaborInvoiceModel.fromJson(json['laborInvoice']) : null,
        partInvoice: json['partInvoice'] != null ? PartInvoiceModel.fromJson(json['partInvoice']) : null,
        options: json['options'] as List<dynamic>?,
        otherCosts: json['otherCosts'] != null ? OtherCostInvoiceModel.fromJson(json['otherCosts']): null,
    );
  }
}











