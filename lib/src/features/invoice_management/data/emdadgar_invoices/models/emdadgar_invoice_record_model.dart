import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_document_urls_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_record_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_settlement_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_record_entity.dart';

class EmdadgarInvoiceRecordModel extends EmdadgarInvoiceRecordEntity {
  const EmdadgarInvoiceRecordModel({
    super.identity,
    super.customer,
    super.agency,
    super.vehicle,
    super.amounts,
    super.state,
    super.operation,
    super.audit,
    super.settlement,
    super.documentGuid,
    super.documentUrls,
    super.checkAmendmentDaraei,
    super.checkAmendmentHesabdari,
    super.checkEmdadgarInvoiceVisible,
    super.finalizeEmdadgarInvoiceVisible,
    super.previewEmdadgarInvoiceVisible,
    super.emdadgarInvoiceVisible,
    super.agencyCoefficient,
    super.privateCarType,
    super.agencyGrade,
    super.agencyWithoutTax,
    super.agencyType,
    super.trafficPlanCost,
    super.trafficPlanCostWithCoefficient,
    super.highwayTicketCost,
    super.highwayTicketCostWithCoefficient,
    super.finalizedDateTimeJalali,
  });

  factory EmdadgarInvoiceRecordModel.fromJson(Map<String, dynamic> json) {
    final base = InvoiceRecordModel.fromJson(json);
    final documentUrls = JsonValueReader.mapValue(json['documentUrls']);

    return EmdadgarInvoiceRecordModel(
      identity: base.identity,
      customer: base.customer,
      agency: base.agency,
      vehicle: base.vehicle,
      amounts: base.amounts,
      state: base.state,
      operation: base.operation,
      audit: base.audit,
      documentGuid: JsonValueReader.stringValue(json['documentGuid']),
      documentUrls: documentUrls.isEmpty
          ? null
          : InvoiceDocumentUrlsModel.fromJson(documentUrls),
      checkAmendmentDaraei:
          JsonValueReader.boolValue(json['checkAmendmentDaraei']),
      checkAmendmentHesabdari:
          JsonValueReader.boolValue(json['checkAmendmentHesabdari']),
      checkEmdadgarInvoiceVisible:
          JsonValueReader.boolValue(json['checkEmdadgarInvoiceVisible']),
      finalizeEmdadgarInvoiceVisible:
          JsonValueReader.boolValue(json['finalizeEmdadgarInvoiceVisible']),
      previewEmdadgarInvoiceVisible:
          JsonValueReader.boolValue(json['previewEmdadgarInvoiceVisible']),
      emdadgarInvoiceVisible:
          JsonValueReader.boolValue(json['emdadgarInvoiceVisible']),
      agencyCoefficient: JsonValueReader.doubleValue(json['agencyZaribGrade']),
      privateCarType: JsonValueReader.intValue(json['khodroShakhsi']),
      agencyGrade: JsonValueReader.stringValue(json['agencyGrade']),
      agencyWithoutTax: JsonValueReader.intValue(json['agencyWithoutTax']),
      agencyType: JsonValueReader.stringValue(json['agencyType']),
      trafficPlanCost: JsonValueReader.intValue(json['tarhTicketCost']),
      trafficPlanCostWithCoefficient:
          JsonValueReader.intValue(json['tarhTicketCostWithZarib']),
      highwayTicketCost: JsonValueReader.intValue(json['highwayTicketCost']),
      highwayTicketCostWithCoefficient:
          JsonValueReader.intValue(json['highwayTicketCostWithZarib']),
      finalizedDateTimeJalali:
          JsonValueReader.stringValue(json['finalizedDateTimeJalali']),
      settlement: EmdadgarSettlementModel(
        amounts: EmdadgarSettlementAmountsModel(
          priceAfterCoefficients:
              JsonValueReader.intValue(json['priceAfterZarayebMoshtarak']),
          totalWithoutTaxAndInsurance: JsonValueReader.intValue(
            json['emdadgarTotalPriceWithoutTaxAndBime'],
          ),
          totalPrice: JsonValueReader.intValue(json['emdadgarTotalPrice']),
          distanceCost: JsonValueReader.intValue(json['distanceCost']),
          distanceCostWithCoefficient:
              JsonValueReader.intValue(json['distanceCostWithZarib']),
          entranceWageCost: JsonValueReader.intValue(json['entranceWageCost']),
          entranceWageCostWithCoefficient:
              JsonValueReader.intValue(json['entranceWageCostWithZarib']),
          towingCost: JsonValueReader.intValue(json['towingCost']),
          towingCostWithCoefficient:
              JsonValueReader.intValue(json['towingCostWithZarib']),
          loadingCost: JsonValueReader.intValue(json['loadingCost']),
          loadingCostWithCoefficient:
              JsonValueReader.intValue(json['loadingCostWithZarib']),
          stopTimeCost: JsonValueReader.intValue(json['stopTimeCost']),
          stopTimeCostWithCoefficient:
              JsonValueReader.intValue(json['stopTimeCostWithZarib']),
          useAppCost: JsonValueReader.intValue(json['useAppCost']),
          insurance: JsonValueReader.intValue(json['bime']),
          valueAddedTaxCost:
              JsonValueReader.intValue(json['valueAddedTaxCost']),
          nightAndHolidayCost:
              JsonValueReader.intValue(json['nightAndHolidayCost']),
          customerTotalPartPrice:
              JsonValueReader.intValue(json['customerTotalPartPrice']),
          companyTotalPartPrice:
              JsonValueReader.intValue(json['companyTotalPartPrice']),
          guarantyTotalPartPrice:
              JsonValueReader.intValue(json['guarantyTotalPartPrice']),
          customerTotalLaborPrice:
              JsonValueReader.intValue(json['customerTotalLaborPrice']),
          companyTotalLaborPrice:
              JsonValueReader.intValue(json['companyTotalLaborPrice']),
          guarantyTotalLaborPrice:
              JsonValueReader.intValue(json['guarantyTotalLaborPrice']),
          totalPriceWithCoefficient:
              JsonValueReader.intValue(json['emdadgarTotalPriceWithZarib']),
          customerTotalReusablePartPrice:
              JsonValueReader.intValue(json['customerTotalReusablePartPrice']),
          companyTotalReusablePartPrice:
              JsonValueReader.intValue(json['companyTotalReusablePartPrice']),
        ),
        coefficients: EmdadgarSettlementCoefficientsModel(
          privateCarText:
              JsonValueReader.stringValue(json['privateCarZaribText']),
          privateCarPrice:
              JsonValueReader.intValue(json['privateCarZaribPrice']),
          agencyGradeText:
              JsonValueReader.stringValue(json['agencyGradeText']),
          agencyGradePrice:
              JsonValueReader.intValue(json['agencyGradePrice']),
          commissionText:
              JsonValueReader.stringValue(json['commisionCoefficientText']),
          commissionPrice:
              JsonValueReader.intValue(json['commisionCoefficientPrice']),
          commissionCoefficient:
              JsonValueReader.stringValue(json['commisionCoefficientZarib']),
        ),
      ),
    );
  }
}
