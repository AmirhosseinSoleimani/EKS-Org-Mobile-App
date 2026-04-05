// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data, List<String>? failures, int? resultCode)
        success,
    required TResult Function(NetworkExceptions? error, String? failures)
        failure,
    required TResult Function() expireToken,
    required TResult Function() connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data, List<String>? failures, int? resultCode)? success,
    TResult? Function(NetworkExceptions? error, String? failures)? failure,
    TResult? Function()? expireToken,
    TResult? Function()? connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data, List<String>? failures, int? resultCode)? success,
    TResult Function(NetworkExceptions? error, String? failures)? failure,
    TResult Function()? expireToken,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
    required TResult Function(ExpireToken<T> value) expireToken,
    required TResult Function(ConnectionError<T> value) connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<T> value)? success,
    TResult? Function(Failure<T> value)? failure,
    TResult? Function(ExpireToken<T> value)? expireToken,
    TResult? Function(ConnectionError<T> value)? connectionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    TResult Function(ExpireToken<T> value)? expireToken,
    TResult Function(ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResultCopyWith<T, $Res> {
  factory $ApiResultCopyWith(
          ApiResult<T> value, $Res Function(ApiResult<T>) then) =
      _$ApiResultCopyWithImpl<T, $Res, ApiResult<T>>;
}

/// @nodoc
class _$ApiResultCopyWithImpl<T, $Res, $Val extends ApiResult<T>>
    implements $ApiResultCopyWith<T, $Res> {
  _$ApiResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<T, $Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl<T> value, $Res Function(_$SuccessImpl<T>) then) =
      __$$SuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data, List<String>? failures, int? resultCode});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res, _$SuccessImpl<T>>
    implements _$$SuccessImplCopyWith<T, $Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl<T> _value, $Res Function(_$SuccessImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? failures = freezed,
    Object? resultCode = freezed,
  }) {
    return _then(_$SuccessImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      failures: freezed == failures
          ? _value._failures
          : failures // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      resultCode: freezed == resultCode
          ? _value.resultCode
          : resultCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl<T> implements Success<T> {
  const _$SuccessImpl(
      {required this.data, final List<String>? failures, this.resultCode})
      : _failures = failures;

  @override
  final T data;
  final List<String>? _failures;
  @override
  List<String>? get failures {
    final value = _failures;
    if (value == null) return null;
    if (_failures is EqualUnmodifiableListView) return _failures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? resultCode;

  @override
  String toString() {
    return 'ApiResult<$T>.success(data: $data, failures: $failures, resultCode: $resultCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other._failures, _failures) &&
            (identical(other.resultCode, resultCode) ||
                other.resultCode == resultCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(_failures),
      resultCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      __$$SuccessImplCopyWithImpl<T, _$SuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data, List<String>? failures, int? resultCode)
        success,
    required TResult Function(NetworkExceptions? error, String? failures)
        failure,
    required TResult Function() expireToken,
    required TResult Function() connectionError,
  }) {
    return success(data, failures, resultCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data, List<String>? failures, int? resultCode)? success,
    TResult? Function(NetworkExceptions? error, String? failures)? failure,
    TResult? Function()? expireToken,
    TResult? Function()? connectionError,
  }) {
    return success?.call(data, failures, resultCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data, List<String>? failures, int? resultCode)? success,
    TResult Function(NetworkExceptions? error, String? failures)? failure,
    TResult Function()? expireToken,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, failures, resultCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
    required TResult Function(ExpireToken<T> value) expireToken,
    required TResult Function(ConnectionError<T> value) connectionError,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<T> value)? success,
    TResult? Function(Failure<T> value)? failure,
    TResult? Function(ExpireToken<T> value)? expireToken,
    TResult? Function(ConnectionError<T> value)? connectionError,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    TResult Function(ExpireToken<T> value)? expireToken,
    TResult Function(ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success<T> implements ApiResult<T> {
  const factory Success(
      {required final T data,
      final List<String>? failures,
      final int? resultCode}) = _$SuccessImpl<T>;

  T get data;
  List<String>? get failures;
  int? get resultCode;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<T, $Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl<T> value, $Res Function(_$FailureImpl<T>) then) =
      __$$FailureImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({NetworkExceptions? error, String? failures});

  $NetworkExceptionsCopyWith<$Res>? get error;
}

/// @nodoc
class __$$FailureImplCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res, _$FailureImpl<T>>
    implements _$$FailureImplCopyWith<T, $Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl<T> _value, $Res Function(_$FailureImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? failures = freezed,
  }) {
    return _then(_$FailureImpl<T>(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as NetworkExceptions?,
      failures: freezed == failures
          ? _value.failures
          : failures // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NetworkExceptionsCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $NetworkExceptionsCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$FailureImpl<T> implements Failure<T> {
  const _$FailureImpl({this.error, this.failures});

  @override
  final NetworkExceptions? error;
  @override
  final String? failures;

  @override
  String toString() {
    return 'ApiResult<$T>.failure(error: $error, failures: $failures)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl<T> &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.failures, failures) ||
                other.failures == failures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, failures);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<T, _$FailureImpl<T>> get copyWith =>
      __$$FailureImplCopyWithImpl<T, _$FailureImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data, List<String>? failures, int? resultCode)
        success,
    required TResult Function(NetworkExceptions? error, String? failures)
        failure,
    required TResult Function() expireToken,
    required TResult Function() connectionError,
  }) {
    return failure(error, failures);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data, List<String>? failures, int? resultCode)? success,
    TResult? Function(NetworkExceptions? error, String? failures)? failure,
    TResult? Function()? expireToken,
    TResult? Function()? connectionError,
  }) {
    return failure?.call(error, failures);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data, List<String>? failures, int? resultCode)? success,
    TResult Function(NetworkExceptions? error, String? failures)? failure,
    TResult Function()? expireToken,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error, failures);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
    required TResult Function(ExpireToken<T> value) expireToken,
    required TResult Function(ConnectionError<T> value) connectionError,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<T> value)? success,
    TResult? Function(Failure<T> value)? failure,
    TResult? Function(ExpireToken<T> value)? expireToken,
    TResult? Function(ConnectionError<T> value)? connectionError,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    TResult Function(ExpireToken<T> value)? expireToken,
    TResult Function(ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class Failure<T> implements ApiResult<T> {
  const factory Failure(
      {final NetworkExceptions? error,
      final String? failures}) = _$FailureImpl<T>;

  NetworkExceptions? get error;
  String? get failures;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<T, _$FailureImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExpireTokenImplCopyWith<T, $Res> {
  factory _$$ExpireTokenImplCopyWith(_$ExpireTokenImpl<T> value,
          $Res Function(_$ExpireTokenImpl<T>) then) =
      __$$ExpireTokenImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ExpireTokenImplCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res, _$ExpireTokenImpl<T>>
    implements _$$ExpireTokenImplCopyWith<T, $Res> {
  __$$ExpireTokenImplCopyWithImpl(
      _$ExpireTokenImpl<T> _value, $Res Function(_$ExpireTokenImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ExpireTokenImpl<T> implements ExpireToken<T> {
  const _$ExpireTokenImpl();

  @override
  String toString() {
    return 'ApiResult<$T>.expireToken()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExpireTokenImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data, List<String>? failures, int? resultCode)
        success,
    required TResult Function(NetworkExceptions? error, String? failures)
        failure,
    required TResult Function() expireToken,
    required TResult Function() connectionError,
  }) {
    return expireToken();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data, List<String>? failures, int? resultCode)? success,
    TResult? Function(NetworkExceptions? error, String? failures)? failure,
    TResult? Function()? expireToken,
    TResult? Function()? connectionError,
  }) {
    return expireToken?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data, List<String>? failures, int? resultCode)? success,
    TResult Function(NetworkExceptions? error, String? failures)? failure,
    TResult Function()? expireToken,
    TResult Function()? connectionError,
    required TResult orElse(),
  }) {
    if (expireToken != null) {
      return expireToken();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
    required TResult Function(ExpireToken<T> value) expireToken,
    required TResult Function(ConnectionError<T> value) connectionError,
  }) {
    return expireToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<T> value)? success,
    TResult? Function(Failure<T> value)? failure,
    TResult? Function(ExpireToken<T> value)? expireToken,
    TResult? Function(ConnectionError<T> value)? connectionError,
  }) {
    return expireToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    TResult Function(ExpireToken<T> value)? expireToken,
    TResult Function(ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (expireToken != null) {
      return expireToken(this);
    }
    return orElse();
  }
}

