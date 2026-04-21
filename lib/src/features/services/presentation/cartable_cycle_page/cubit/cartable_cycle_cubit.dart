import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_cartable_cycle_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cartable_cycle_cubit.freezed.dart';

part 'cartable_cycle_state.dart';

@injectable
class CartableCycleCubit extends Cubit<CartableCycleState> {
  final GetCartableCycleListUseCase _getCartableCycleListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;

  CartableCycleCubit(
    this._getCartableCycleListUseCase,
    this._fetchSelectedRequestItemUseCase,
  ) : super(const CartableCycleState.idle());

  BaseRequestEntity? selectedRequest;
  final List<CartableCycleItemEntity> items = [];

  int? requestId;
  int _page = 1;
  final int _pageSize = 3;

  bool _hasMore = true;

  Future<void> init() async {
    emit(const CartableCycleState.loading());

    final BaseRequestEntity? cachedRequest =
        await _fetchSelectedRequestItemUseCase();

    if (cachedRequest == null) {
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

    selectedRequest = cachedRequest;
    requestId = cachedRequest.id;

    await _loadCartableCycleList();
  }

  Future<void> _loadCartableCycleList() async {
    _page = 1;
    _hasMore = true;
    items.clear();

    final result = await _getCartableCycleListUseCase(
      RequestOperationParamEntity(
        serviceType: ServiceType.homeService,
        requestId: 87813,
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
              message: msg ?? 'خطای غیر منتظره',
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
        requestId: 87813,
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
