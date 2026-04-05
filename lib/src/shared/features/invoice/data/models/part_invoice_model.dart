import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/part_invoice_entity.dart';

class PartInvoiceModel extends PartInvoiceEntity {
  const PartInvoiceModel({
    super.title,
    super.partReception,
    super.total,
  });

  factory PartInvoiceModel.fromJson(Map<String, dynamic> json) {
    return PartInvoiceModel(
      title: json['title'],
      partReception: (json['partReception'] as List?)?.map((e) => PartReceptionModel.fromJson(e)).toList(),
      total: json['total'],
    );

  }
}

class PartReceptionModel extends PartReceptionEntity {
  const PartReceptionModel({
    super.invoiceId,
    super.reusablePrice,
    super.receptionId,
    super.laborCode,
    super.laborDescription,
    super.nahveMohasebeCode,
    super.nahveMohasebeDescription,
    super.commodityCode,
    super.replaceCount,
    super.mark,
    super.partPriceRial,
    super.franchise,
    super.description,
    super.afterSaleServiceDescription,
    super.isCausing,
    super.hasReusable,
  });

  factory PartReceptionModel.fromJson(Map<String, dynamic> json) {
    return PartReceptionModel(
      invoiceId: json['invoiceId'],
      receptionId: json['receptionId'],
      reusablePrice: json['reusablePrice'],
      laborCode: json['laborCode'],
      laborDescription: json['laborDescription'],
      nahveMohasebeCode: json['nahveMohasebeCode'],
      nahveMohasebeDescription: json['nahveMohasebeDescription'],
      commodityCode: json['commodityCode'],
      replaceCount: json['replaceCount'],
      mark: json['mark'],
      partPriceRial: json['partPriceRial'],
      franchise: json['franchise'],
      description: json['description'],
      afterSaleServiceDescription: json['afterSaleServiceDescription'],
      isCausing: json['isCausing'],
      hasReusable: json['hasReusable'],
    );
  }
}