import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_operation_access_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/request/latest_request_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/abstract/base_request_entity.dart';

part 'home_service_request_list_cubit.freezed.dart';
part 'home_service_request_list_state.dart';

@injectable
class HomeServiceRequestListCubit extends Cubit<HomeServiceRequestListState> with LatestRequestGuard {
  HomeServiceRequestListCubit(
    this._getHomeServiceRequestListUseCase,
    this._getRequestOperationAccessUseCase,
    this._setSelectedRequestItemUseCase,
    this._currentSessionManager,
  ) : super(const HomeServiceRequestListState.idle());

  final GetHomeServiceRequestListUseCase _getHomeServiceRequestListUseCase;
  final GetRequestOperationAccessUseCase _getRequestOperationAccessUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;
  final CurrentSessionManager _currentSessionManager;

  RequestOperationAccessEntity? _operationAccess;

  RequestOperationAccessEntity? get operationAccess => _operationAccess;

  final List<BaseRequestEntity> requestList = <BaseRequestEntity>[];

  static const CurrentSessionEnumItemEntity _allStatus =
      CurrentSessionEnumItemEntity(
        name: 'All',
        title: 'همه',
        value: -1,
      );

  static const CurrentSessionEnumItemEntity _openRequestsStatus =
      CurrentSessionEnumItemEntity(
        name: 'OpenRequests',
        title: 'درخواست های باز',
        value: -100,
      );

  final ValueNotifier<int> _selectedStatusNotifier = ValueNotifier(-100);

  ValueNotifier<int> get selectedStatusNotifier => _selectedStatusNotifier;

  int get selectedStatus => _selectedStatusNotifier.value;

  List<CurrentSessionEnumItemEntity> get requestStatusItems {
    final items = _currentSessionManager
            .currentSession?.enums?.serviceRequestStatus ??
        const <CurrentSessionEnumItemEntity>[];
    final seenValues = <int>{-1, -100};

    return [
      _allStatus,
      _openRequestsStatus,
      ...items.where((item) {
        final value = item.value;
        return value != null && seenValues.add(value);
      }),
    ];
  }

  String requestStatusTitle(int value) {
    for (final item in requestStatusItems) {
      if (item.value == value) {
        return item.title?.trim().isNotEmpty == true
            ? item.title!.trim()
            : '-';
      }
    }
    return _openRequestsStatus.title!;
  }

  final selectedTimePeriodNotifier = ValueNotifier<TimePeriod>(TimePeriod.all);

  TimePeriod get selectedTimePeriod => selectedTimePeriodNotifier.value;

  final requestNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final chassisNumberController = TextEditingController();
  final rescuerNameController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();

  int _page = 1;
  final int _pageSize = 100;
  int _totalCount = 0;
  bool _isLoadingMore = false;

  int get requestCount => _totalCount;

  bool get hasMore => requestList.length < _totalCount;

  void setSelectedStatus(int status) {
    _selectedStatusNotifier.value = status;
  }

  void setSelectedTimePeriod(TimePeriod timePeriod) {
    selectedTimePeriodNotifier.value = timePeriod;
  }

  Future<void> fetchRequestList() async {
    final requestVersion = beginLatestRequest('list');
    _page = 1;
    requestList.clear();

    _safeEmit(const HomeServiceRequestListState.loading());

    final hasOperationAccess = await _ensureOperationAccess();
    if (!isLatestRequest(requestVersion, 'list') || isClosed) return;
    if (!hasOperationAccess) return;

    final params = _buildFilterParam();
    final result = await _getHomeServiceRequestListUseCase(params);
    if (!isLatestRequest(requestVersion, 'list') || isClosed) return;

    result.when(
      success: (data, _, _) {
        _totalCount = data.totalCount;
        requestList.addAll(data.items);

        _safeEmit(const HomeServiceRequestListState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          HomeServiceRequestListState.error(
            message: BottomSheetMessageModel(
              message: msg ?? error.toString(),
              title: '',
            ),
          ),
        );
      },
      expireToken: () {
        _safeEmit(
          HomeServiceRequestListState.error(
            message: const BottomSheetMessageModel(
              message: 'نشست کاربری منقضی شده است. لطفا دوباره وارد شوید',
              title: 'خطا',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const HomeServiceRequestListState.connectionError()),
    );
  }

  Future<bool> _ensureOperationAccess() async {
    if (_operationAccess != null) return true;

    final result = await _getRequestOperationAccessUseCase(
      ServiceType.homeService,
    );
    var loaded = false;

    result.when(
      success: (data, _, _) {
        _operationAccess = data;
        loaded = true;
      },
      failure: (error, message) {
        _safeEmit(
          HomeServiceRequestListState.error(
            message: BottomSheetMessageModel(
              message: message ?? error?.toString() ?? 'خطای غیرمنتظره',
              title: '',
            ),
          ),
        );
      },
      expireToken: () {
        _safeEmit(
          HomeServiceRequestListState.error(
            message: const BottomSheetMessageModel(
              message: 'نشست کاربری منقضی شده است. لطفا دوباره وارد شوید',
              title: 'خطا',
            ),
          ),
        );
      },
      connectionError: () {
        _safeEmit(const HomeServiceRequestListState.connectionError());
      },
    );

    return loaded;
  }

  Future<void> loadMore() async {
    if (!hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    _page++;

    emit(const HomeServiceRequestListState.loadingMore());

    final param = _buildFilterParam();
    final result = await _getHomeServiceRequestListUseCase(param);
    result.when(
      success: (data, _, _) {
        _totalCount = data.totalCount;
        requestList.addAll(data.items);

        _safeEmit(const HomeServiceRequestListState.loaded());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(
          HomeServiceRequestListState.loadingMoreError(
            message: msg ?? error.toString(),
          ),
        );
      },
      expireToken: () {
        _page--;
        _safeEmit(
          const HomeServiceRequestListState.loadingMoreError(
            message: 'نشست کاربری منقضی شده است. لطفا دوباره وارد شوید',
          ),
        );
      },
      connectionError: () {
        _page--;
        _safeEmit(
          const HomeServiceRequestListState.loadingMoreError(
            message: 'اتصال اینترنت خود را بررسی کنید',
          ),
        );
      },
    );
    _isLoadingMore = false;
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
      requestStatus: selectedStatus,
      rescuerName: rescuerNameController.text,
      timePeriod: selectedTimePeriod,
    );
  }

  Future<void> clearFilters() async {
    requestNumberController.clear();
    phoneController.clear();
    chassisNumberController.clear();
    rescuerNameController.clear();
    cityController.clear();
    provinceController.clear();
    _selectedStatusNotifier.value = -1;
    selectedTimePeriodNotifier.value = TimePeriod.all;

    await fetchRequestList();
  }

  void _safeEmit(HomeServiceRequestListState state) {
    if (!isClosed) emit(state);
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
    selectedTimePeriodNotifier.dispose();

    return super.close();
  }
}
