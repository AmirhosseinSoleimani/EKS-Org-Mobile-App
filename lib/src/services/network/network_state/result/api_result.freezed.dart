// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiResult<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResult<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiResult<$T>()';
}


}

/// @nodoc
class $ApiResultCopyWith<T,$Res>  {
$ApiResultCopyWith(ApiResult<T> _, $Res Function(ApiResult<T>) __);
}


/// Adds pattern-matching-related methods to [ApiResult].
extension ApiResultPatterns<T> on ApiResult<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Success<T> value)?  success,TResult Function( Failure<T> value)?  failure,TResult Function( ExpireToken<T> value)?  expireToken,TResult Function( ConnectionError<T> value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case ExpireToken() when expireToken != null:
return expireToken(_that);case ConnectionError() when connectionError != null:
return connectionError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Success<T> value)  success,required TResult Function( Failure<T> value)  failure,required TResult Function( ExpireToken<T> value)  expireToken,required TResult Function( ConnectionError<T> value)  connectionError,}){
final _that = this;
switch (_that) {
case Success():
return success(_that);case Failure():
return failure(_that);case ExpireToken():
return expireToken(_that);case ConnectionError():
return connectionError(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Success<T> value)?  success,TResult? Function( Failure<T> value)?  failure,TResult? Function( ExpireToken<T> value)?  expireToken,TResult? Function( ConnectionError<T> value)?  connectionError,}){
final _that = this;
switch (_that) {
case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case ExpireToken() when expireToken != null:
return expireToken(_that);case ConnectionError() when connectionError != null:
return connectionError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T data,  List<String>? failures,  int? resultCode)?  success,TResult Function( NetworkExceptions? error,  String? failures)?  failure,TResult Function()?  expireToken,TResult Function()?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Success() when success != null:
return success(_that.data,_that.failures,_that.resultCode);case Failure() when failure != null:
return failure(_that.error,_that.failures);case ExpireToken() when expireToken != null:
return expireToken();case ConnectionError() when connectionError != null:
return connectionError();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T data,  List<String>? failures,  int? resultCode)  success,required TResult Function( NetworkExceptions? error,  String? failures)  failure,required TResult Function()  expireToken,required TResult Function()  connectionError,}) {final _that = this;
switch (_that) {
case Success():
return success(_that.data,_that.failures,_that.resultCode);case Failure():
return failure(_that.error,_that.failures);case ExpireToken():
return expireToken();case ConnectionError():
return connectionError();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T data,  List<String>? failures,  int? resultCode)?  success,TResult? Function( NetworkExceptions? error,  String? failures)?  failure,TResult? Function()?  expireToken,TResult? Function()?  connectionError,}) {final _that = this;
switch (_that) {
case Success() when success != null:
return success(_that.data,_that.failures,_that.resultCode);case Failure() when failure != null:
return failure(_that.error,_that.failures);case ExpireToken() when expireToken != null:
return expireToken();case ConnectionError() when connectionError != null:
return connectionError();case _:
  return null;

}
}

}

/// @nodoc


class Success<T> implements ApiResult<T> {
  const Success({required this.data, final  List<String>? failures, this.resultCode}): _failures = failures;
  

 final  T data;
 final  List<String>? _failures;
 List<String>? get failures {
  final value = _failures;
  if (value == null) return null;
  if (_failures is EqualUnmodifiableListView) return _failures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  int? resultCode;

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<T, Success<T>> get copyWith => _$SuccessCopyWithImpl<T, Success<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success<T>&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other._failures, _failures)&&(identical(other.resultCode, resultCode) || other.resultCode == resultCode));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(_failures),resultCode);

@override
String toString() {
  return 'ApiResult<$T>.success(data: $data, failures: $failures, resultCode: $resultCode)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<T,$Res> implements $ApiResultCopyWith<T, $Res> {
  factory $SuccessCopyWith(Success<T> value, $Res Function(Success<T>) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 T data, List<String>? failures, int? resultCode
});




}
/// @nodoc
class _$SuccessCopyWithImpl<T,$Res>
    implements $SuccessCopyWith<T, $Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success<T> _self;
  final $Res Function(Success<T>) _then;

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? failures = freezed,Object? resultCode = freezed,}) {
  return _then(Success<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,failures: freezed == failures ? _self._failures : failures // ignore: cast_nullable_to_non_nullable
as List<String>?,resultCode: freezed == resultCode ? _self.resultCode : resultCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class Failure<T> implements ApiResult<T> {
  const Failure({this.error, this.failures});
  

 final  NetworkExceptions? error;
 final  String? failures;

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<T, Failure<T>> get copyWith => _$FailureCopyWithImpl<T, Failure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure<T>&&(identical(other.error, error) || other.error == error)&&(identical(other.failures, failures) || other.failures == failures));
}


@override
int get hashCode => Object.hash(runtimeType,error,failures);

@override
String toString() {
  return 'ApiResult<$T>.failure(error: $error, failures: $failures)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<T,$Res> implements $ApiResultCopyWith<T, $Res> {
  factory $FailureCopyWith(Failure<T> value, $Res Function(Failure<T>) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 NetworkExceptions? error, String? failures
});


$NetworkExceptionsCopyWith<$Res>? get error;

}
/// @nodoc
class _$FailureCopyWithImpl<T,$Res>
    implements $FailureCopyWith<T, $Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure<T> _self;
  final $Res Function(Failure<T>) _then;

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,Object? failures = freezed,}) {
  return _then(Failure<T>(
error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,failures: freezed == failures ? _self.failures : failures // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionsCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $NetworkExceptionsCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

/// @nodoc


class ExpireToken<T> implements ApiResult<T> {
  const ExpireToken();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpireToken<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiResult<$T>.expireToken()';
}


}




/// @nodoc


class ConnectionError<T> implements ApiResult<T> {
  const ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionError<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiResult<$T>.connectionError()';
}


}




// dart format on
