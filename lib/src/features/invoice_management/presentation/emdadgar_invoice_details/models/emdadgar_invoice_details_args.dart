import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/enums/emdadgar_invoice_stage.dart';

class EmdadgarInvoiceDetailsArgs {
  const EmdadgarInvoiceDetailsArgs({
    required this.stage,
    required this.item,
  });

  final EmdadgarInvoiceStage stage;
  final EmdadgarInvoiceRecordEntity item;

  int? get serviceRequestId => item.identity?.serviceRequestId;

  int? get evaluationId => item.identity?.evaluationId;

  ServiceType? get serviceType {
    final value = item.state?.serviceType;
    if (value == null) return null;

    for (final type in ServiceType.values) {
      if (type.value == value) return type;
    }
    return null;
  }

  String get pageTitle => 'صورت وضعیت امدادگر - ${stage.title}';
}
