import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_document_urls_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'emdadgar_settlement_entity.dart';

class EmdadgarInvoiceRecordEntity extends InvoiceRecordEntity {
  const EmdadgarInvoiceRecordEntity({
    required super.identity,
    required super.customer,
    required super.agency,
    required super.vehicle,
    required super.amounts,
    required super.state,
    required super.operation,
    required super.audit,
    required this.settlement,
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
  });

  final EmdadgarSettlementEntity settlement;
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
}
