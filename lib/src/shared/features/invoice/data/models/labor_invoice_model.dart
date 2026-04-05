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
    super.invoiceId,
    super.receptionId,
    super.laborCode,
    super.laborDescription,
    super.nahveMohasebeCode,
    super.nahveMohasebeDescription,
    super.standardTime,
    super.price,
    super.laborTotalPriceRial,
    super.franchise,
    super.serviceCode,
    super.afterSaleServiceDescription,
    super.isCausing,
    super.isActive,
  });

  factory LaborReceptionModel.fromJson(Map<String, dynamic> json) {
    return LaborReceptionModel(
      invoiceId: json['invoiceId'],
      receptionId: json['receptionId'],
      laborCode: json['laborCode'],
      laborDescription: json['laborDescription'],
      nahveMohasebeCode: json['nahveMohasebeCode'],
      nahveMohasebeDescription: json['nahveMohasebeDescription'],
      standardTime: json['standardTime'],
      price: json['price'],
      laborTotalPriceRial: json['laborTotalPriceRial'],
      franchise: json['franchise'],
      serviceCode: json['serviceCode'],
      afterSaleServiceDescription: json['afterSaleServiceDescription'],
      isCausing: json['isCausing'],
      isActive: json['isActive'],
    );
  }
}