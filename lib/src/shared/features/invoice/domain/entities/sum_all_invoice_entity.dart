import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/sum_all_invoice_model.dart';

class SumAllInvoiceEntity {
  const SumAllInvoiceEntity({
    this.title,
    this.detailEmdadInvoiceTotalCompany,
    this.detailEmdadInvoiceTotalCustomer,
    this.customerPaymentPrice,
    this.totalReusableCustomerPrice,
    this.totalReusableCompanyPrice,
    this.laborTotal,
    this.laborCustomerTotal,
    this.laborCompanyTotal,
    this.partTotal,
    this.partCustomerTotal,
    this.partCompanyTotal,
    this.valueAddedTax,
    this.taxTotalCustomerText,
    this.taxTotalCustomer,
    this.taxTotalCompany,
    this.totalAllItems,
    this.totalOtherCostCustomerPrice,
    this.totalOtherCostCompanyPrice,
    this.totalAllItemsCompany,
    this.totalAllItemsCustomer,
    this.isSubscription,
    this.isGuaranty,
    this.isCancelInvoice,
    this.isEvaluationChanged,
    this.detailEmdadgarInvoiceBase,
    this.detailEmdadInvoiceTotalCustomerTax,
    this.emdadgarInvoiceBaseAndTaxCustomer,
    this.hasReusable,
    this.discountTotalPrice,
  });

  final String? title;
  final int? detailEmdadInvoiceTotalCompany;
  final int? detailEmdadInvoiceTotalCustomer;
  final int? customerPaymentPrice;
  final int? totalReusableCustomerPrice;
  final int? totalReusableCompanyPrice;
  final bool? hasReusable;
  final int? laborTotal;
  final int? laborCustomerTotal;
  final int? laborCompanyTotal;
  final int? partTotal;
  final int? partCustomerTotal;
  final int? partCompanyTotal;
  final int? valueAddedTax;
  final String? taxTotalCustomerText;
  final int? taxTotalCustomer;
  final int? discountTotalPrice;
  final int? taxTotalCompany;
  final int? totalAllItems;
  final int? totalOtherCostCustomerPrice;
  final int? totalOtherCostCompanyPrice;
  final int? totalAllItemsCompany;
  final int? totalAllItemsCustomer;
  final bool? isSubscription;
  final bool? isGuaranty;
  final bool? isCancelInvoice;
  final bool? isEvaluationChanged;
  final int? detailEmdadgarInvoiceBase;
  final int? detailEmdadInvoiceTotalCustomerTax;
  final int? emdadgarInvoiceBaseAndTaxCustomer;

  SumAllInvoiceModel toModel() {
    return SumAllInvoiceModel(
      title: title,
      detailEmdadInvoiceTotalCompany: detailEmdadInvoiceTotalCompany,
      detailEmdadInvoiceTotalCustomer: detailEmdadInvoiceTotalCustomer,
      customerPaymentPrice: customerPaymentPrice,
      totalReusableCustomerPrice: totalReusableCustomerPrice,
      totalReusableCompanyPrice: totalReusableCompanyPrice,
      laborTotal: laborTotal,
      laborCustomerTotal: laborCustomerTotal,
      laborCompanyTotal: laborCompanyTotal,
      partTotal: partTotal,
      partCustomerTotal: partCustomerTotal,
      partCompanyTotal: partCompanyTotal,
      valueAddedTax: valueAddedTax,
      taxTotalCustomerText: taxTotalCustomerText,
      taxTotalCustomer: taxTotalCustomer,
      taxTotalCompany: taxTotalCompany,
      totalAllItems: totalAllItems,
      totalOtherCostCustomerPrice: totalOtherCostCustomerPrice,
      totalOtherCostCompanyPrice: totalOtherCostCompanyPrice,
      totalAllItemsCompany: totalAllItemsCompany,
      totalAllItemsCustomer: totalAllItemsCustomer,
      isSubscription: isSubscription,
      isGuaranty: isGuaranty,
      isCancelInvoice: isCancelInvoice,
      isEvaluationChanged: isEvaluationChanged,
      detailEmdadgarInvoiceBase: detailEmdadgarInvoiceBase,
      detailEmdadInvoiceTotalCustomerTax: detailEmdadInvoiceTotalCustomerTax,
      emdadgarInvoiceBaseAndTaxCustomer: emdadgarInvoiceBaseAndTaxCustomer,
      hasReusable: hasReusable,
      discountTotalPrice: discountTotalPrice,
    );
  }
}