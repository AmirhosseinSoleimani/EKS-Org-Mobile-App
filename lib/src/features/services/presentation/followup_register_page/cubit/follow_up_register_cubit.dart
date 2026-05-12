import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/source.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/follow_up_status_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/create_follow_up_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/post_follow_up_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/create_follow_up_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_follow_up_status_type_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_followup_history_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/domain/use_cases/get_server_date_time_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

part 'follow_up_register_cubit.freezed.dart';

part 'follow_up_register_state.dart';

@injectable
class FollowUpRegisterCubit extends Cubit<FollowUpRegisterState> {
  FollowUpRegisterCubit(
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
    this._getRequestFollowupHistoryUseCase,
    this._getFollowUpStatusTypeListUseCase,
    this._createFollowUpUseCase,
    this._getServerDateTimeUseCase,
  ) : super(const FollowUpRegisterState.idle());

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetRequestFollowupHistoryUseCase _getRequestFollowupHistoryUseCase;
  final GetFollowUpStatusTypeListUseCase _getFollowUpStatusTypeListUseCase;
  final CreateFollowUpUseCase _createFollowUpUseCase;
  final GetServerDateTimeUseCase _getServerDateTimeUseCase;

  final int _pageSize = 2;
  String? _errorMessage;
  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  final List<FollowupItemEntity> followups = [];
  final List<FollowUpStatusTypeEntity> _allFollowUpStatusTypeList = [];

  final dispatchDiffNotifier = ValueNotifier<Duration?>(null);

  final ValueNotifier<List<FollowUpStatusTypeEntity>> filteredStatusItems =
      ValueNotifier([]);
  final selectedSource = ValueNotifier<Source?>(null);
  final selectedFollowUpStatusType = ValueNotifier<FollowUpStatusTypeEntity?>(
    null,
  );
  final dispatchDateTimeNotifier = ValueNotifier<DateTime?>(null);
  final announcementTimeNotifier = ValueNotifier<DateTime?>(null);

  final descriptionController = TextEditingController();

  DateTime? get dispatchDateTime => dispatchDateTimeNotifier.value;

  bool get _shouldFetchEmdadgarInfo {
    return (selectedRequest?.requestStatus ?? 0) > 1;
  }

  void setSelectedSource(Source? source) {
    selectedSource.value = source;

    if (source == null) {
      filteredStatusItems.value = [];
    } else {
      filteredStatusItems.value = _allFollowUpStatusTypeList
          .where((item) => item.sourceTypeName == source.sourceTypeName)
          .toList();
    }
    selectedFollowUpStatusType.value = null;
  }

  Future<void> setSelectedFollowupStatus(FollowUpStatusTypeEntity value) async {
    selectedFollowUpStatusType.value = value;

    // todo: fix condition
    if (true) {
      final serverDateTimeInfo = await _getServerDateTimeUseCase();

      serverDateTimeInfo.whenOrNull(
        success: (data, failures, resultCode) {
          final announcementTime = data?.serverTime;

          if (announcementTime != null) {
            announcementTimeNotifier.value = announcementTime;
          }

          final assignDate = selectedRequest?.assignDateTime;

          if (assignDate == null || announcementTime == null) {
            dispatchDiffNotifier.value = null;
            return;
          }

          final announcementFull = DateTime(
            assignDate.year,
            assignDate.month,
            assignDate.day,
            announcementTime.hour,
            announcementTime.minute,
            announcementTime.second,
          );

          final diff = announcementFull.difference(assignDate);

          if (diff.inMinutes == 0) {
            dispatchDiffNotifier.value = null;
          } else {
            dispatchDiffNotifier.value = diff;
          }
        },
        failure: (error, msg) => _emitError(_fallbackError(msg ?? error.toString())),
           connectionError: () => _safeEmit(const FollowUpRegisterState.connectionError()),

      );
    }
  }


  void setDispatchDate(DateTime? date) {
    if (date == null) return;
    final current = dispatchDateTime ?? DateTime.now();
    dispatchDateTimeNotifier.value = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setAnnouncementTime(DateTime time) {
    final current = dispatchDateTime ?? DateTime.now();
    dispatchDateTimeNotifier.value = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> init() async {
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const FollowUpRegisterState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const FollowUpRegisterState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedRequest();
    if (selectedResult != FetchResultType.success) return selectedResult;

    _safeEmit(const FollowUpRegisterState.loading());

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    if (_shouldFetchEmdadgarInfo) {
      final emdadgarResult = await _fetchEmdadgarInfo();
      if (emdadgarResult != FetchResultType.success) {
        return emdadgarResult;
      }
    }

    final followUpHistoryResult = await _getFollowupHistory();
    if (followUpHistoryResult != FetchResultType.success) {
      return followUpHistoryResult;
    }

    final followUpStatusTypeResult = await _getFollowupStatusTypeList();
    if (followUpStatusTypeResult != FetchResultType.success) {
      return followUpStatusTypeResult;
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

    final result = (selectedRequest?.serviceType == ServiceType.homeService)
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

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

  Future<FetchResultType> _getFollowupHistory() async {
    final param = RequestOperationParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      requestId: selectedRequest?.id,
      pageSize: _pageSize,
    );

    final result = await _getRequestFollowupHistoryUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, _, _) {
        followups.clear();
        followups.addAll(data.followUpList ?? []);
        fetchResult = FetchResultType.success;
      },
      failure: (error, msg) {
        _errorMessage = _fallbackError(msg ?? error.toString());
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );

    return fetchResult;
  }

  Future<FetchResultType> _getFollowupStatusTypeList() async {
    final result = await _getFollowUpStatusTypeListUseCase();

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, _, _) {
        _allFollowUpStatusTypeList.clear();
        _allFollowUpStatusTypeList.addAll(data);
        fetchResult = FetchResultType.success;
      },
      failure: (error, msg) {
        _errorMessage = _fallbackError(msg ?? error.toString());
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );

    return fetchResult;
  }

  Future<void> refreshHistoryList() async {
    final followUpHistoryResult = await _getFollowupHistory();
  }

  Future<void> createFollowUp() async {
    final param = CreateFollowUpParamEntity(
      serviceType: selectedRequest?.serviceType?.value,
      serviceRequestId: selectedRequest?.id,
      sourceType: selectedSource.value?.value,
      resultStatusId: selectedFollowUpStatusType.value?.id,
      description: descriptionController.text.trim(),
      followUpDateTime: (dispatchDateTime != null)
          ? DateFormat('yyyy-MM-dd HH:mm').format(dispatchDateTime!)
          : null,
    );
    final createFollowUpResult = await _createFollowUpUseCase(param);
    createFollowUpResult.whenOrNull(
      success: (data, failures, resultCode) {
        _safeEmit(FollowUpRegisterState.submitSuccess(data: data));
      },
      failure: (error, msg) =>
          _emitError(_fallbackError(msg ?? error.toString())),
      connectionError: () =>
          _safeEmit(const FollowUpRegisterState.connectionError()),
    );
  }

  void _safeEmit(FollowUpRegisterState state) {
    if (!isClosed) emit(state);
  }

  void _emitError([String? message]) {
    _safeEmit(
      FollowUpRegisterState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  String _fallbackError([String? msg]) {
    if (msg?.trim().isNotEmpty == true) {
      return msg!;
    }
    return 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
  }
}
