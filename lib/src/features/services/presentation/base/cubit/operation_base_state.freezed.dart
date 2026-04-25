// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_base_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OperationBaseState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() loadingMore,
    required TResult Function(BottomSheetMessageModel message) error,
    required TResult Function() connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? loadingMore,
    TResult? Function(BottomSheetMessageModel message)? error,
    TResult? Function()? connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? loadingMore,
    TResult Function(BottomSheetMessageModel message)? error,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_LoadingMore<T> value) loadingMore,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_ConnectionError<T> value) connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_LoadingMore<T> value)? loadingMore,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_ConnectionError<T> value)? connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_LoadingMore<T> value)? loadingMore,
    TResult Function(_Error<T> value)? error,
    TResult Function(_ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperationBaseStateCopyWith<T, $Res> {
  factory $OperationBaseStateCopyWith(OperationBaseState<T> value,
          $Res Function(OperationBaseState<T>) then) =
      _$OperationBaseStateCopyWithImpl<T, $Res, OperationBaseState<T>>;
}

/// @nodoc
class _$OperationBaseStateCopyWithImpl<T, $Res,
        $Val extends OperationBaseState<T>>
    implements $OperationBaseStateCopyWith<T, $Res> {
  _$OperationBaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$OperationBaseStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl<T> implements _Loading<T> {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'OperationBaseState<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() loadingMore,
    required TResult Function(BottomSheetMessageModel message) error,
    required TResult Function() connectionError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? loadingMore,
    TResult? Function(BottomSheetMessageModel message)? error,
    TResult? Function()? connectionError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? loadingMore,
    TResult Function(BottomSheetMessageModel message)? error,
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
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_LoadingMore<T> value) loadingMore,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_ConnectionError<T> value) connectionError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_LoadingMore<T> value)? loadingMore,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_ConnectionError<T> value)? connectionError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_LoadingMore<T> value)? loadingMore,
    TResult Function(_Error<T> value)? error,
    TResult Function(_ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<T> implements OperationBaseState<T> {
  const factory _Loading() = _$LoadingImpl<T>;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<T, $Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl<T> value, $Res Function(_$LoadedImpl<T>) then) =
      __$$LoadedImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<T, $Res>
    extends _$OperationBaseStateCopyWithImpl<T, $Res, _$LoadedImpl<T>>
    implements _$$LoadedImplCopyWith<T, $Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl<T> _value, $Res Function(_$LoadedImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadedImpl<T> implements _Loaded<T> {
  const _$LoadedImpl();

  @override
  String toString() {
    return 'OperationBaseState<$T>.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadedImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() loadingMore,
    required TResult Function(BottomSheetMessageModel message) error,
    required TResult Function() connectionError,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? loadingMore,
    TResult? Function(BottomSheetMessageModel message)? error,
    TResult? Function()? connectionError,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? loadingMore,
    TResult Function(BottomSheetMessageModel message)? error,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_LoadingMore<T> value) loadingMore,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_ConnectionError<T> value) connectionError,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_LoadingMore<T> value)? loadingMore,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_ConnectionError<T> value)? connectionError,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_LoadingMore<T> value)? loadingMore,
    TResult Function(_Error<T> value)? error,
    TResult Function(_ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded<T> implements OperationBaseState<T> {
  const factory _Loaded() = _$LoadedImpl<T>;
}

/// @nodoc
abstract class _$$LoadingMoreImplCopyWith<T, $Res> {
  factory _$$LoadingMoreImplCopyWith(_$LoadingMoreImpl<T> value,
          $Res Function(_$LoadingMoreImpl<T>) then) =
      __$$LoadingMoreImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingMoreImplCopyWithImpl<T, $Res>
    extends _$OperationBaseStateCopyWithImpl<T, $Res, _$LoadingMoreImpl<T>>
    implements _$$LoadingMoreImplCopyWith<T, $Res> {
  __$$LoadingMoreImplCopyWithImpl(
      _$LoadingMoreImpl<T> _value, $Res Function(_$LoadingMoreImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingMoreImpl<T> implements _LoadingMore<T> {
  const _$LoadingMoreImpl();

  @override
  String toString() {
    return 'OperationBaseState<$T>.loadingMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingMoreImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() loadingMore,
    required TResult Function(BottomSheetMessageModel message) error,
    required TResult Function() connectionError,
  }) {
    return loadingMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? loadingMore,
    TResult? Function(BottomSheetMessageModel message)? error,
    TResult? Function()? connectionError,
  }) {
    return loadingMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? loadingMore,
    TResult Function(BottomSheetMessageModel message)? error,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_LoadingMore<T> value) loadingMore,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_ConnectionError<T> value) connectionError,
  }) {
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_LoadingMore<T> value)? loadingMore,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_ConnectionError<T> value)? connectionError,
  }) {
    return loadingMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_LoadingMore<T> value)? loadingMore,
    TResult Function(_Error<T> value)? error,
    TResult Function(_ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class _LoadingMore<T> implements OperationBaseState<T> {
  const factory _LoadingMore() = _$LoadingMoreImpl<T>;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({BottomSheetMessageModel message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$OperationBaseStateCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl<T>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as BottomSheetMessageModel,
    ));
  }
}

