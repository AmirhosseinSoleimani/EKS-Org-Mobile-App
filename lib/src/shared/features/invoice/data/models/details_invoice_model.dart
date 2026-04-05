
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/details_invoice_entity.dart';

class DetailsInvoiceModel extends DetailsInvoiceEntity {
  const DetailsInvoiceModel({
    super.title,
    super.invoiceItems,
    super.companyTotal,
    super.customerTotal,
    super.total,
  });

  factory DetailsInvoiceModel.fromJson(Map<String, dynamic> json) {
    return DetailsInvoiceModel(
      title: json['title'],
      companyTotal: json['companyTotal'],
      customerTotal: json['customerTotal'],
      total: json['total'],
      invoiceItems: (json['invoiceItems'] != null) ? (json['invoiceItems'] as List<dynamic>).map((item) => DetailsInvoiceItemModel.fromJson(item)).toList() : [],
    );
  }
}

class DetailsInvoiceItemModel extends DetailsInvoiceItemEntity {
  const DetailsInvoiceItemModel({
    super.id,
    super.invoiceId,
    super.aidItemType,
    super.aidItemTypeStr,
    super.customerPrice,
    super.companyPrice,
    super.description,
  });

  factory DetailsInvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return DetailsInvoiceItemModel(
      id: json['id'],
      invoiceId: json['invoiceId'],
      aidItemType: json['aidItemType'],
      aidItemTypeStr: json['aidItemTypeStr'],
      customerPrice: json['customerPrice'],
      companyPrice: json['companyPrice'],
      description: json['description'],
    );
  }
}