abstract class ExpireToken<T> implements ApiResult<T> {
  const factory ExpireToken() = _$ExpireTokenImpl<T>;
}

/// @nodoc
abstract class _$$ConnectionErrorImplCopyWith<T, $Res> {
  factory _$$ConnectionErrorImplCopyWith(_$ConnectionErrorImpl<T> value,
          $Res Function(_$ConnectionErrorImpl<T>) then) =
      __$$ConnectionErrorImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ConnectionErrorImplCopyWithImpl<T, $Res>
    extends _$ApiResultCopyWithImpl<T, $Res, _$ConnectionErrorImpl<T>>
    implements _$$ConnectionErrorImplCopyWith<T, $Res> {
  __$$ConnectionErrorImplCopyWithImpl(_$ConnectionErrorImpl<T> _value,
      $Res Function(_$ConnectionErrorImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ConnectionErrorImpl<T> implements ConnectionError<T> {
  const _$ConnectionErrorImpl();

  @override
  String toString() {
    return 'ApiResult<$T>.connectionError()';
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
    required TResult Function(T data, List<String>? failures, int? resultCode)
        success,
    required TResult Function(NetworkExceptions? error, String? failures)
        failure,
    required TResult Function() expireToken,
    required TResult Function() connectionError,
  }) {
    return connectionError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data, List<String>? failures, int? resultCode)? success,
    TResult? Function(NetworkExceptions? error, String? failures)? failure,
    TResult? Function()? expireToken,
    TResult? Function()? connectionError,
  }) {
    return connectionError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data, List<String>? failures, int? resultCode)? success,
    TResult Function(NetworkExceptions? error, String? failures)? failure,
    TResult Function()? expireToken,
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
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
    required TResult Function(ExpireToken<T> value) expireToken,
    required TResult Function(ConnectionError<T> value) connectionError,
  }) {
    return connectionError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Success<T> value)? success,
    TResult? Function(Failure<T> value)? failure,
    TResult? Function(ExpireToken<T> value)? expireToken,
    TResult? Function(ConnectionError<T> value)? connectionError,
  }) {
    return connectionError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    TResult Function(ExpireToken<T> value)? expireToken,
    TResult Function(ConnectionError<T> value)? connectionError,
    required TResult orElse(),
  }) {
    if (connectionError != null) {
      return connectionError(this);
    }
    return orElse();
  }
}

abstract class ConnectionError<T> implements ApiResult<T> {
  const factory ConnectionError() = _$ConnectionErrorImpl<T>;
}
