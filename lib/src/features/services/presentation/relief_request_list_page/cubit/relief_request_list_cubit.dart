import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_operation_access_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart'
    show ApiResultPatterns;
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/abstract/base_request_entity.dart';

part 'relief_request_list_cubit.freezed.dart';
part 'relief_request_list_state.dart';

@injectable
class ReliefRequestListCubit extends Cubit<ReliefRequestListState> {
  ReliefRequestListCubit(
    this._getReliefRequestListUseCase,
    this._getRequestOperationAccessUseCase,
    this._setSelectedRequestItemUseCase,
  ) : super(const ReliefRequestListState.idle());

  final GetReliefRequestListUseCase _getReliefRequestListUseCase;
  final GetRequestOperationAccessUseCase _getRequestOperationAccessUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;

  RequestOperationAccessEntity? _operationAccess;

  RequestOperationAccessEntity? get operationAccess => _operationAccess;

  bool get canViewRequests => _operationAccess?.canView == true;

  final List<BaseRequestEntity> _items = [];

  List<BaseRequestEntity> get items => List.unmodifiable(_items);

  int _page = 1;
  final int _pageSize = 50;
  int _totalCount = 0;
  bool _isLoadingMore = false;

  bool get hasMore => _items.length < _totalCount;

  final ValueNotifier<RequestStatus> _selectedStatusNotifier =
      ValueNotifier(RequestStatus.openRequests);

  ValueNotifier<RequestStatus> get selectedStatusNotifier =>
      _selectedStatusNotifier;

  RequestStatus get selectedStatus => _selectedStatusNotifier.value;

  final requestNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final chassisNumberController = TextEditingController();
  final rescuerNameController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();

  int get requestCount => _totalCount;

  void setSelectedStatus(RequestStatus status) {
    _selectedStatusNotifier.value = status;
  }

  Future<void> fetchRequestList() async {
    _page = 1;
    _items.clear();

    _safeEmit(const ReliefRequestListState.loading());

    final hasOperationAccess = await _ensureOperationAccess();
    if (!hasOperationAccess) return;

    if (!canViewRequests) {
      _safeEmit(const ReliefRequestListState.loaded());
      return;
    }

    final param = _buildFilterParam();
    final result = await _getReliefRequestListUseCase(param);

    result.whenOrNull(
      success: (data, _, _) {
        _totalCount = data.totalCount;
        _items.addAll(data.items);
        _safeEmit(const ReliefRequestListState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          ReliefRequestListState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      connectionError: () {
        _safeEmit(const ReliefRequestListState.connectionError());
      },
    );
  }

  Future<bool> _ensureOperationAccess() async {
    if (_operationAccess != null) return true;

    final result = await _getRequestOperationAccessUseCase(
      ServiceType.reliefService,
    );
    var loaded = false;

    result.when(
      success: (data, _, _) {
        _operationAccess = data;
        loaded = true;
      },
      failure: (error, message) {
        _safeEmit(
          ReliefRequestListState.error(
            message: BottomSheetMessageModel(
              message: message ?? error?.toString() ?? 'خطای غیرمنتظره',
              title: '',
            ),
          ),
        );
      },
      expireToken: () {},
      connectionError: () {
        _safeEmit(const ReliefRequestListState.connectionError());
      },
    );

    return loaded;
  }

  Future<void> loadMore() async {
    if (!hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    _page++;

    emit(const ReliefRequestListState.loadingMore());

    final param = _buildFilterParam();
    final result = await _getReliefRequestListUseCase(param);
    result.whenOrNull(
      success: (data, _, _) {
        _totalCount = data.totalCount;
        _items.addAll(data.items);

        _safeEmit(const ReliefRequestListState.loaded());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(
          ReliefRequestListState.loadingMoreError(
            message: msg ?? error.toString(),
          ),
        );
      },
      connectionError: () {
        _page--;
        _safeEmit(
          const ReliefRequestListState.loadingMoreError(
            message: 'اتصال اینترنت خود را بررسی کنید',
          ),
        );
      },
    );
    _isLoadingMore = false;
  }

  void _safeEmit(ReliefRequestListState state) {
    if (!isClosed) emit(state);
  }

  RequestFilterParamEntity _buildFilterParam() {
    return RequestFilterParamEntity(
      page: _page,
      pageSize: _pageSize,
      chassisNumber: chassisNumberController.text,
      serviceRequestId: requestNumberController.text,
      callMobileNumber: phoneController.text,
      cityName: cityController.text,
      provinceName: provinceController.text,
      requestStatus: selectedStatus.value,
      rescuerName: rescuerNameController.text,
    );
  }

  Future<void> clearFilters() async {
    requestNumberController.clear();
    phoneController.clear();
    chassisNumberController.clear();
    rescuerNameController.clear();
    cityController.clear();
    provinceController.clear();

    await fetchRequestList();
  }

  Future<void> cacheSelectedRequest(BaseRequestEntity request) async {
    try {
      await _setSelectedRequestItemUseCase(request);
    } catch (e) {
      debugPrint('cacheSelectedRequest ERROR -> $e');
    }
  }

  @override
  Future<void> close() {
    requestNumberController.dispose();
    phoneController.dispose();
    chassisNumberController.dispose();
    rescuerNameController.dispose();
    cityController.dispose();
    provinceController.dispose();
    _selectedStatusNotifier.dispose();
    return super.close();
  }
}
