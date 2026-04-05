import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/other_cost_invoice_entity.dart';

class OtherCostInvoiceModel extends OtherCostInvoiceEntity {
  const OtherCostInvoiceModel({
    super.title,
    super.otherCostReceptions,
    super.customerTotalPrice,
    super.companyTotalPrice,
  });

  factory OtherCostInvoiceModel.fromJson(Map<String, dynamic> json) {
    return OtherCostInvoiceModel(
      title: json['title'],
      otherCostReceptions: (json['otherCostReceptions'] as List<dynamic>?)?.map((e) => OtherCostReceptionModel.fromJson(e)).toList(),
      customerTotalPrice: json['customerTotalPrice'],
      companyTotalPrice: json['companyTotalPrice'],
    );
  }
}

class OtherCostReceptionModel extends OtherCostReceptionEntity {
  const OtherCostReceptionModel({
    super.companyPrice,
    super.companyPriceWithZarib,
    super.customerPrice,
    super.id,
    super.invoiceId,
    super.title
  });

  factory OtherCostReceptionModel.fromJson(Map<String, dynamic> json) {
    return OtherCostReceptionModel(
      invoiceId: json['invoiceId'],
      id: json['id'],
      title: json['title'],
      companyPrice: json['companyPrice'],
      customerPrice: json['customerPrice'],
      companyPriceWithZarib: json['companyPriceWithZarib'],
    );
  }
}