// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_history_invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RequestHistoryInvoiceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(DialogDataModel dialogDataModel) error,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(DialogDataModel dialogDataModel)? error,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(DialogDataModel dialogDataModel)? error,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestHistoryInvoiceIdleState value) idle,
    required TResult Function(RequestHistoryInvoiceErrorState value) error,
    required TResult Function(RequestHistoryInvoiceLoadingState value) loading,
    required TResult Function(RequestHistoryInvoiceSuccessState value) success,
    required TResult Function(_ConnectionError value) connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult? Function(RequestHistoryInvoiceErrorState value)? error,
    TResult? Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult? Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult? Function(_ConnectionError value)? connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult Function(RequestHistoryInvoiceErrorState value)? error,
    TResult Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult Function(_ConnectionError value)? connectionError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestHistoryInvoiceStateCopyWith<$Res> {
  factory $RequestHistoryInvoiceStateCopyWith(RequestHistoryInvoiceState value,
          $Res Function(RequestHistoryInvoiceState) then) =
      _$RequestHistoryInvoiceStateCopyWithImpl<$Res,
          RequestHistoryInvoiceState>;
}

/// @nodoc
class _$RequestHistoryInvoiceStateCopyWithImpl<$Res,
        $Val extends RequestHistoryInvoiceState>
    implements $RequestHistoryInvoiceStateCopyWith<$Res> {
  _$RequestHistoryInvoiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RequestHistoryInvoiceIdleStateImplCopyWith<$Res> {
  factory _$$RequestHistoryInvoiceIdleStateImplCopyWith(
          _$RequestHistoryInvoiceIdleStateImpl value,
          $Res Function(_$RequestHistoryInvoiceIdleStateImpl) then) =
      __$$RequestHistoryInvoiceIdleStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestHistoryInvoiceIdleStateImplCopyWithImpl<$Res>
    extends _$RequestHistoryInvoiceStateCopyWithImpl<$Res,
        _$RequestHistoryInvoiceIdleStateImpl>
    implements _$$RequestHistoryInvoiceIdleStateImplCopyWith<$Res> {
  __$$RequestHistoryInvoiceIdleStateImplCopyWithImpl(
      _$RequestHistoryInvoiceIdleStateImpl _value,
      $Res Function(_$RequestHistoryInvoiceIdleStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RequestHistoryInvoiceIdleStateImpl
    implements RequestHistoryInvoiceIdleState {
  const _$RequestHistoryInvoiceIdleStateImpl();

  @override
  String toString() {
    return 'RequestHistoryInvoiceState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestHistoryInvoiceIdleStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(DialogDataModel dialogDataModel) error,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() connectionError,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(DialogDataModel dialogDataModel)? error,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? connectionError,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(DialogDataModel dialogDataModel)? error,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestHistoryInvoiceIdleState value) idle,
    required TResult Function(RequestHistoryInvoiceErrorState value) error,
    required TResult Function(RequestHistoryInvoiceLoadingState value) loading,
    required TResult Function(RequestHistoryInvoiceSuccessState value) success,
    required TResult Function(_ConnectionError value) connectionError,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult? Function(RequestHistoryInvoiceErrorState value)? error,
    TResult? Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult? Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult? Function(_ConnectionError value)? connectionError,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult Function(RequestHistoryInvoiceErrorState value)? error,
    TResult Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult Function(_ConnectionError value)? connectionError,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class RequestHistoryInvoiceIdleState
    implements RequestHistoryInvoiceState {
  const factory RequestHistoryInvoiceIdleState() =
      _$RequestHistoryInvoiceIdleStateImpl;
}

/// @nodoc
abstract class _$$RequestHistoryInvoiceErrorStateImplCopyWith<$Res> {
  factory _$$RequestHistoryInvoiceErrorStateImplCopyWith(
          _$RequestHistoryInvoiceErrorStateImpl value,
          $Res Function(_$RequestHistoryInvoiceErrorStateImpl) then) =
      __$$RequestHistoryInvoiceErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DialogDataModel dialogDataModel});
}

/// @nodoc
class __$$RequestHistoryInvoiceErrorStateImplCopyWithImpl<$Res>
    extends _$RequestHistoryInvoiceStateCopyWithImpl<$Res,
        _$RequestHistoryInvoiceErrorStateImpl>
    implements _$$RequestHistoryInvoiceErrorStateImplCopyWith<$Res> {
  __$$RequestHistoryInvoiceErrorStateImplCopyWithImpl(
      _$RequestHistoryInvoiceErrorStateImpl _value,
      $Res Function(_$RequestHistoryInvoiceErrorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dialogDataModel = null,
  }) {
    return _then(_$RequestHistoryInvoiceErrorStateImpl(
      dialogDataModel: null == dialogDataModel
          ? _value.dialogDataModel
          : dialogDataModel // ignore: cast_nullable_to_non_nullable
              as DialogDataModel,
    ));
  }
}

/// @nodoc

class _$RequestHistoryInvoiceErrorStateImpl
    implements RequestHistoryInvoiceErrorState {
  const _$RequestHistoryInvoiceErrorStateImpl({required this.dialogDataModel});

  @override
  final DialogDataModel dialogDataModel;

  @override
  String toString() {
    return 'RequestHistoryInvoiceState.error(dialogDataModel: $dialogDataModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestHistoryInvoiceErrorStateImpl &&
            (identical(other.dialogDataModel, dialogDataModel) ||
                other.dialogDataModel == dialogDataModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dialogDataModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestHistoryInvoiceErrorStateImplCopyWith<
          _$RequestHistoryInvoiceErrorStateImpl>
      get copyWith => __$$RequestHistoryInvoiceErrorStateImplCopyWithImpl<
          _$RequestHistoryInvoiceErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(DialogDataModel dialogDataModel) error,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() connectionError,
  }) {
    return error(dialogDataModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(DialogDataModel dialogDataModel)? error,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? connectionError,
  }) {
    return error?.call(dialogDataModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(DialogDataModel dialogDataModel)? error,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(dialogDataModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestHistoryInvoiceIdleState value) idle,
    required TResult Function(RequestHistoryInvoiceErrorState value) error,
    required TResult Function(RequestHistoryInvoiceLoadingState value) loading,
    required TResult Function(RequestHistoryInvoiceSuccessState value) success,
    required TResult Function(_ConnectionError value) connectionError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult? Function(RequestHistoryInvoiceErrorState value)? error,
    TResult? Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult? Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult? Function(_ConnectionError value)? connectionError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult Function(RequestHistoryInvoiceErrorState value)? error,
    TResult Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult Function(_ConnectionError value)? connectionError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RequestHistoryInvoiceErrorState
    implements RequestHistoryInvoiceState {
  const factory RequestHistoryInvoiceErrorState(
          {required final DialogDataModel dialogDataModel}) =
      _$RequestHistoryInvoiceErrorStateImpl;

  DialogDataModel get dialogDataModel;
  @JsonKey(ignore: true)
  _$$RequestHistoryInvoiceErrorStateImplCopyWith<
          _$RequestHistoryInvoiceErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestHistoryInvoiceLoadingStateImplCopyWith<$Res> {
  factory _$$RequestHistoryInvoiceLoadingStateImplCopyWith(
          _$RequestHistoryInvoiceLoadingStateImpl value,
          $Res Function(_$RequestHistoryInvoiceLoadingStateImpl) then) =
      __$$RequestHistoryInvoiceLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestHistoryInvoiceLoadingStateImplCopyWithImpl<$Res>
    extends _$RequestHistoryInvoiceStateCopyWithImpl<$Res,
        _$RequestHistoryInvoiceLoadingStateImpl>
    implements _$$RequestHistoryInvoiceLoadingStateImplCopyWith<$Res> {
  __$$RequestHistoryInvoiceLoadingStateImplCopyWithImpl(
      _$RequestHistoryInvoiceLoadingStateImpl _value,
      $Res Function(_$RequestHistoryInvoiceLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RequestHistoryInvoiceLoadingStateImpl
    implements RequestHistoryInvoiceLoadingState {
  const _$RequestHistoryInvoiceLoadingStateImpl();

  @override
  String toString() {
    return 'RequestHistoryInvoiceState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestHistoryInvoiceLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(DialogDataModel dialogDataModel) error,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() connectionError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(DialogDataModel dialogDataModel)? error,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? connectionError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(DialogDataModel dialogDataModel)? error,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestHistoryInvoiceIdleState value) idle,
    required TResult Function(RequestHistoryInvoiceErrorState value) error,
    required TResult Function(RequestHistoryInvoiceLoadingState value) loading,
    required TResult Function(RequestHistoryInvoiceSuccessState value) success,
    required TResult Function(_ConnectionError value) connectionError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult? Function(RequestHistoryInvoiceErrorState value)? error,
    TResult? Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult? Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult? Function(_ConnectionError value)? connectionError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult Function(RequestHistoryInvoiceErrorState value)? error,
    TResult Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult Function(_ConnectionError value)? connectionError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RequestHistoryInvoiceLoadingState
    implements RequestHistoryInvoiceState {
  const factory RequestHistoryInvoiceLoadingState() =
      _$RequestHistoryInvoiceLoadingStateImpl;
}

/// @nodoc
abstract class _$$RequestHistoryInvoiceSuccessStateImplCopyWith<$Res> {
  factory _$$RequestHistoryInvoiceSuccessStateImplCopyWith(
          _$RequestHistoryInvoiceSuccessStateImpl value,
          $Res Function(_$RequestHistoryInvoiceSuccessStateImpl) then) =
      __$$RequestHistoryInvoiceSuccessStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestHistoryInvoiceSuccessStateImplCopyWithImpl<$Res>
    extends _$RequestHistoryInvoiceStateCopyWithImpl<$Res,
        _$RequestHistoryInvoiceSuccessStateImpl>
    implements _$$RequestHistoryInvoiceSuccessStateImplCopyWith<$Res> {
  __$$RequestHistoryInvoiceSuccessStateImplCopyWithImpl(
      _$RequestHistoryInvoiceSuccessStateImpl _value,
      $Res Function(_$RequestHistoryInvoiceSuccessStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RequestHistoryInvoiceSuccessStateImpl
    implements RequestHistoryInvoiceSuccessState {
  const _$RequestHistoryInvoiceSuccessStateImpl();

  @override
  String toString() {
    return 'RequestHistoryInvoiceState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestHistoryInvoiceSuccessStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(DialogDataModel dialogDataModel) error,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() connectionError,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(DialogDataModel dialogDataModel)? error,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? connectionError,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(DialogDataModel dialogDataModel)? error,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestHistoryInvoiceIdleState value) idle,
    required TResult Function(RequestHistoryInvoiceErrorState value) error,
    required TResult Function(RequestHistoryInvoiceLoadingState value) loading,
    required TResult Function(RequestHistoryInvoiceSuccessState value) success,
    required TResult Function(_ConnectionError value) connectionError,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult? Function(RequestHistoryInvoiceErrorState value)? error,
    TResult? Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult? Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult? Function(_ConnectionError value)? connectionError,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult Function(RequestHistoryInvoiceErrorState value)? error,
    TResult Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult Function(_ConnectionError value)? connectionError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RequestHistoryInvoiceSuccessState
    implements RequestHistoryInvoiceState {
  const factory RequestHistoryInvoiceSuccessState() =
      _$RequestHistoryInvoiceSuccessStateImpl;
}

/// @nodoc
abstract class _$$ConnectionErrorImplCopyWith<$Res> {
  factory _$$ConnectionErrorImplCopyWith(_$ConnectionErrorImpl value,
          $Res Function(_$ConnectionErrorImpl) then) =
      __$$ConnectionErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectionErrorImplCopyWithImpl<$Res>
    extends _$RequestHistoryInvoiceStateCopyWithImpl<$Res,
        _$ConnectionErrorImpl> implements _$$ConnectionErrorImplCopyWith<$Res> {
  __$$ConnectionErrorImplCopyWithImpl(
      _$ConnectionErrorImpl _value, $Res Function(_$ConnectionErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ConnectionErrorImpl implements _ConnectionError {
  const _$ConnectionErrorImpl();

  @override
  String toString() {
    return 'RequestHistoryInvoiceState.connectionError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectionErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(DialogDataModel dialogDataModel) error,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() connectionError,
  }) {
    return connectionError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(DialogDataModel dialogDataModel)? error,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? connectionError,
  }) {
    return connectionError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(DialogDataModel dialogDataModel)? error,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (connectionError != null) {
      return connectionError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestHistoryInvoiceIdleState value) idle,
    required TResult Function(RequestHistoryInvoiceErrorState value) error,
    required TResult Function(RequestHistoryInvoiceLoadingState value) loading,
    required TResult Function(RequestHistoryInvoiceSuccessState value) success,
    required TResult Function(_ConnectionError value) connectionError,
  }) {
    return connectionError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult? Function(RequestHistoryInvoiceErrorState value)? error,
    TResult? Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult? Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult? Function(_ConnectionError value)? connectionError,
  }) {
    return connectionError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestHistoryInvoiceIdleState value)? idle,
    TResult Function(RequestHistoryInvoiceErrorState value)? error,
    TResult Function(RequestHistoryInvoiceLoadingState value)? loading,
    TResult Function(RequestHistoryInvoiceSuccessState value)? success,
    TResult Function(_ConnectionError value)? connectionError,
    required TResult orElse(),
  }) {
    if (connectionError != null) {
      return connectionError(this);
    }
    return orElse();
  }
}

abstract class _ConnectionError implements RequestHistoryInvoiceState {
  const factory _ConnectionError() = _$ConnectionErrorImpl;
}
