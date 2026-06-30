// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_home_service_request_time_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangeHomeServiceRequestTimeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeHomeServiceRequestTimeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState()';
}


}

/// @nodoc
class $ChangeHomeServiceRequestTimeStateCopyWith<$Res>  {
$ChangeHomeServiceRequestTimeStateCopyWith(ChangeHomeServiceRequestTimeState _, $Res Function(ChangeHomeServiceRequestTimeState) __);
}


/// Adds pattern-matching-related methods to [ChangeHomeServiceRequestTimeState].
extension ChangeHomeServiceRequestTimeStatePatterns on ChangeHomeServiceRequestTimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _DaySelected value)?  daySelected,TResult Function( _TimeSelected value)?  timeSelected,TResult Function( _ConnectionError value)?  connectionError,TResult Function( _SubmitLoading value)?  submitLoading,TResult Function( _SubmitSuccess value)?  submitSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _DaySelected() when daySelected != null:
return daySelected(_that);case _TimeSelected() when timeSelected != null:
return timeSelected(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _DaySelected value)  daySelected,required TResult Function( _TimeSelected value)  timeSelected,required TResult Function( _ConnectionError value)  connectionError,required TResult Function( _SubmitLoading value)  submitLoading,required TResult Function( _SubmitSuccess value)  submitSuccess,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _DaySelected():
return daySelected(_that);case _TimeSelected():
return timeSelected(_that);case _ConnectionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _DaySelected value)?  daySelected,TResult? Function( _TimeSelected value)?  timeSelected,TResult? Function( _ConnectionError value)?  connectionError,TResult? Function( _SubmitLoading value)?  submitLoading,TResult? Function( _SubmitSuccess value)?  submitSuccess,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _DaySelected() when daySelected != null:
return daySelected(_that);case _TimeSelected() when timeSelected != null:
return timeSelected(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function()?  loaded,TResult Function( BottomSheetMessageModel message)?  error,TResult Function( DayScheduleEntity day)?  daySelected,TResult Function( TimeRangeEntity time)?  timeSelected,TResult Function()?  connectionError,TResult Function()?  submitLoading,TResult Function( BottomSheetMessageModel message)?  submitSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _Error() when error != null:
return error(_that.message);case _DaySelected() when daySelected != null:
return daySelected(_that.day);case _TimeSelected() when timeSelected != null:
return timeSelected(_that.time);case _ConnectionError() when connectionError != null:
return connectionError();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function( BottomSheetMessageModel message)  error,required TResult Function( DayScheduleEntity day)  daySelected,required TResult Function( TimeRangeEntity time)  timeSelected,required TResult Function()  connectionError,required TResult Function()  submitLoading,required TResult Function( BottomSheetMessageModel message)  submitSuccess,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Loading():
return loading();case _Loaded():
return loaded();case _Error():
return error(_that.message);case _DaySelected():
return daySelected(_that.day);case _TimeSelected():
return timeSelected(_that.time);case _ConnectionError():
return connectionError();case _SubmitLoading():
return submitLoading();case _SubmitSuccess():
return submitSuccess(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function( BottomSheetMessageModel message)?  error,TResult? Function( DayScheduleEntity day)?  daySelected,TResult? Function( TimeRangeEntity time)?  timeSelected,TResult? Function()?  connectionError,TResult? Function()?  submitLoading,TResult? Function( BottomSheetMessageModel message)?  submitSuccess,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _Error() when error != null:
return error(_that.message);case _DaySelected() when daySelected != null:
return daySelected(_that.day);case _TimeSelected() when timeSelected != null:
return timeSelected(_that.time);case _ConnectionError() when connectionError != null:
return connectionError();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements ChangeHomeServiceRequestTimeState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState.idle()';
}


}




/// @nodoc


class _Loading implements ChangeHomeServiceRequestTimeState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState.loading()';
}


}




/// @nodoc


class _Loaded implements ChangeHomeServiceRequestTimeState {
  const _Loaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState.loaded()';
}


}




/// @nodoc


