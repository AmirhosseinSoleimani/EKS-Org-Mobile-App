import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_non_cooperation_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'non_cooperation_cubit.freezed.dart';
part 'non_cooperation_state.dart';

@injectable
class NonCooperationCubit extends Cubit<NonCooperationState> {
  final GetNonCooperationListUseCase _getNonCooperationListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;

  NonCooperationCubit(
    this._getNonCooperationListUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
  ) : super(const NonCooperationState.idle());
  
  BaseRequestEntity? selectedBaseRequest;
  final List<NonCooperationItemEntity> items = [];

  String? _errorMessage;

  String _fallbackError([String? msg]) =>
      msg?.trim().isNotEmpty == true
          ? msg!
          : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';

  int _page = 1;
  final int _pageSize = 3;

  bool _hasMore = true;

  Future<void> init() async {
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const NonCooperationState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const NonCooperationState.connectionError());
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
    emit(const NonCooperationState.loading());

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }
    final listResult = await _loadNonCooperationList();
    if (listResult != FetchResultType.success) {
      return listResult;
    }

    return FetchResultType.success;
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


  Future<FetchResultType> _loadNonCooperationList() async {
    _page = 1;
    _hasMore = true;
    items.clear();

    final result = await _getNonCooperationListUseCase(
      RequestOperationParamEntity(
        serviceType: selectedBaseRequest?.serviceType ?? ServiceType.reliefService,
        serviceRequestTrackCode: selectedBaseRequest?.trackCode ?? 0,
        page: _page,
        pageSize: _pageSize,
      ),
    );
    FetchResultType fetchResult = FetchResultType.failure;
    result.when(
      success: (data, _, __) {
        if (data != null) {
          items.addAll(data.records);

          if (data.records.length < _pageSize) {
            _hasMore = false;
          }
        }
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

  Future<void> loadMore() async {
    if (!_hasMore) return;

    emit(const NonCooperationState.loadingMore());

    _page++;

    final result = await _getNonCooperationListUseCase(
      RequestOperationParamEntity(
        serviceType: ServiceType.homeService,
        serviceRequestTrackCode: selectedBaseRequest?.trackCode ?? 0,
        page: _page,
        pageSize: _pageSize,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data != null) {
          if (data.records.isEmpty) {
            _hasMore = false;
          } else {
            items.addAll(data.records);

            if ( data.count <= items.length) {
              _hasMore = false;
            }
          }
        }

        _safeEmit(const NonCooperationState.loadedMore());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(NonCooperationState.loadMoreError(msg ?? error.toString()));
      },
      connectionError: () {
        _page--;
        _safeEmit(const NonCooperationState.loadMoreError(
            'اتصال اینترنت را بررسی کرده و دوباره تلاش کنید.'));
      },
    );
  }

  bool get hasMore => _hasMore;


  void _emitError([String? message]) {
    _safeEmit(
      NonCooperationState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  void _safeEmit(NonCooperationState state) {
    if (!isClosed) emit(state);
  }
}
