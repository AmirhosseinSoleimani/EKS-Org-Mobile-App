

import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/other_cost_invoice_model.dart';

class OtherCostInvoiceEntity {
  const OtherCostInvoiceEntity({
    this.title,
    this.otherCostReceptions,
    this.customerTotalPrice,
    this.companyTotalPrice,
  });

  final String? title;
  final List<OtherCostReceptionEntity>? otherCostReceptions;
  final int? customerTotalPrice;
  final int? companyTotalPrice;

  OtherCostInvoiceModel toModel() {
    return OtherCostInvoiceModel(
      title: title,
      otherCostReceptions: otherCostReceptions?.map((reception) => reception.toModel()).toList(),
      customerTotalPrice: customerTotalPrice,
      companyTotalPrice: companyTotalPrice,
    );
  }
}

class OtherCostReceptionEntity {
  const OtherCostReceptionEntity({
    this.id,
    this.title,
    this.companyPrice,
    this.customerPrice,
    this.customerBasePrice,
    this.customerDiscountPrice,
    this.invoiceId,
    this.companyPriceWithZarib
  });

  final int? id;
  final int? customerPrice;
  final int? customerBasePrice;
  final int? customerDiscountPrice;
  final int? companyPrice;
  final int? invoiceId;
  final int? companyPriceWithZarib;
  final String? title;

  OtherCostReceptionModel toModel() {
    return OtherCostReceptionModel(
        id: id,
        invoiceId: invoiceId,
        title: title,
        companyPrice: companyPrice,
        companyPriceWithZarib: companyPriceWithZarib,
        customerPrice: customerPrice,
        customerBasePrice: customerBasePrice,
        customerDiscountPrice: customerDiscountPrice
    );
  }
}