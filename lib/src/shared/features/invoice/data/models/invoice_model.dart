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
    super.invoiceGuid,
    super.paymentTypeTitle,
    super.paymentType,
    super.sumAllInvoice,
    super.detailsInvoice,
    super.laborInvoice,
    super.partInvoice,
    super.options,
    super.otherCostInvoice,
    super.otherCosts,
    super.optionServiceInvoice,
    super.emdadgarEvaluationId,
    super.serviceInvoice,
    super.services,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      invoiceTitle: json['invoiceTitle']?.toString(),
      invoiceGuid: json['invoiceGuid']?.toString(),
      paymentTypeTitle: json['paymentTypeTitle']?.toString(),
      paymentType: (json['paymentType'] as num?)?.toInt(),
      emdadgarEvaluationId: (json['emdadgarEvaluationId'] as num?)?.toInt(),
      sumAllInvoice: _model(
        json['sumAllInvoice'],
        SumAllInvoiceModel.fromJson,
      ),
      detailsInvoice: _model(
        json['detailInvoice'],
        DetailsInvoiceModel.fromJson,
      ),
      serviceInvoice: _model(
        json['serviceInvoice'],
        ServiceInvoiceModel.fromJson,
      ),
      laborInvoice: _model(
        json['laborInvoice'],
        LaborInvoiceModel.fromJson,
      ),
      partInvoice: _model(
        json['partInvoice'],
        PartInvoiceModel.fromJson,
      ),
      otherCostInvoice: _model(
        json['otherCostInvoice'],
        OtherCostInvoiceModel.fromJson,
      ),
      otherCosts: _model(
        json['otherCosts'],
        OtherCostInvoiceModel.fromJson,
      ),
      optionServiceInvoice: _model(
        json['optionServiceInvoice'],
        ServiceInvoiceModel.fromJson,
      ),
      services: (json['services'] as List?)
          ?.whereType<Map>()
          .map(
            (item) => ServiceReceptionModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
      options: json['options'] as List<dynamic>?,
    );
  }

  static T? _model<T>(
    dynamic value,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (value is Map<String, dynamic>) return fromJson(value);
    if (value is Map) return fromJson(Map<String, dynamic>.from(value));
    return null;
  }
}
