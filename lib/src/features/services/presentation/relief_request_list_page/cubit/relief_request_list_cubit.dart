import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/abstract/base_request_entity.dart';

part 'relief_request_list_state.dart';

part 'request_list_cubit.freezed.dart';

@injectable
class ReliefRequestListCubit extends Cubit<ReliefRequestListState> {
  ReliefRequestListCubit(this._getReliefRequestListUseCase)
      : super(const ReliefRequestListState.idle());

  final GetReliefRequestListUseCase _getReliefRequestListUseCase;

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

  get requestCount => 200;

  void setSelectedStatus(RequestStatus status) {
    _selectedStatusNotifier.value = status;
  }

  void setSelectedTimePeriod(TimePeriod timePeriod) {
    selectedTimePeriodNotifier.value = timePeriod;
  }

  void fetchRequestList() async {
    _safeEmit(const ReliefRequestListState.loading());

    final result = await _getReliefRequestListUseCase();

    result.whenOrNull(
      success: (data, failures, resultCode) async {
        requestList.clear();
        requestList.addAll(data);
        _safeEmit(const ReliefRequestListState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          ReliefRequestListState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const ReliefRequestListState.connectionError()),
    );
  }

  void _safeEmit(ReliefRequestListState state) {
    if (!isClosed) emit(state);
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
