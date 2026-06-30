import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/labor_invoice_entity.dart';

class LaborInvoiceModel extends LaborInvoiceEntity {
  const LaborInvoiceModel({
    super.title,
    super.laborReception,
    super.total,
  });

  factory LaborInvoiceModel.fromJson(Map<String, dynamic> json) {
    return LaborInvoiceModel(
      title: json['title'],
      total: json['total'],
      laborReception: (json['laborReception'] != null) ? (json['laborReception'] as List<dynamic>)
          .map((item) => LaborReceptionModel.fromJson(item)).toList() : [],
    );
  }
}

class LaborReceptionModel extends LaborReceptionEntity {
  const LaborReceptionModel({
    super.id,
    super.invoiceId,
    super.laborGroupId,
    super.laborGroupDesc,
    super.laborId,
    super.laborCode,
    super.laborDescription,
    super.standardTime,
    super.nahveMohasebeId,
    super.nahveMohasebeCode,
    super.nahveMohasebeDescription,
    super.price,
    super.basePrice,
    super.discountPrice,
    super.laborTotalPriceRial,
    super.overLapCode,
    super.isCausing,
    super.isActive,
  });

  factory LaborReceptionModel.fromJson(Map<String, dynamic> json) {
    return LaborReceptionModel(
      id: json['id'],
      invoiceId: json['invoiceId'],
      laborGroupId: json['laborGroupId'],
      laborGroupDesc: json['laborGroupDesc'],
      laborId: json['laborId'],
      laborCode: json['laborCode'],
      laborDescription: json['laborDescription'],
      standardTime: (json['standardTime'] as num?)?.toDouble(),
      nahveMohasebeId: json['nahveMohasebeId'],
      nahveMohasebeCode: json['nahveMohasebeCode'],
      nahveMohasebeDescription: json['nahveMohasebeDescription'],
      price: json['price'],
      basePrice: json['basePrice'],
      discountPrice: json['discountPrice'],
      laborTotalPriceRial: json['laborTotalPriceRial'],
      overLapCode: json['overLapCode'],
      isCausing: json['isCausing'],
      isActive: json['isActive'],
    );
  }
}
