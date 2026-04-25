import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_non_cooperation_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
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
  
  BaseRequestEntity? selectedRequest;
  final List<NonCooperationItemEntity> items = [];

  int _page = 1;
  final int _pageSize = 3;

  bool _hasMore = true;

  Future<void> init() async {
    emit(const NonCooperationState.loading());

    selectedRequest =
        await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      _safeEmit(
        const NonCooperationState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    await _refreshRequestData();

    await _loadNonCooperationList();
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

  Future<void> _loadNonCooperationList() async {
    _page = 1;
    _hasMore = true;
    items.clear();

    final result = await _getNonCooperationListUseCase(
      RequestOperationParamEntity(
        serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
        serviceRequestTrackCode: selectedRequest?.trackCode ?? 0,
        page: _page,
        pageSize: _pageSize,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data != null) {
          items.addAll(data.records);

          if (data.records.length < _pageSize) {
            _hasMore = false;
          }
        }

        _safeEmit(const NonCooperationState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          NonCooperationState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const NonCooperationState.connectionError()),
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    emit(const NonCooperationState.loadingMore());

    _page++;

    final result = await _getNonCooperationListUseCase(
      RequestOperationParamEntity(
        serviceType: ServiceType.homeService,
        serviceRequestTrackCode: selectedRequest?.trackCode ?? 0,
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

            if (data.records.length < _pageSize) {
              _hasMore = false;
            }
          }
        }

        _safeEmit(const NonCooperationState.loaded());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(const NonCooperationState.loaded());
      },
      connectionError: () {
        _page--;
        _safeEmit(const NonCooperationState.loaded());
      },
    );
  }

  bool get hasMore => _hasMore;

  void _safeEmit(NonCooperationState state) {
    if (!isClosed) emit(state);
  }
}
