import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'evaluation_aid_service_request_state.dart';
part 'evaluation_aid_service_request_cubit.freezed.dart';

@injectable
class EvaluationAidServiceRequestCubit extends Cubit<EvaluationAidServiceRequestState> {
  EvaluationAidServiceRequestCubit() : super(const EvaluationAidServiceRequestState.idle());

  String? _errorMessage;
  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;

  final kilometerController = TextEditingController();
  final customerDistanceController = TextEditingController();
  final assignDateController = TextEditingController();
  final assignTimeController = TextEditingController();
  DateTime? assignDateTime;

  final arriveDateController = TextEditingController();
  final arriveTimeController = TextEditingController();

  final descriptionController = TextEditingController();
  DateTime? arriveDateTime;

  Future<void> init () async {
    _safeEmit(EvaluationAidServiceRequestState.loaded());
  }
  Future<void> submit () async {}

  bool isBottomSheetOpen = false;

  void markBottomSheetOpen() {
    isBottomSheetOpen = true;
  }

  void markBottomSheetClosed() {
    isBottomSheetOpen = false;
  }



  void setAssignDate(DateTime? date) {
    if (date == null) return;
    final current = assignDateTime ?? DateTime.now();
    assignDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setAssignTime(DateTime time) {
    final current = assignDateTime ?? DateTime.now();
    assignDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  void setArriveDate(DateTime? date) {
    if (date == null) return;
    final current = arriveDateTime ?? DateTime.now();
    arriveDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setArriveTime(DateTime time) {
    final current = arriveDateTime ?? DateTime.now();
    arriveDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  void _safeEmit(EvaluationAidServiceRequestState state) {
    if (!isClosed) emit(state);
  }

  void _emitError([String? message]) {
    _safeEmit(
      EvaluationAidServiceRequestState.error(
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

  @override
  Future<void> close() {
    assignDateController.dispose();
    assignTimeController.dispose();
    arriveDateController.dispose();
    arriveTimeController.dispose();
    descriptionController.dispose();

    return super.close();
  }
}
