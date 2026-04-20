import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/evaluation_history_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_evaluation_history_list_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'evaluation_history_cubit.freezed.dart';

part 'evaluation_history_state.dart';

@injectable
class EvaluationHistoryCubit extends Cubit<EvaluationHistoryState> {
  final GetEvaluationHistoryListUseCase _getEvaluationHistoryListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;

  EvaluationHistoryCubit(
    this._getEvaluationHistoryListUseCase,
    this._fetchSelectedRequestItemUseCase,
  ) : super(const EvaluationHistoryState.idle());

  BaseRequestEntity? selectedRequest;
  final List<EvaluationHistoryItemEntity> items = [];

  int? requestId;
  Future<void> init() async {


    emit(const EvaluationHistoryState.loading());

    await Future.delayed(const Duration(seconds: 2));

    selectedRequest = const ReliefRequestEntity(
      id: 123,
      trackCode: 124,
      requestDateJalali: "1405/01/31",
      requestTime: "07:54:39",
      requestStatusTitle: "تکمیل شده",
      isGuaranty: false,
      isSubscription: false,
    );

    items.clear();

    items.addAll([
      EvaluationHistoryItemEntity(
        id: 1034162,
        firstName: "مدیر",
        lastName: "سیستم",
        insertUserName: "مدیر سیستم",
        insertDateTime: "2026-04-20T07:54:39",
        insertDateTimeJalali: "1405/01/31 07:54:39",
        cancelReasonTitle: "در محل حاضر نبود (امدادخواه)",
        cancelReasonDetailTitle: "سوء استفاده از خودرو مشترک",
        emdadServiceCategoryTitle: "کنسل مجاز",
        distanceToCustomer: 0.0,
        distanceHamlCustomer: 0.0,
        isAccepted: false,
        stopTime: 0,
        useDakal: false,
        payAvarezi: false,
        emdadgarNavganTypeTitle: "خودروي سواري",
        arriveDateTime: "2026-04-18T17:30:00",
        arriveDateTimeJalali: "1405/01/29 17:30:00",
        endWorkDateTime: "2026-04-20T00:00:00",
        endWorkDateTimeJalali: "1405/01/31 00:00:00",
        assignTrackerName: "مدیر سیستم",
        arriveTrackerName: "مدیر سیستم",
        endWorkTrackerName: "مدیر سیستم",
        invoiceId: -1,
        statusTitle: "ثبت اولیه",
        description: "نمونه توضیحات تست",
        hasImage: false,
      ),
      EvaluationHistoryItemEntity(
        id: 1034161,
        firstName: "مدیر",
        lastName: "سیستم",
        insertUserName: "مدیر سیستم",
        insertDateTime: "2026-04-20T07:54:26",
        insertDateTimeJalali: "1405/01/31 07:54:26",
        cancelReasonTitle: "در محل حاضر نبود (امدادخواه)",
        cancelReasonDetailTitle: "سوء استفاده از خودرو مشترک",
        emdadServiceCategoryTitle: "کنسل مجاز",
        distanceToCustomer: 0.0,
        distanceHamlCustomer: 0.0,
        isAccepted: false,
        stopTime: 0,
        useDakal: false,
        payAvarezi: false,
        emdadgarNavganTypeTitle: "خودروي سواري",
        arriveDateTime: "2026-04-18T17:30:00",
        arriveDateTimeJalali: "1405/01/29 17:30:00",
        endWorkDateTime: "2026-04-20T00:00:00",
        endWorkDateTimeJalali: "1405/01/31 00:00:00",
        assignTrackerName: "مدیر سیستم",
        arriveTrackerName: "مدیر سیستم",
        endWorkTrackerName: "مدیر سیستم",
        invoiceId: -1,
        statusTitle: "تکمیل شده",
        description: "توضیحات آیتم دوم",
        hasImage: false,
      ),
    ]);

    _safeEmit(const EvaluationHistoryState.loaded());
  }



/*
  Future<void> init() async {
    emit(const EvaluationHistoryState.loading());

    final BaseRequestEntity? cachedRequest =
        await _fetchSelectedRequestItemUseCase();

    if (cachedRequest == null) {
      _safeEmit(
        const EvaluationHistoryState.error(
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

    await _loadEvaluationHistoryList();
  }*/

  Future<void> _loadEvaluationHistoryList() async {

    items.clear();

    final result = await _getEvaluationHistoryListUseCase(
      EvaluationHistoryParamEntity(
        serviceType: selectedRequest is HomeServiceRequestEntity
            ? ServiceType.homeService.value
            : ServiceType.reliefService.value,
        serviceRequestId: selectedRequest?.id,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items.addAll(data);
        _safeEmit(const EvaluationHistoryState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          EvaluationHistoryState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const EvaluationHistoryState.connectionError()),
    );
  }



  void _safeEmit(EvaluationHistoryState state) {
    if (!isClosed) emit(state);
  }
}
