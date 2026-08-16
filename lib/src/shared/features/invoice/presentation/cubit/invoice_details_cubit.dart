import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/get_pre_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/invoice_request_context_loader.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InvoiceDetailsStatus {
  idle,
  loading,
  loaded,
  error,
  connectionError,
}

class InvoiceDetailsState {
  const InvoiceDetailsState({
    this.status = InvoiceDetailsStatus.idle,
    this.message,
  });

  final InvoiceDetailsStatus status;
  final BottomSheetMessageModel? message;
}

class InvoiceDetailsCubit extends Cubit<InvoiceDetailsState> {
  InvoiceDetailsCubit(
    this._getPreInvoiceUseCase,
    this._requestContextLoader,
  ) : super(const InvoiceDetailsState());

  final GetPreInvoiceUseCase _getPreInvoiceUseCase;
  final InvoiceRequestContextLoader _requestContextLoader;

  InvoiceRequestContext? selectedRequest;
  InvoiceEntity? invoiceEntity;

  Future<void> init() async {
    selectedRequest = await _requestContextLoader.loadCached();

    if (selectedRequest == null) {
      _safeEmit(
        const InvoiceDetailsState(
          status: InvoiceDetailsStatus.error,
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    _safeEmit(const InvoiceDetailsState(status: InvoiceDetailsStatus.loading));

    final refreshedRequest = await _requestContextLoader.refresh(
      selectedRequest!,
    );
    if (refreshedRequest != null) {
      selectedRequest = refreshedRequest;
    }

    await _loadInvoice();
  }

  Future<void> _loadInvoice() async {
    final request = selectedRequest!;
    final result = await _getPreInvoiceUseCase(
      ServiceInvoiceParamEntity(
        serviceRequestId: request.requestId,
        serviceType: request.serviceType?.value ?? 1,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        invoiceEntity = data;
        _safeEmit(const InvoiceDetailsState(status: InvoiceDetailsStatus.loaded));
      },
      failure: (error, message) {
        _safeEmit(
          InvoiceDetailsState(
            status: InvoiceDetailsStatus.error,
            message: BottomSheetMessageModel(
              title: '',
              message: message ?? error.toString(),
            ),
          ),
        );
      },
      connectionError: () => _safeEmit(
        const InvoiceDetailsState(status: InvoiceDetailsStatus.connectionError),
      ),
    );
  }

  void _safeEmit(InvoiceDetailsState state) {
    if (!isClosed) emit(state);
  }
}
