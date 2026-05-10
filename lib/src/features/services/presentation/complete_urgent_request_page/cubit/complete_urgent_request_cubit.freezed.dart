// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_urgent_request_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompleteUrgentRequestState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteUrgentRequestState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteUrgentRequestState()';
}


}

/// @nodoc
class $CompleteUrgentRequestStateCopyWith<$Res>  {
$CompleteUrgentRequestStateCopyWith(CompleteUrgentRequestState _, $Res Function(CompleteUrgentRequestState) __);
}


/// Adds pattern-matching-related methods to [CompleteUrgentRequestState].
extension CompleteUrgentRequestStatePatterns on CompleteUrgentRequestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _ConnectionError value)?  connectionError,TResult Function( _SubmitLoading value)?  submitLoading,TResult Function( _SubmitSuccess value)?  submitSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _ConnectionError value)  connectionError,required TResult Function( _SubmitLoading value)  submitLoading,required TResult Function( _SubmitSuccess value)  submitSuccess,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _ConnectionError():
return connectionError(_that);case _SubmitLoading():
return submitLoading(_that);case _SubmitSuccess():
return submitSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _ConnectionError value)?  connectionError,TResult? Function( _SubmitLoading value)?  submitLoading,TResult? Function( _SubmitSuccess value)?  submitSuccess,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function()?  loaded,TResult Function( BottomSheetMessageModel message)?  error,TResult Function()?  connectionError,TResult Function()?  submitLoading,TResult Function( CompleteUrgentRequestDataEntity data)?  submitSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _Error() when error != null:
return error(_that.message);case _ConnectionError() when connectionError != null:
return connectionError();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function( BottomSheetMessageModel message)  error,required TResult Function()  connectionError,required TResult Function()  submitLoading,required TResult Function( CompleteUrgentRequestDataEntity data)  submitSuccess,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Loading():
return loading();case _Loaded():
return loaded();case _Error():
return error(_that.message);case _ConnectionError():
return connectionError();case _SubmitLoading():
return submitLoading();case _SubmitSuccess():
return submitSuccess(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function( BottomSheetMessageModel message)?  error,TResult? Function()?  connectionError,TResult? Function()?  submitLoading,TResult? Function( CompleteUrgentRequestDataEntity data)?  submitSuccess,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _Error() when error != null:
return error(_that.message);case _ConnectionError() when connectionError != null:
return connectionError();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements CompleteUrgentRequestState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteUrgentRequestState.idle()';
}


}




/// @nodoc


class _Loading implements CompleteUrgentRequestState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteUrgentRequestState.loading()';
}


}




/// @nodoc


class _Loaded implements CompleteUrgentRequestState {
  const _Loaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteUrgentRequestState.loaded()';
}


}




/// @nodoc


class _Error implements CompleteUrgentRequestState {
  const _Error({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of CompleteUrgentRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CompleteUrgentRequestState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CompleteUrgentRequestStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of CompleteUrgentRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _ConnectionError implements CompleteUrgentRequestState {
  const _ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteUrgentRequestState.connectionError()';
}


}




/// @nodoc


class _SubmitLoading implements CompleteUrgentRequestState {
  const _SubmitLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteUrgentRequestState.submitLoading()';
}


}




/// @nodoc


class _SubmitSuccess implements CompleteUrgentRequestState {
  const _SubmitSuccess({required this.data});
  

 final  CompleteUrgentRequestDataEntity data;

/// Create a copy of CompleteUrgentRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitSuccessCopyWith<_SubmitSuccess> get copyWith => __$SubmitSuccessCopyWithImpl<_SubmitSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'CompleteUrgentRequestState.submitSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class _$SubmitSuccessCopyWith<$Res> implements $CompleteUrgentRequestStateCopyWith<$Res> {
  factory _$SubmitSuccessCopyWith(_SubmitSuccess value, $Res Function(_SubmitSuccess) _then) = __$SubmitSuccessCopyWithImpl;
@useResult
$Res call({
 CompleteUrgentRequestDataEntity data
});




}
/// @nodoc
class __$SubmitSuccessCopyWithImpl<$Res>
    implements _$SubmitSuccessCopyWith<$Res> {
  __$SubmitSuccessCopyWithImpl(this._self, this._then);

  final _SubmitSuccess _self;
  final $Res Function(_SubmitSuccess) _then;

/// Create a copy of CompleteUrgentRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_SubmitSuccess(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CompleteUrgentRequestDataEntity,
  ));
}


}

// dart format on
