import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_evaluation_history_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'evaluation_history_cubit.freezed.dart';
part 'evaluation_history_state.dart';

@injectable
class EvaluationHistoryCubit extends Cubit<EvaluationHistoryState> {

  final GetEvaluationHistoryListUseCase _getEvaluationHistoryListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;

  EvaluationHistoryCubit(
    this._getEvaluationHistoryListUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
  ) : super(const EvaluationHistoryState.idle());

  BaseRequestEntity? selectedBaseRequest;
  final List<EvaluationHistoryItemEntity> items = [];

  EmdadgarInfoEntity? emdadgarInfo;
  String? _errorMessage;
  String _fallbackError([String? msg]) =>
      msg?.trim().isNotEmpty == true
          ? msg!
          : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';

  Future<void> init() async {
    _safeEmit(const EvaluationHistoryState.loading());

    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const EvaluationHistoryState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const EvaluationHistoryState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedServiceRequest();
    if (selectedResult != FetchResultType.success) {
      return selectedResult;
    }
    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    if (_shouldFetchEmdadgarInfo) {
      final emdadgarResult = await _fetchEmdadgarInfo();
      if (emdadgarResult != FetchResultType.success) {
        return emdadgarResult;
      }
    }

    final listResult = await _loadEvaluationHistoryList();
    if (listResult != FetchResultType.success) {
      return listResult;
    }

    return FetchResultType.success;
  }

  bool get _shouldFetchEmdadgarInfo {
    return (selectedBaseRequest?.requestStatus ?? 0) > 1;
  }

  Future<FetchResultType> _loadEvaluationHistoryList() async {
    items.clear();
    final result = await _getEvaluationHistoryListUseCase(
      ServiceRequestParamEntity(
        serviceType: selectedBaseRequest?.serviceType?.value ?? ServiceType.reliefService.value,
        serviceRequestId: selectedBaseRequest?.id,
      ),
    );
    FetchResultType fetchResult = FetchResultType.failure;
    result.when(
      success: (data, _, __) {
        items.addAll(data);
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () => fetchResult = FetchResultType.connectionError,
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }

  Future<FetchResultType> _fetchSelectedServiceRequest() async{
    try{
      selectedBaseRequest = await _fetchSelectedRequestItemUseCase.call();
      return FetchResultType.success;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
  }

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id   = selectedBaseRequest?.id ?? 0;

    final result =
    (selectedBaseRequest?.serviceType == ServiceType.homeService)
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
        selectedBaseRequest = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage  = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }

  Future<FetchResultType> _fetchEmdadgarInfo() async {

    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedBaseRequest?.id ?? 0,
      serviceType: selectedBaseRequest?.serviceType?.value ?? 1,
    );
    final result = await _getEmdadgarInfoUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
        emdadgarInfo = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }

  void _emitError([String? message]) {
    _safeEmit(
      EvaluationHistoryState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  void _safeEmit(EvaluationHistoryState state) {
    if (!isClosed) emit(state);
  }
}
