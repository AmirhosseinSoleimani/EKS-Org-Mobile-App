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
    this.invoiceId,
    this.receptionId,
    this.laborCode,
    this.laborDescription,
    this.nahveMohasebeCode,
    this.nahveMohasebeDescription,
    this.standardTime,
    this.price,
    this.laborTotalPriceRial,
    this.franchise,
    this.serviceCode,
    this.afterSaleServiceDescription,
    this.isCausing,
    this.isActive,
  });

  final int? invoiceId;
  final int? receptionId;
  final String? laborCode;
  final String? laborDescription;
  final String? nahveMohasebeCode;
  final String? nahveMohasebeDescription;
  final double? standardTime;
  final int? price;
  final int? laborTotalPriceRial;
  final double? franchise;
  final String? serviceCode;
  final String? afterSaleServiceDescription;
  final bool? isCausing;
  final bool? isActive;

  LaborReceptionModel toModel() {
    return LaborReceptionModel(
      invoiceId: invoiceId,
      receptionId: receptionId,
      laborCode: laborCode,
      laborDescription: laborDescription,
      nahveMohasebeCode: nahveMohasebeCode,
      nahveMohasebeDescription: nahveMohasebeDescription,
      standardTime: standardTime,
      price: price,
      laborTotalPriceRial: laborTotalPriceRial,
      franchise: franchise,
      serviceCode: serviceCode,
      afterSaleServiceDescription: afterSaleServiceDescription,
      isCausing: isCausing,
      isActive: isActive,
    );
  }
}