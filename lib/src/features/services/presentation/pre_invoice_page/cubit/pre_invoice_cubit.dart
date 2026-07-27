import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/get_pre_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'pre_invoice_cubit.freezed.dart';

part 'pre_invoice_state.dart';

@injectable
class PreInvoiceCubit extends Cubit<PreInvoiceState> {
  final GetPreInvoiceUseCase _getPreInvoiceUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;

  PreInvoiceCubit(
    this._getPreInvoiceUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
  ) : super(const PreInvoiceState.idle());

  BaseRequestEntity? selectedRequest;
  InvoiceEntity? invoiceEntity;

  Future<void> init() async {

    selectedRequest = await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      _safeEmit(
        const PreInvoiceState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    _safeEmit(const PreInvoiceState.loading());

    await _refreshRequestData();
    await _loadPreInvoiceInfo();

  }

  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result = selectedRequest!.isHomeService
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    result.whenOrNull(
      success: (data, _, _) {
        selectedRequest = data;
      },
    );
  }

  Future<void> _loadPreInvoiceInfo() async {
    final param = ServiceInvoiceParamEntity(
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType?.value ?? 1,
    );
    final result = await _getPreInvoiceUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        invoiceEntity = data;
        _safeEmit(const PreInvoiceState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          PreInvoiceState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      connectionError: () => _safeEmit(const PreInvoiceState.connectionError()),
    );
  }

  void _safeEmit(PreInvoiceState state) {
    if (!isClosed) emit(state);
  }

  bool get isSubscription => selectedRequest?.isSubscription ?? false;

  bool get isGuaranty => selectedRequest?.isGuaranty ?? false;
}
