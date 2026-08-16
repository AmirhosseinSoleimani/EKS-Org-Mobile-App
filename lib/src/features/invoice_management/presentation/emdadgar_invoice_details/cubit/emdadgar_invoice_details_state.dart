import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';

enum EmdadgarInvoiceDetailsStatus {
  idle,
  loading,
  loaded,
  error,
  connectionError,
}

class EmdadgarInvoiceDetailsState {
  const EmdadgarInvoiceDetailsState({
    this.status = EmdadgarInvoiceDetailsStatus.idle,
    this.invoice,
    this.message,
  });

  final EmdadgarInvoiceDetailsStatus status;
  final InvoiceEntity? invoice;
  final BottomSheetMessageModel? message;
}
