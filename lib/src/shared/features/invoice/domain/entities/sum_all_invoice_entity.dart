import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/sum_all_invoice_model.dart';

class SumAllInvoiceEntity {
  const SumAllInvoiceEntity({
    this.title,
    this.detailEmdadInvoiceTotalCompany,
    this.detailEmdadInvoiceTotalCustomer,
    this.customerPaymentPrice,
    this.totalAgencyShare,
    this.emdadKhodroShare,
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
    this.evaluationChangedTitle,
    this.emdadServiceCategoryTitle,
    this.detailEmdadgarInvoiceBase,
    this.detailEmdadgarInvoiceBaseText,
    this.detailEmdadInvoiceTotalCustomerTax,
    this.detailEmdadInvoiceTotalCustomerTaxText,
    this.emdadgarInvoiceBaseAndTaxCustomer,
    this.emdadgarInvoiceBaseAndTaxCustomerText,
    this.useAppCost,
    this.useAppCostText,
    this.privateCar,
    this.privateCarText,
    this.agencyGrade,
    this.agencyGradeText,
    this.emdadgarBimePrice,
    this.emdadgarBimePriceText,
    this.emdadgarTaxPrice,
    this.emdadgarTaxPriceText,
    this.emdadgarTotalPrice,
    this.commisionCoefficientPrice,
    this.commisionCoefficientText,
    this.hasReusable,
    this.discountTotalPrice,
  });

  final String? title;
  final int? detailEmdadInvoiceTotalCompany;
  final int? detailEmdadInvoiceTotalCustomer;
  final int? customerPaymentPrice;
  final int? totalAgencyShare;
  final int? emdadKhodroShare;
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
  final String? evaluationChangedTitle;
  final String? emdadServiceCategoryTitle;
  final int? detailEmdadgarInvoiceBase;
  final String? detailEmdadgarInvoiceBaseText;
  final int? detailEmdadInvoiceTotalCustomerTax;
  final String? detailEmdadInvoiceTotalCustomerTaxText;
  final int? emdadgarInvoiceBaseAndTaxCustomer;
  final String? emdadgarInvoiceBaseAndTaxCustomerText;
  final int? useAppCost;
  final String? useAppCostText;
  final int? privateCar;
  final String? privateCarText;
  final num? agencyGrade;
  final String? agencyGradeText;
  final int? emdadgarBimePrice;
  final String? emdadgarBimePriceText;
  final int? emdadgarTaxPrice;
  final String? emdadgarTaxPriceText;
  final int? emdadgarTotalPrice;
  final int? commisionCoefficientPrice;
  final String? commisionCoefficientText;

  SumAllInvoiceModel toModel() {
    return SumAllInvoiceModel(
      title: title,
      detailEmdadInvoiceTotalCompany: detailEmdadInvoiceTotalCompany,
      detailEmdadInvoiceTotalCustomer: detailEmdadInvoiceTotalCustomer,
      customerPaymentPrice: customerPaymentPrice,
      totalAgencyShare: totalAgencyShare,
      emdadKhodroShare: emdadKhodroShare,
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
      evaluationChangedTitle: evaluationChangedTitle,
      emdadServiceCategoryTitle: emdadServiceCategoryTitle,
      detailEmdadgarInvoiceBase: detailEmdadgarInvoiceBase,
      detailEmdadgarInvoiceBaseText: detailEmdadgarInvoiceBaseText,
      detailEmdadInvoiceTotalCustomerTax: detailEmdadInvoiceTotalCustomerTax,
      detailEmdadInvoiceTotalCustomerTaxText:
          detailEmdadInvoiceTotalCustomerTaxText,
      emdadgarInvoiceBaseAndTaxCustomer: emdadgarInvoiceBaseAndTaxCustomer,
      emdadgarInvoiceBaseAndTaxCustomerText:
          emdadgarInvoiceBaseAndTaxCustomerText,
      useAppCost: useAppCost,
      useAppCostText: useAppCostText,
      privateCar: privateCar,
      privateCarText: privateCarText,
      agencyGrade: agencyGrade,
      agencyGradeText: agencyGradeText,
      emdadgarBimePrice: emdadgarBimePrice,
      emdadgarBimePriceText: emdadgarBimePriceText,
      emdadgarTaxPrice: emdadgarTaxPrice,
      emdadgarTaxPriceText: emdadgarTaxPriceText,
      emdadgarTotalPrice: emdadgarTotalPrice,
      commisionCoefficientPrice: commisionCoefficientPrice,
      commisionCoefficientText: commisionCoefficientText,
      hasReusable: hasReusable,
      discountTotalPrice: discountTotalPrice,
    );
  }
}
