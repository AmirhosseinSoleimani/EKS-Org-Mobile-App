import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/labor_invoice_model.dart';

class LaborInvoiceEntity {
  const LaborInvoiceEntity({
    this.title,
    this.laborReception,
    this.total,
  });

  final String? title;
  final List<LaborReceptionEntity>? laborReception;
  final int? total;

  LaborInvoiceModel toModel() {
    return LaborInvoiceModel(
      title: title,
      laborReception: laborReception?.map((item) => item.toModel()).toList(),
      total: total,
    );
  }
}

class LaborReceptionEntity {
  const LaborReceptionEntity({
    this.id,
    this.invoiceId,
    this.laborGroupId,
    this.laborGroupDesc,
    this.laborId,
    this.laborCode,
    this.laborDescription,
    this.standardTime,
    this.nahveMohasebeId,
    this.nahveMohasebeCode,
    this.nahveMohasebeDescription,
    this.price,
    this.basePrice,
    this.discountPrice,
    this.laborTotalPriceRial,
    this.overLapCode,
    this.isCausing,
    this.isActive,
  });

  final int? id;
  final int? invoiceId;
  final int? laborGroupId;
  final String? laborGroupDesc;
  final int? laborId;
  final String? laborCode;
  final String? laborDescription;
  final double? standardTime;
  final int? nahveMohasebeId;
  final String? nahveMohasebeCode;
  final String? nahveMohasebeDescription;
  final int? price;
  final int? basePrice;
  final int? discountPrice;
  final int? laborTotalPriceRial;
  final String? overLapCode;
  final bool? isCausing;
  final bool? isActive;

  LaborReceptionModel toModel() {
    return LaborReceptionModel(
      id: id,
      invoiceId: invoiceId,
      laborGroupId: laborGroupId,
      laborGroupDesc: laborGroupDesc,
      laborId: laborId,
      laborCode: laborCode,
      laborDescription: laborDescription,
      standardTime: standardTime,
      nahveMohasebeId: nahveMohasebeId,
      nahveMohasebeCode: nahveMohasebeCode,
      nahveMohasebeDescription: nahveMohasebeDescription,
      price: price,
      basePrice: basePrice,
      discountPrice: discountPrice,
    );
  }
}