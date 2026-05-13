
import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/day_schedule_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/change_time_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_times_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/change_home_service_request_time_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_times_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'change_home_service_request_time_cubit.freezed.dart';
part 'change_home_service_request_time_state.dart';

@injectable
class ChangeHomeServiceRequestTimeCubit extends Cubit<ChangeHomeServiceRequestTimeState> {
  ChangeHomeServiceRequestTimeCubit(this._fetchSelectedRequestItemUseCase,
      this._getHomeServiceRequestByIdUseCase,
      this._getEmdadgarInfoUseCase,
      this._getHomeServiceTimesTimesUseCase,
      this._changeHomeServiceRequestTimeUseCase,)
      : super(const ChangeHomeServiceRequestTimeState.idle());


  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetHomeServiceTimesTimesUseCase _getHomeServiceTimesTimesUseCase;
  final ChangeHomeServiceRequestTimeUseCase _changeHomeServiceRequestTimeUseCase;

  String? _errorMessage;
  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  DayScheduleEntity? selectedDay;
  TimeRangeEntity? selectedTime;
  final List<DayScheduleEntity> dayScheduleItems = [];

  Future<void> init() async {
    _safeEmit(const ChangeHomeServiceRequestTimeState.loading());
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const ChangeHomeServiceRequestTimeState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const ChangeHomeServiceRequestTimeState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedRequest();
    if (selectedResult != FetchResultType.success) return selectedResult;

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    if (selectedRequest?.hasEmdadGar ?? false) {
      final emdadgarResult = await _fetchEmdadgarInfo();
      if (emdadgarResult != FetchResultType.success) {
        return emdadgarResult;
      }
    }

    final getDayScheduleItemsResult = await _getDayScheduleItemsResult();
    if (getDayScheduleItemsResult != FetchResultType.success) {
      return getDayScheduleItemsResult;
    }

    return FetchResultType.success;
  }

  Future<FetchResultType> _fetchSelectedRequest() async {
    try {
      selectedRequest = await _fetchSelectedRequestItemUseCase.call();
      return FetchResultType.success;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
  }

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result = await _getHomeServiceRequestByIdUseCase(id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, _, _) {
        selectedRequest = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );
    return fetchResult;
  }

  Future<FetchResultType> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest?.id ?? 0,
      serviceType: selectedRequest?.serviceType?.value ?? 1,
    );
    final result = await _getEmdadgarInfoUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, _, _) {
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
    );
    return fetchResult;
  }

  Future<FetchResultType> _getDayScheduleItemsResult() async {
    final param = GetTimesParamEntity(
        serviceRequestId: selectedRequest?.id ?? 0,
        planningId: selectedRequest?.planningId ?? 0
    );
    final result = await _getHomeServiceTimesTimesUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, _, _) {
        dayScheduleItems.clear();
        dayScheduleItems.addAll(data);
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );
    return fetchResult;
  }


  Future<void> changeRequestTime() async {
    _safeEmit(ChangeHomeServiceRequestTimeState.submitLoading());
    final param = ChangeTimeParamEntity(
      serviceRequestId: selectedRequest?.id ?? 0,
      dateId: selectedDay?.id,
      timeId: selectedTime?.id,
    );
    final result = await _changeHomeServiceRequestTimeUseCase(param);

    result.whenOrNull(
      success: (data, _, _) {
        final successMessage = BottomSheetMessageModel(
            title: '', message: data.message);
        _safeEmit(ChangeHomeServiceRequestTimeState.submitSuccess(
            message: successMessage));
      },
      failure: (error, msg) =>
          _emitError(_fallbackError(msg ?? error.toString())),
      connectionError: () =>
          _safeEmit(const ChangeHomeServiceRequestTimeState.connectionError()),
    );
  }

  void selectDay(DayScheduleEntity day) {
    selectedDay = day;
    selectedTime = null;
    emit(
      ChangeHomeServiceRequestTimeState.daySelected(day: day),
    );
  }

  void selectTime(TimeRangeEntity time) {
    selectedTime = time;
    emit(
      ChangeHomeServiceRequestTimeState.timeSelected(time: time),
    );
  }

  void _safeEmit(ChangeHomeServiceRequestTimeState state) {
    if (!isClosed) emit(state);
  }

  void _emitError([String? message]) {
    _safeEmit(
      ChangeHomeServiceRequestTimeState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  String _fallbackError([String? msg]) {
    if (msg
        ?.trim()
        .isNotEmpty == true) {
      return msg!;
    }
    return 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
  }
}
