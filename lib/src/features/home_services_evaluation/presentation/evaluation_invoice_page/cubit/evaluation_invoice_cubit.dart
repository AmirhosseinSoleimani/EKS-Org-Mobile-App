import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/accept_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/customer_pre_invoice_on_the_fly_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'evaluation_invoice_cubit.freezed.dart';

part 'evaluation_invoice_state.dart';

@injectable
class EvaluationInvoiceCubit extends Cubit<EvaluationInvoiceState> {
  final CustomerPreInvoiceOnTheFlyUseCase _customerPreInvoiceOnTheFlyUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final AcceptEvaluationUseCase _acceptEvaluationUseCase;

  EvaluationInvoiceCubit(
    this._customerPreInvoiceOnTheFlyUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._acceptEvaluationUseCase,
  ) : super(const EvaluationInvoiceState.idle());

  BaseRequestEntity? selectedRequest;
  InvoiceEntity? invoiceEntity;
  String? emdadgarEvaluationId;

  VoidCallback? _retryAction;
  void retryLastAction() => _retryAction?.call();


  Future<void> init(String emdadgarEvaluationId) async {
    _retryAction = () => init(emdadgarEvaluationId);

    this.emdadgarEvaluationId = emdadgarEvaluationId;
    selectedRequest = await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      _safeEmit(
        const EvaluationInvoiceState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    _safeEmit(const EvaluationInvoiceState.loading());

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
    final param = AcceptEvaluationParamEntity(
      emdadgarEvaluationId: emdadgarEvaluationId,
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType ?? ServiceType.reliefService,
    );
    final result = await _customerPreInvoiceOnTheFlyUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        invoiceEntity = data;
        _safeEmit(const EvaluationInvoiceState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          EvaluationInvoiceState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      connectionError: () => _safeEmit(const EvaluationInvoiceState.connectionError()),
    );
  }

  void _safeEmit(EvaluationInvoiceState state) {
    if (!isClosed) emit(state);
  }

  Future<void> acceptEvaluation () async {
    _retryAction = acceptEvaluation;

    _safeEmit(EvaluationInvoiceState.submitLoading());
    final param = AcceptEvaluationParamEntity(serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
        emdadgarEvaluationId: emdadgarEvaluationId.toString());

    final result = await _acceptEvaluationUseCase(param);
    result.whenOrNull(
      success: (data, failures, resultCode) {
        _safeEmit(EvaluationInvoiceState.submitSuccess());
      },
      failure: (error, failures) => _safeEmit(
        EvaluationInvoiceState.error(
          message: BottomSheetMessageModel(
            message: failures ?? error.toString(),
            title: '',
          ),
        ),
      ),
      connectionError: () => emit(const EvaluationInvoiceState.connectionError()),
    );
  }
}
