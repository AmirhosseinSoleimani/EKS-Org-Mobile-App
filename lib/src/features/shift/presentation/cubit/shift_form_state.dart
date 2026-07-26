part of 'shift_form_cubit.dart';

@freezed
class ShiftFormState with _$ShiftFormState {
  const factory ShiftFormState.initial() = _Initial;

  const factory ShiftFormState.loading({
    @Default([]) List<CurrentSessionEnumItemEntity> shiftTypes,
  }) = _Loading;

  const factory ShiftFormState.ready({
    required ShiftEntity item,
    @Default([]) List<CurrentSessionEnumItemEntity> shiftTypes,
  }) = _Ready;

  const factory ShiftFormState.submitting({
    required ShiftEntity item,
    @Default([]) List<CurrentSessionEnumItemEntity> shiftTypes,
  }) = _Submitting;

  const factory ShiftFormState.success({
    required ShiftFormAction action,
    required String message,
  }) = _Success;

  const factory ShiftFormState.validationFailure({
    required String message,
    required ShiftEntity item,
    @Default([]) List<CurrentSessionEnumItemEntity> shiftTypes,
  }) = _ValidationFailure;

  const factory ShiftFormState.failure({
    required String message,
    ShiftEntity? item,
    @Default([]) List<CurrentSessionEnumItemEntity> shiftTypes,
  }) = _Failure;

  const factory ShiftFormState.connectionError({
    ShiftEntity? item,
    @Default([]) List<CurrentSessionEnumItemEntity> shiftTypes,
  }) = _ConnectionError;

}
