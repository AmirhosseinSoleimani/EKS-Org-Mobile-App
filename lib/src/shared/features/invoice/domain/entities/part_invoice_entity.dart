import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/part_invoice_model.dart';

class PartInvoiceEntity {
  const PartInvoiceEntity({
    this.title,
    this.partReception,
    this.total,
  });

  final String? title;
  final List<PartReceptionEntity>? partReception;
  final int? total;

  PartInvoiceModel toModel() {
    return PartInvoiceModel(
      title: title,
      partReception: partReception?.map((e) => e.toModel()).toList(),
      total: total,
    );
  }
}

class PartReceptionEntity {
  const PartReceptionEntity({
    this.invoiceId,
    this.receptionId,
    this.laborCode,
    this.laborDescription,
    this.nahveMohasebeCode,
    this.nahveMohasebeDescription,
    this.commodityCode,
    this.replaceCount,
    this.mark,
    this.partPriceRial,
    this.franchise,
    this.description,
    this.afterSaleServiceDescription,
    this.isCausing,
    this.reusablePrice,
    this.hasReusable,
  });

  final int? invoiceId;
  final int? receptionId;
  final int? reusablePrice;
  final String? laborCode;
  final String? laborDescription;
  final String? nahveMohasebeCode;
  final String? nahveMohasebeDescription;
  final String? commodityCode;
  final int? replaceCount;
  final String? mark;
  final int? partPriceRial;
  final double? franchise;
  final String? description;
  final String? afterSaleServiceDescription;
  final bool? isCausing;
  final bool? hasReusable;

  PartReceptionModel toModel() {
    return PartReceptionModel(
      reusablePrice:reusablePrice,
      invoiceId: invoiceId,
      receptionId: receptionId,
      laborCode: laborCode,
      laborDescription: laborDescription,
      nahveMohasebeCode: nahveMohasebeCode,
      nahveMohasebeDescription: nahveMohasebeDescription,
      commodityCode: commodityCode,
      replaceCount: replaceCount,
      mark: mark,
      partPriceRial: partPriceRial,
      franchise: franchise,
      description: description,
      afterSaleServiceDescription: afterSaleServiceDescription,
      isCausing: isCausing,
      hasReusable: hasReusable,
    );
  }
}