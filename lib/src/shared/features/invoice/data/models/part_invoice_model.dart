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
    super.id,
    super.invoiceId,
    super.partGroupId,
    super.partGroupName,
    super.laborId,
    super.laborCode,
    super.laborDescription,
    super.nahveMohasebeId,
    super.nahveMohasebeCode,
    super.nahveMohasebeDescription,
    super.afterSaleServiceDescription,
    super.commodityCode,
    super.replaceCount,
    super.commodityDescription,
    super.mark,
    super.partPriceRial,
    super.basePrice,
    super.discountPrice,
    super.description,
    super.hasReusable,
    super.reusablePrice,
    super.isCausing,
    super.isActive,
  });

  factory PartReceptionModel.fromJson(Map<String, dynamic> json) {
    return PartReceptionModel(
      id: json['id'],
      invoiceId: json['invoiceId'],
      partGroupId: json['partGroupId'],
      partGroupName: json['partGroupName'],
      laborId: json['laborId'],
      laborCode: json['laborCode'],
      laborDescription: json['laborDescription'],
      nahveMohasebeId: json['nahveMohasebeId'],
      nahveMohasebeCode: json['nahveMohasebeCode'],
      nahveMohasebeDescription: json['nahveMohasebeDescription'],
      afterSaleServiceDescription: json['afterSaleServiceDescription'],
      commodityCode: json['commodityCode'],
      replaceCount: json['replaceCount'],
      commodityDescription: json['commodityDescription'],
      mark: json['mark'],
      partPriceRial: json['partPriceRial'],
      basePrice: json['basePrice'],
      discountPrice: json['discountPrice'],
      description: json['description'],
      hasReusable: json['hasReusable'],
      reusablePrice: json['reusablePrice'],
      isCausing: json['isCausing'],
      isActive: json['isActive'],
    );
  }
}
