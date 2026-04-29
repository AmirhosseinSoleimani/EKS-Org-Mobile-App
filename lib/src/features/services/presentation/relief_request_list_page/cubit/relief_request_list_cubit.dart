
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart' show ApiResultPatterns;
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
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
    this._setSelectedRequestItemUseCase,
  ) : super(const ReliefRequestListState.idle());

  final GetReliefRequestListUseCase _getReliefRequestListUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;

  final List<BaseRequestEntity> _items = [];

  List<BaseRequestEntity> get items => List.unmodifiable(_items);

  int _page = 1;
  final int _pageSize = 20;
  int _totalCount = 0;
  bool _isLoadingMore = false;

  bool get hasMore => _items.length < _totalCount;

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

  get requestCount => _totalCount;

  void setSelectedStatus(RequestStatus status) {
    _selectedStatusNotifier.value = status;
  }

  void setSelectedTimePeriod(TimePeriod timePeriod) {
    selectedTimePeriodNotifier.value = timePeriod;
  }

  Future<void> fetchRequestList() async {
    _page = 1;
    _items.clear();

    _safeEmit(const ReliefRequestListState.loading());

    final param = _buildFilterParam();
    final result = await _getReliefRequestListUseCase(param);

    result.whenOrNull(
      success: (data, _, __) {
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

  Future<void> loadMore() async {
    if (!hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    _page++;

    emit(const ReliefRequestListState.loadingMore());

    final param = _buildFilterParam();
    final result = await _getReliefRequestListUseCase(param);
    result.whenOrNull(
      success: (data, _, __) {
        _totalCount = data.totalCount;
        _items.addAll(data.items);

        _safeEmit(const ReliefRequestListState.loaded());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(ReliefRequestListState.loadingMoreError(
          message: msg ?? error.toString(),
        ));
      },
      connectionError: () {
        _page--;
        _safeEmit(const ReliefRequestListState.loadingMoreError(
          message: 'اتصال اینترنت خود را بررسی کنید',
        ));
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
      requestStatus: selectedStatus ?? RequestStatus.openRequests,
      rescuerName: rescuerNameController.text,
      timePeriod: selectedTimePeriod,
    );
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
    selectedTimePeriodNotifier.dispose();
    return super.close();
  }
}
