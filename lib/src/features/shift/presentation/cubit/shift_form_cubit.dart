import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/use_cases/create_shift_use_case.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/use_cases/get_shift_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/use_cases/update_shift_use_case.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/use_cases/validate_shift_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'shift_form_cubit.freezed.dart';
part 'shift_form_state.dart';

enum ShiftFormAction { create, update }

@injectable
class ShiftFormCubit extends Cubit<ShiftFormState> {
  ShiftFormCubit(
    this._getByIdUseCase,
    this._createUseCase,
    this._updateUseCase,
    this._validateUseCase,
    this._currentSessionManager,
  ) : super(const ShiftFormState.initial());

  final GetShiftByIdUseCase _getByIdUseCase;
  final CreateShiftUseCase _createUseCase;
  final UpdateShiftUseCase _updateUseCase;
  final ValidateShiftUseCase _validateUseCase;
  final CurrentSessionManager _currentSessionManager;

  bool _isSubmitting = false;

  List<CurrentSessionEnumItemEntity> get shiftTypes {
    return _currentSessionManager.currentSession?.enums?.shiftType ??
        const <CurrentSessionEnumItemEntity>[];
  }

  void createNewForm() {
    _safeEmit(ShiftFormState.ready(
      item: const ShiftEntity(isActive: true),
      shiftTypes: shiftTypes,
    ));
  }

  Future<void> loadForm({int? id}) async {
    if (id == null) {
      _safeEmit(ShiftFormState.ready(
        item: const ShiftEntity(isActive: true),
        shiftTypes: shiftTypes,
      ));
      return;
    }

    _safeEmit(ShiftFormState.loading(shiftTypes: shiftTypes));
    final result = await _getByIdUseCase(id);
    result.when(
      success: (data, failures, resultCode) {
        _safeEmit(ShiftFormState.ready(
          item: data,
          shiftTypes: shiftTypes,
        ));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => _safeEmit(ShiftFormState.connectionError(
        shiftTypes: shiftTypes,
      )),
    );
  }

  Future<bool> submit(ShiftEntity item) async {
    if (_isSubmitting) return false;

    final validation = await _validateUseCase(item);
    if (!validation.isValid) {
      _safeEmit(ShiftFormState.validationFailure(
        message: validation.message ?? 'اطلاعات شیفت معتبر نیست',
        item: item,
        shiftTypes: shiftTypes,
      ));
      return false;
    }

    _isSubmitting = true;
    _safeEmit(ShiftFormState.submitting(
      item: item,
      shiftTypes: shiftTypes,
    ));

    final isCreate = item.id == null || item.id == 0;
    final result = isCreate ? await _createUseCase(item) : await _updateUseCase(item);

    return result.when(
      success: (data, failures, resultCode) {
        _isSubmitting = false;
        _safeEmit(ShiftFormState.success(
          action: isCreate ? ShiftFormAction.create : ShiftFormAction.update,
          message:
              isCreate ? 'شیفت با موفقیت ثبت شد' : 'شیفت با موفقیت ویرایش شد',
        ));
        return true;
      },
      failure: (error, failures) {
        _isSubmitting = false;
        _emitFailure(failures, item: item);
        return false;
      },
      expireToken: () {
        _isSubmitting = false;
        _emitFailure('نشست کاربری منقضی شده است.', item: item);
        return false;
      },
      connectionError: () {
        _isSubmitting = false;
        _safeEmit(ShiftFormState.connectionError(
          item: item,
          shiftTypes: shiftTypes,
        ));
        return false;
      },
    );
  }

  void _emitFailure(String? message, {ShiftEntity? item}) {
    _safeEmit(ShiftFormState.failure(
      message: message?.trim().isNotEmpty == true
          ? message!
          : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید',
      item: item,
      shiftTypes: shiftTypes,
    ));
  }

  void _safeEmit(ShiftFormState state) {
    if (!isClosed) emit(state);
  }
}
