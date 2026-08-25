import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/other_cost_invoice_entity.dart';

class OtherCostInvoiceModel extends OtherCostInvoiceEntity {
  const OtherCostInvoiceModel({
    super.title,
    super.otherCostReceptions,
    super.customerTotalPrice,
    super.companyTotalPrice,
  });

  factory OtherCostInvoiceModel.fromJson(Map<String, dynamic> json) {
    final receptions =
        json['otherCostReception'] ?? json['otherCostReceptions'];
    return OtherCostInvoiceModel(
      title: json['title']?.toString(),
      otherCostReceptions: (receptions as List?)
          ?.whereType<Map>()
          .map(
            (item) => OtherCostReceptionModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
      customerTotalPrice: (json['customerTotalPrice'] as num?)?.toInt(),
      companyTotalPrice: (json['companyTotalPrice'] as num?)?.toInt(),
    );
  }
}

class OtherCostReceptionModel extends OtherCostReceptionEntity {
  const OtherCostReceptionModel({
    super.companyPrice,
    super.companyPriceWithZarib,
    super.customerPrice,
    super.customerBasePrice,
    super.customerDiscountPrice,
    super.id,
    super.invoiceId,
    super.title,
  });

  factory OtherCostReceptionModel.fromJson(Map<String, dynamic> json) {
    return OtherCostReceptionModel(
      invoiceId: (json['invoiceId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      title: json['title']?.toString(),
      companyPrice: (json['companyPrice'] as num?)?.toInt(),
      customerPrice: (json['customerPrice'] as num?)?.toInt(),
      customerBasePrice: (json['customerBasePrice'] as num?)?.toInt(),
      customerDiscountPrice:
          (json['customerDiscountPrice'] as num?)?.toInt(),
      companyPriceWithZarib:
          (json['companyPriceWithZarib'] as num?)?.toInt(),
    );
  }
}