/// @nodoc

class _$ErrorImpl<T> implements _Error<T> {
  const _$ErrorImpl(this.message);

  @override
  final BottomSheetMessageModel message;

  @override
  String toString() {
    return 'OperationBaseState<$T>.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() loadingMore,
    required TResult Function(BottomSheetMessageModel message) error,
    required TResult Function() connectionError,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? loadingMore,
    TResult? Function(BottomSheetMessageModel message)? error,
    TResult? Function()? connectionError,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? loadingMore,
    TResult Function(BottomSheetMessageModel message)? error,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_LoadingMore<T> value) loadingMore,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_ConnectionError<T> value) connectionError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_LoadingMore<T> value)? loadingMore,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_ConnectionError<T> value)? connectionError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_LoadingMore<T> value)? loadingMore,
    TResult Function(_Error<T> value)? error,
    TResult Function(_ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<T> implements OperationBaseState<T> {
  const factory _Error(final BottomSheetMessageModel message) = _$ErrorImpl<T>;

  BottomSheetMessageModel get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionErrorImplCopyWith<T, $Res> {
  factory _$$ConnectionErrorImplCopyWith(_$ConnectionErrorImpl<T> value,
          $Res Function(_$ConnectionErrorImpl<T>) then) =
      __$$ConnectionErrorImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ConnectionErrorImplCopyWithImpl<T, $Res>
    extends _$OperationBaseStateCopyWithImpl<T, $Res, _$ConnectionErrorImpl<T>>
    implements _$$ConnectionErrorImplCopyWith<T, $Res> {
  __$$ConnectionErrorImplCopyWithImpl(_$ConnectionErrorImpl<T> _value,
      $Res Function(_$ConnectionErrorImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ConnectionErrorImpl<T> implements _ConnectionError<T> {
  const _$ConnectionErrorImpl();

  @override
  String toString() {
    return 'OperationBaseState<$T>.connectionError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectionErrorImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() loadingMore,
    required TResult Function(BottomSheetMessageModel message) error,
    required TResult Function() connectionError,
  }) {
    return connectionError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? loadingMore,
    TResult? Function(BottomSheetMessageModel message)? error,
    TResult? Function()? connectionError,
  }) {
    return connectionError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? loadingMore,
    TResult Function(BottomSheetMessageModel message)? error,
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
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Loaded<T> value) loaded,
    required TResult Function(_LoadingMore<T> value) loadingMore,
    required TResult Function(_Error<T> value) error,
    required TResult Function(_ConnectionError<T> value) connectionError,
  }) {
    return connectionError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Loaded<T> value)? loaded,
    TResult? Function(_LoadingMore<T> value)? loadingMore,
    TResult? Function(_Error<T> value)? error,
    TResult? Function(_ConnectionError<T> value)? connectionError,
  }) {
    return connectionError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Loaded<T> value)? loaded,
    TResult Function(_LoadingMore<T> value)? loadingMore,
    TResult Function(_Error<T> value)? error,
    TResult Function(_ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (connectionError != null) {
      return connectionError(this);
    }
    return orElse();
  }
}

abstract class _ConnectionError<T> implements OperationBaseState<T> {
  const factory _ConnectionError() = _$ConnectionErrorImpl<T>;
}
