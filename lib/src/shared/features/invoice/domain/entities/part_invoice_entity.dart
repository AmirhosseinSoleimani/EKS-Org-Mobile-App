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
    this.id,
    this.invoiceId,
    this.partGroupId,
    this.partGroupName,
    this.laborId,
    this.laborCode,
    this.laborDescription,
    this.nahveMohasebeId,
    this.nahveMohasebeCode,
    this.nahveMohasebeDescription,
    this.afterSaleServiceDescription,
    this.commodityCode,
    this.replaceCount,
    this.commodityDescription,
    this.mark,
    this.partPriceRial,
    this.basePrice,
    this.discountPrice,
    this.description,
    this.partReusableDescription,
    this.hasReusable,
    this.reusablePrice,
    this.isCausing,
    this.isActive,
  });

  final int? id;
  final int? invoiceId;
  final int? partGroupId;
  final String? partGroupName;
  final int? laborId;
  final String? laborCode;
  final String? laborDescription;
  final int? nahveMohasebeId;
  final String? nahveMohasebeCode;
  final String? nahveMohasebeDescription;
  final String? afterSaleServiceDescription;
  final String? commodityCode;
  final int? replaceCount;
  final String? commodityDescription;
  final String? mark;
  final int? partPriceRial;
  final int? basePrice;
  final int? discountPrice;
  final String? description;
  final String? partReusableDescription;
  final bool? hasReusable;
  final int? reusablePrice;
  final bool? isCausing;
  final bool? isActive;

  PartReceptionModel toModel() {
    return PartReceptionModel(
      id: id,
      invoiceId: invoiceId,
      partGroupId: partGroupId,
      partGroupName: partGroupName,
      laborId: laborId,
      laborCode: laborCode,
      laborDescription: laborDescription,
      nahveMohasebeId: nahveMohasebeId,
      nahveMohasebeCode: nahveMohasebeCode,
      nahveMohasebeDescription: nahveMohasebeDescription,
      afterSaleServiceDescription: afterSaleServiceDescription,
      commodityCode: commodityCode,
      replaceCount: replaceCount,
      commodityDescription: commodityDescription,
      mark: mark,
      partPriceRial: partPriceRial,
      basePrice: basePrice,
      discountPrice: discountPrice,
      description: description,
      partReusableDescription: partReusableDescription,
      hasReusable: hasReusable,
      reusablePrice: reusablePrice,
      isCausing: isCausing,
      isActive: isActive,
    );
  }
}
