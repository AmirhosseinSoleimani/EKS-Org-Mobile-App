import 'package:collection/collection.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/cancel_reasons_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/car_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/payment_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/cancel_request_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/change_time_request_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/get_times_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/payment_type_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/time_table_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/cancel_request_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/change_time_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/get_cancel_reasons_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/get_time_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/update_payment_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_detail/cubit/request_detail_state.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class RequestDetailCubit extends Cubit<RequestDetailState> {
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final UpdatePaymentUseCase _updatePaymentUseCase;
  final GetCancelReasonsUseCase _getCancelReasonsUseCase;
  final CancelRequestUseCase _cancelRequestUseCase;
  final GetTimesUseCase _getTimesUseCase;
  final ChangeTimeUseCase _changeTimeUseCase;
  RequestEntity? selectedRequest;
  CancelReasonEntity? selectedReason;
  DayScheduleEntity? _selectedDay;
  TimeRangeEntity? _selectedTime;

  final ValueNotifier<PaymentType> selectedPaymentTypeVN =
      ValueNotifier<PaymentType>(PaymentType.cash);

  bool timeChanged = false;

  final TextEditingController reasonTextController = TextEditingController();

  RequestDetailCubit(
    this._fetchSelectedRequestItemUseCase,
    this._getCancelReasonsUseCase,
    this._cancelRequestUseCase,
    this._getTimesUseCase,
    this._changeTimeUseCase,
    this._updatePaymentUseCase,
  ) : super(const RequestDetailState.idle());

  static List<CarEntity>? userCarsList = [];
  int? carModelId;
  String? carName;

  bool cancelReasonNotValid = false;
  VoidCallback? _retryAction;

  init() async {
    _fetchSelectedRequest();
  }

  void changePaymentMethod(PaymentType type) {
    selectedPaymentTypeVN.value = type;
  }

  Future<void> _fetchSelectedRequest() async {
    try {
      selectedRequest = await _fetchSelectedRequestItemUseCase();
      emit(const RequestDetailState.fetchedSelectedRequest());
    } catch (error) {
      emit(const RequestDetailState.error(
          message:
              BottomSheetMessageModel(message: 'خطای غیر منتظره', title: '')));
    }
  }

 void getCancelReasons() async {
    _retryAction = getCancelReasons;
    emit(const RequestDetailState.getCancelReasonLoading());
    final result = await _getCancelReasonsUseCase(selectedRequest?.type);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        emit(RequestDetailState.getCancelReasonSuccess(data));
      },
      failure: (error, msg) {
        emit(RequestDetailState.error(
            message: BottomSheetMessageModel(
                message: msg ?? 'خطا در دریافت اطلاعات', title: '')));
      },
      connectionError: () => emit(const RequestDetailState.connectionError()),
    );
  }


  void setSelectedReason(CancelReasonEntity reason) {
    selectedReason = reason;
  }

  cancelRequest() async {
    _retryAction = cancelRequest;
    emit(const RequestDetailState.cancelRequestLoading());

    if(selectedReason == null){
      emit(const RequestDetailState.reasonNotSelectedError(
          message: 'لطفا علت درخواست لغو را انتخاب کنید'));
      return;
    }

    if(reasonTextController.text.isEmpty){
      emit(const RequestDetailState.reasonNotSelectedError(
          message: 'لطفا توضیحات علت درخواست لغو را بنویسید'));
      return;
    }
    final params = CancelRequestParam(
        serviceType: selectedRequest?.type ?? 0,
        cancelReasonId: selectedReason?.id ?? 0,
        serviceRequestId: selectedRequest?.id ?? 0,
        description: reasonTextController.text);

    final result = await _cancelRequestUseCase(params);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        reasonTextController.text = '';
        emit(RequestDetailState.cancelRequestSuccess(data.message));
      },
      failure: (error, msg) {
        emit(RequestDetailState.error(
            message: BottomSheetMessageModel(title: '', message: msg ?? '')));
      },
      connectionError: () => emit(const RequestDetailState.connectionError()),
    );
  }


  void getTimes() async {
    _retryAction = getTimes;
    emit(const RequestDetailState.getTimesLoading());
    final param = GetTimesParam(
      serviceRequestId: selectedRequest?.id,
    );

    final result = await _getTimesUseCase(param);
    result.whenOrNull(
      success: (data, failures, resultCode) async {

        final selectedDay = data.firstWhere(
          (day) => day?.date == selectedRequest?.serviceDate,
          orElse: () => null,
        );

        final selectedTime = selectedDay?.times.firstWhereOrNull(
          (t) => t.startTime == selectedRequest?.serviceTime,
        );

        _selectedDay = selectedDay;
        _selectedTime = selectedTime;

        emit(RequestDetailState.getTimesSuccess(data));
      },
      failure: (error, msg) {
        emit(RequestDetailState.error(
            message: BottomSheetMessageModel(
                message: msg ?? 'خطا در دریافت اطلاعات', title: '')));
      },
      connectionError: () => emit(const RequestDetailState.connectionError()),
    );
  }

  DayScheduleEntity? get selectedDay => _selectedDay;

  void selectDay(DayScheduleEntity day) {
    _selectedDay = day;
    emit(RequestDetailState.daySelected(day));
  }

  TimeRangeEntity? get selectedTime => _selectedTime;

  void selectTime(TimeRangeEntity time) {
    _selectedTime = time;
    emit(RequestDetailState.timeSelected(time));
  }

  changeRequestTime() async {
    _retryAction = changeRequestTime;
    emit(const RequestDetailState.changeTimeRequestLoading());

    if (selectedTime == null) {
      emit(const RequestDetailState.reasonNotSelectedError(
          message: 'لطفا زمان مورد نظر خود را انتخاب کنید'));
      return;
    }

    final params = ChangeTimeRequestParam(
      dateId: selectedDay?.id,
      timeId: selectedTime?.id,
      serviceRequestId: selectedRequest?.id,
    );

    final result = await _changeTimeUseCase(params);
    result.whenOrNull(
      success: (data, failures, resultCode) async {

        _updateSelectedRequest();
        timeChanged = true;
        _selectedDay = null;
        _selectedTime = null;
        await Future.delayed(const Duration(milliseconds: 150));

        emit(RequestDetailState.changeTimeRequestSuccess(BottomSheetMessageModel(
          title: '',
          message: data.message
        )));
      },
      failure: (error, msg) {
        emit(RequestDetailState.error(
            message: BottomSheetMessageModel(title: '', message: msg ?? '')));
      },
      connectionError: () => emit(const RequestDetailState.connectionError()),
    );
  }
  void _updateSelectedRequest() {
    selectedRequest = selectedRequest?.copyWith(
        serviceDate: selectedDay?.date,
        serviceTime: _selectedTime?.startTime
    );

    emit(const RequestDetailState.fetchedSelectedRequest());
  }

  void onUpdatePaymentType() async {
    _retryAction = onUpdatePaymentType;
    emit(const RequestDetailState.updatePaymentLoading());
    final paymentTypeParam = PaymentTypeParam(
      type: selectedPaymentTypeVN.value,
      customerInvoiceDocGuid: selectedRequest?.invoiceDocumentGuid,
    );
    final result = await _updatePaymentUseCase(paymentTypeParam);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        final isOnline = selectedPaymentTypeVN.value == PaymentType.online;
        if (isOnline) {
          if (data.transStatus == "0" && data.paymentLink != null) {
            await launchPaymentUrl(paymentUrl: data.paymentLink!);
            emit(const RequestDetailState.successUpdatePayment(
              message: 'درخواست شما با موفقیت ثبت شد.',
            ));
          } else {
            emit(const RequestDetailState.errorUpdatePayment(
                message: 'سرویس پرداخت در دسترس نمی‌باشد.' ?? ''));
          }
        } else {
          emit(const RequestDetailState.successUpdatePayment(
            message:
                ' درخواست شما با موفقیت ثبت شد. لطفاً هزینه خدمت را مستقیماً به امدادگر پرداخت کنید.',
          ));
        }
      },
      failure: (error, msg) {
        emit(RequestDetailState.errorUpdatePayment(message: msg ?? ''));
      },
      connectionError: () => emit(const RequestDetailState.connectionError()),
    );
  }

  Future<void> launchPaymentUrl({required String paymentUrl}) async {
    try {
      await launchUrl(Uri.parse(paymentUrl),
          mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Future<void> close() {
    selectedPaymentTypeVN.dispose();
    return super.close();
  }

  void retryLastAction() => _retryAction?.call();
}
