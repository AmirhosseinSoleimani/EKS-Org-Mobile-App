import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_record_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_document_urls_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'emdadgar_settlement_entity.dart';

class EmdadgarInvoiceRecordEntity extends InvoiceRecordEntity {
  const EmdadgarInvoiceRecordEntity({
    super.identity,
    super.customer,
    super.agency,
    super.vehicle,
    super.amounts,
    super.state,
    super.operation,
    super.audit,
    this.settlement,
    this.documentGuid,
    this.documentUrls,
    this.checkAmendmentDaraei,
    this.checkAmendmentHesabdari,
    this.checkEmdadgarInvoiceVisible,
    this.finalizeEmdadgarInvoiceVisible,
    this.previewEmdadgarInvoiceVisible,
    this.emdadgarInvoiceVisible,
    this.agencyCoefficient,
    this.privateCarType,
    this.agencyGrade,
    this.agencyWithoutTax,
    this.agencyType,
    this.trafficPlanCost,
    this.trafficPlanCostWithCoefficient,
    this.highwayTicketCost,
    this.highwayTicketCostWithCoefficient,
    this.finalizedDateTimeJalali,
  });

  final EmdadgarSettlementEntity? settlement;
  final String? documentGuid;
  final InvoiceDocumentUrlsEntity? documentUrls;
  final bool? checkAmendmentDaraei;
  final bool? checkAmendmentHesabdari;
  final bool? checkEmdadgarInvoiceVisible;
  final bool? finalizeEmdadgarInvoiceVisible;
  final bool? previewEmdadgarInvoiceVisible;
  final bool? emdadgarInvoiceVisible;
  final double? agencyCoefficient;
  final int? privateCarType;
  final String? agencyGrade;
  final int? agencyWithoutTax;
  final String? agencyType;
  final int? trafficPlanCost;
  final int? trafficPlanCostWithCoefficient;
  final int? highwayTicketCost;
  final int? highwayTicketCostWithCoefficient;
  final String? finalizedDateTimeJalali;

  EmdadgarInvoiceRecordModel  toModel() {
    return EmdadgarInvoiceRecordModel(
      identity: identity?.toModel(),
      customer: customer?.toModel(),
      agency: agency?.toModel(),
      vehicle: vehicle?.toModel(),
      amounts: amounts?.toModel(),
      state: state?.toModel(),
      operation: operation?.toModel(),
      audit: audit?.toModel(),
      settlement: settlement?.toModel(),
      documentGuid: documentGuid,
      documentUrls: documentUrls?.toModel(),
      checkAmendmentDaraei: checkAmendmentDaraei,
      checkAmendmentHesabdari: checkAmendmentHesabdari,
      checkEmdadgarInvoiceVisible: checkEmdadgarInvoiceVisible,
      finalizeEmdadgarInvoiceVisible: finalizeEmdadgarInvoiceVisible,
      previewEmdadgarInvoiceVisible: previewEmdadgarInvoiceVisible,
      emdadgarInvoiceVisible: emdadgarInvoiceVisible,
      agencyCoefficient: agencyCoefficient,
      privateCarType: privateCarType,
      agencyGrade: agencyGrade,
      agencyWithoutTax: agencyWithoutTax,
      agencyType: agencyType,
      trafficPlanCost: trafficPlanCost,
      trafficPlanCostWithCoefficient: trafficPlanCostWithCoefficient,
      highwayTicketCost: highwayTicketCost,
      highwayTicketCostWithCoefficient: highwayTicketCostWithCoefficient,
      finalizedDateTimeJalali: finalizedDateTimeJalali,
    );
  }
}