class _Error implements ChangeHomeServiceRequestTimeState {
  const _Error({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of ChangeHomeServiceRequestTimeState
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
  return 'ChangeHomeServiceRequestTimeState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ChangeHomeServiceRequestTimeStateCopyWith<$Res> {
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

/// Create a copy of ChangeHomeServiceRequestTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _DaySelected implements ChangeHomeServiceRequestTimeState {
  const _DaySelected({required this.day});
  

 final  DayScheduleEntity day;

/// Create a copy of ChangeHomeServiceRequestTimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DaySelectedCopyWith<_DaySelected> get copyWith => __$DaySelectedCopyWithImpl<_DaySelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DaySelected&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,day);

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState.daySelected(day: $day)';
}


}

/// @nodoc
abstract mixin class _$DaySelectedCopyWith<$Res> implements $ChangeHomeServiceRequestTimeStateCopyWith<$Res> {
  factory _$DaySelectedCopyWith(_DaySelected value, $Res Function(_DaySelected) _then) = __$DaySelectedCopyWithImpl;
@useResult
$Res call({
 DayScheduleEntity day
});




}
/// @nodoc
class __$DaySelectedCopyWithImpl<$Res>
    implements _$DaySelectedCopyWith<$Res> {
  __$DaySelectedCopyWithImpl(this._self, this._then);

  final _DaySelected _self;
  final $Res Function(_DaySelected) _then;

/// Create a copy of ChangeHomeServiceRequestTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? day = null,}) {
  return _then(_DaySelected(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as DayScheduleEntity,
  ));
}


}

/// @nodoc


class _TimeSelected implements ChangeHomeServiceRequestTimeState {
  const _TimeSelected({required this.time});
  

 final  TimeRangeEntity time;

/// Create a copy of ChangeHomeServiceRequestTimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeSelectedCopyWith<_TimeSelected> get copyWith => __$TimeSelectedCopyWithImpl<_TimeSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeSelected&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode => Object.hash(runtimeType,time);

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState.timeSelected(time: $time)';
}


}

/// @nodoc
abstract mixin class _$TimeSelectedCopyWith<$Res> implements $ChangeHomeServiceRequestTimeStateCopyWith<$Res> {
  factory _$TimeSelectedCopyWith(_TimeSelected value, $Res Function(_TimeSelected) _then) = __$TimeSelectedCopyWithImpl;
@useResult
$Res call({
 TimeRangeEntity time
});




}
/// @nodoc
class __$TimeSelectedCopyWithImpl<$Res>
    implements _$TimeSelectedCopyWith<$Res> {
  __$TimeSelectedCopyWithImpl(this._self, this._then);

  final _TimeSelected _self;
  final $Res Function(_TimeSelected) _then;

/// Create a copy of ChangeHomeServiceRequestTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? time = null,}) {
  return _then(_TimeSelected(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as TimeRangeEntity,
  ));
}


}

/// @nodoc


class _ConnectionError implements ChangeHomeServiceRequestTimeState {
  const _ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState.connectionError()';
}


}




/// @nodoc


class _SubmitLoading implements ChangeHomeServiceRequestTimeState {
  const _SubmitLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState.submitLoading()';
}


}




/// @nodoc


class _SubmitSuccess implements ChangeHomeServiceRequestTimeState {
  const _SubmitSuccess({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of ChangeHomeServiceRequestTimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitSuccessCopyWith<_SubmitSuccess> get copyWith => __$SubmitSuccessCopyWithImpl<_SubmitSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChangeHomeServiceRequestTimeState.submitSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SubmitSuccessCopyWith<$Res> implements $ChangeHomeServiceRequestTimeStateCopyWith<$Res> {
  factory _$SubmitSuccessCopyWith(_SubmitSuccess value, $Res Function(_SubmitSuccess) _then) = __$SubmitSuccessCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel message
});




}
/// @nodoc
class __$SubmitSuccessCopyWithImpl<$Res>
    implements _$SubmitSuccessCopyWith<$Res> {
  __$SubmitSuccessCopyWithImpl(this._self, this._then);

  final _SubmitSuccess _self;
  final $Res Function(_SubmitSuccess) _then;

/// Create a copy of ChangeHomeServiceRequestTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SubmitSuccess(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

// dart format on
