import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../domain/entities/abstract/base_request_entity.dart';

part 'home_service_request_list_cubit.freezed.dart';

part 'home_service_request_list_state.dart';

@injectable
class HomeServiceRequestListCubit extends Cubit<HomeServiceRequestListState> {
  HomeServiceRequestListCubit(this._getHomeServiceRequestListUseCase,
      this._setSelectedRequestItemUseCase)
      : super(const HomeServiceRequestListState.idle());

  final GetHomeServiceRequestListUseCase _getHomeServiceRequestListUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;

  final List<BaseRequestEntity> requestList = <BaseRequestEntity>[];

  final ValueNotifier<RequestStatus?> _selectedStatusNotifier =
      ValueNotifier(null);

  ValueNotifier<RequestStatus?> get selectedStatusNotifier =>
      _selectedStatusNotifier;

  RequestStatus? get selectedStatus => _selectedStatusNotifier.value;

  final selectedTimePeriodNotifier = ValueNotifier<TimePeriod>(TimePeriod.all);


  TimePeriod get selectedTimePeriod => selectedTimePeriodNotifier.value;

  final requestNumberController = TextEditingController();
  final phoneController = TextEditingController();
  final chassisNumberController = TextEditingController();
  final rescuerNameController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();


  int _page = 1;
  final int _pageSize = 20;
  int _totalCount = 0;
  bool _isLoadingMore = false;

  get requestCount => _totalCount;

  bool get hasMore => requestList.length < _totalCount;

  void setSelectedStatus(RequestStatus status) {
    _selectedStatusNotifier.value = status;
  }

  void setSelectedTimePeriod(TimePeriod timePeriod) {
    selectedTimePeriodNotifier.value = timePeriod;
  }

  void fetchRequestList() async {
    _page = 1;
    requestList.clear();

    _safeEmit(const HomeServiceRequestListState.loading());
    final params = _buildFilterParam();
    final result = await _getHomeServiceRequestListUseCase(params);

    result.whenOrNull(
      success: (data, failures, resultCode) async {
        _totalCount = data.totalCount;
        requestList.addAll(data.items);

        _safeEmit(const HomeServiceRequestListState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          HomeServiceRequestListState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const HomeServiceRequestListState.connectionError()),
    );
  }

  Future<void> loadMore() async {
    if (!hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    _page++;

    emit(const HomeServiceRequestListState.loadingMore());

    final param = _buildFilterParam();
    final result = await _getHomeServiceRequestListUseCase(param);
    result.whenOrNull(
      success: (data, _, __) {
        _totalCount = data.totalCount;
        requestList.addAll(data.items);

        _safeEmit(const HomeServiceRequestListState.loaded());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(HomeServiceRequestListState.loadingMoreError(
          message: msg ?? error.toString(),
        ));
      },
      connectionError: () {
        _page--;
        _safeEmit(const HomeServiceRequestListState.loadingMoreError(
          message: 'اتصال اینترنت خود را بررسی کنید',
        ));
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
      requestStatus: selectedStatus ?? RequestStatus.openRequests,
      rescuerName: rescuerNameController.text,
      timePeriod: selectedTimePeriod,
    );
  }

  void _safeEmit(HomeServiceRequestListState state) {
    if (!isClosed) emit(state);
  }

  Future<void> cacheSelectedRequest(BaseRequestEntity request) async {
    try {
      await _setSelectedRequestItemUseCase(request);
    } catch (e) {
      debugPrint("cacheSelectedRequest ERROR → $e");
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
