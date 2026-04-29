import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/get_emdadgar_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'emdadgar_invoice_cubit.freezed.dart';

part 'emdadgar_invoice_state.dart';

@injectable
class EmdadgarInvoiceCubit extends Cubit<EmdadgarInvoiceState> {
  final GetEmdadgarInvoiceUseCase _getEmdadgarInvoiceUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;

  EmdadgarInvoiceCubit(
    this._getEmdadgarInvoiceUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
  ) : super(const EmdadgarInvoiceState.idle());

  BaseRequestEntity? selectedRequest;
  InvoiceEntity? invoiceEntity;

  Future<void> init() async {
    selectedRequest = await _fetchSelectedRequestItemUseCase();
    if (selectedRequest == null) {
      _safeEmit(
        const EmdadgarInvoiceState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }
    _safeEmit(const EmdadgarInvoiceState.loading());

    await _refreshRequestData();
    await _loadEmdadgarInvoiceInfo();
  }

  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result = selectedRequest!.isHomeService
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    result.whenOrNull(
      success: (data, _, __) {
        selectedRequest = data;
      },
    );
  }

  Future<void> _loadEmdadgarInvoiceInfo() async {
    final param = ServiceInvoiceParamEntity(
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType?.value ?? 1,
    );
    final result = await _getEmdadgarInvoiceUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        invoiceEntity = data;
        _safeEmit(const EmdadgarInvoiceState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          EmdadgarInvoiceState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const EmdadgarInvoiceState.connectionError()),
    );
  }

  void _safeEmit(EmdadgarInvoiceState state) {
    if (!isClosed) emit(state);
  }

  get isSubscription => selectedRequest?.isSubscription ?? false;

  get isGuaranty => selectedRequest?.isGuaranty ?? false;
}
