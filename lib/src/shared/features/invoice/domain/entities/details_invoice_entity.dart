
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/details_invoice_model.dart';

class DetailsInvoiceEntity {
  const DetailsInvoiceEntity({
    this.title,
    this.invoiceItems,
    this.companyTotal,
    this.customerTotal,
    this.total,
  });

  final String? title;
  final List<DetailsInvoiceItemEntity>? invoiceItems;
  final int? companyTotal;
  final int? customerTotal;
  final int? total;

  DetailsInvoiceModel toModel() {
    return DetailsInvoiceModel(
      title: title,
      invoiceItems: invoiceItems?.map((item) => item.toModel()).toList(),
      companyTotal: companyTotal,
      customerTotal: customerTotal,
      total: total,
    );
  }
}

class DetailsInvoiceItemEntity {
  const DetailsInvoiceItemEntity({
    this.id,
    this.invoiceId,
    this.aidItemType,
    this.aidItemTypeStr,
    this.customerPrice,
    this.customerBasePrice,
    this.companyPrice,
    this.customerDiscountPrice,
  });

  final int? id;
  final int? invoiceId;
  final int? aidItemType;
  final String? aidItemTypeStr;
  final int? customerPrice;
  final int? customerBasePrice;
  final int? customerDiscountPrice;
  final int? companyPrice;

  DetailsInvoiceItemModel toModel() {
    return DetailsInvoiceItemModel(
      id: id,
      invoiceId: invoiceId,
      aidItemType: aidItemType,
      aidItemTypeStr: aidItemTypeStr,
      customerPrice: customerPrice,
      customerBasePrice: customerBasePrice,
      customerDiscountPrice: customerDiscountPrice,
      companyPrice: companyPrice,
    );
  }
}