import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_cartable_cycle_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cartable_cycle_cubit.freezed.dart';

part 'cartable_cycle_state.dart';

@injectable
class CartableCycleCubit extends Cubit<CartableCycleState> {
  final GetCartableCycleListUseCase _getCartableCycleListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;

  CartableCycleCubit(
    this._getCartableCycleListUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
  ) : super(const CartableCycleState.idle());

  EmdadgarInfoEntity? emdadgarInfo;
  BaseRequestEntity? selectedRequest;
  final List<CartableCycleItemEntity> items = [];

  int _page = 1;
  final int _pageSize = 3;

  bool _hasMore = true;

  Future<void> init() async {
    emit(const CartableCycleState.loading());

   selectedRequest = await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      _safeEmit(
        const CartableCycleState.error(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'در دریافت اطلاعات درخواست مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    await _refreshRequestData();

    if ((selectedRequest?.requestStatus ?? 0) > 1) {
      await _fetchEmdadgarInfo();
    }


    await _loadCartableCycleList();
  }

  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result =
    selectedRequest!.isHomeService
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    result.whenOrNull(
      success: (data, _, __) {
        selectedRequest = data;
      },
    );
  }

  Future<void> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType?.value ?? 1,
    );

    final result = await _getEmdadgarInfoUseCase(param);

    result.whenOrNull(
      success: (data, _, __) {
        emdadgarInfo = data;
      },
    );
  }


  Future<void> _loadCartableCycleList() async {
    _page = 1;
    _hasMore = true;
    items.clear();

    final result = await _getCartableCycleListUseCase(
      RequestOperationParamEntity(
        serviceType: ServiceType.homeService,
        requestId: selectedRequest?.id ?? 0,
        page: _page,
        pageSize: _pageSize,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items.addAll(data);
        _safeEmit(const CartableCycleState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          CartableCycleState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const CartableCycleState.connectionError()),
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    emit(const CartableCycleState.loadingMore());

    _page++;

    final result = await _getCartableCycleListUseCase(
      RequestOperationParamEntity(
        serviceType: ServiceType.homeService,
        requestId: selectedRequest?.id ?? 0,
        page: _page,
        pageSize: _pageSize,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data.isEmpty) {
          _hasMore = false;
        } else {
          items.addAll(data);

          if (data.length < _pageSize) {
            _hasMore = false;
          }
        }

        _safeEmit(const CartableCycleState.loaded());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(const CartableCycleState.loaded());
      },
      connectionError: () {
        _page--;
        _safeEmit(const CartableCycleState.loaded());
      },
    );
  }

  bool get hasMore => _hasMore;

  void _safeEmit(CartableCycleState state) {
    if (!isClosed) emit(state);
  }
}
