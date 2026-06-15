// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_service_evaluation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeServiceEvaluationState {

 HomeServiceEvaluationData get data;
/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeServiceEvaluationStateCopyWith<HomeServiceEvaluationState> get copyWith => _$HomeServiceEvaluationStateCopyWithImpl<HomeServiceEvaluationState>(this as HomeServiceEvaluationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'HomeServiceEvaluationState(data: $data)';
}


}

/// @nodoc
abstract mixin class $HomeServiceEvaluationStateCopyWith<$Res>  {
  factory $HomeServiceEvaluationStateCopyWith(HomeServiceEvaluationState value, $Res Function(HomeServiceEvaluationState) _then) = _$HomeServiceEvaluationStateCopyWithImpl;
@useResult
$Res call({
 HomeServiceEvaluationData data
});




}
/// @nodoc
class _$HomeServiceEvaluationStateCopyWithImpl<$Res>
    implements $HomeServiceEvaluationStateCopyWith<$Res> {
  _$HomeServiceEvaluationStateCopyWithImpl(this._self, this._then);

  final HomeServiceEvaluationState _self;
  final $Res Function(HomeServiceEvaluationState) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeServiceEvaluationState].
extension HomeServiceEvaluationStatePatterns on HomeServiceEvaluationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Failure value)?  failure,TResult Function( _ConnectionError value)?  connectionError,TResult Function( _SubmitLoading value)?  submitLoading,TResult Function( _SubmitSuccess value)?  submitSuccess,TResult Function( _SubmitFailure value)?  submitFailure,TResult Function( _SheetLoading value)?  sheetLoading,TResult Function( _SheetLoaded value)?  sheetLoaded,TResult Function( _SheetFailure value)?  sheetFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _SubmitFailure() when submitFailure != null:
return submitFailure(_that);case _SheetLoading() when sheetLoading != null:
return sheetLoading(_that);case _SheetLoaded() when sheetLoaded != null:
return sheetLoaded(_that);case _SheetFailure() when sheetFailure != null:
return sheetFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Failure value)  failure,required TResult Function( _ConnectionError value)  connectionError,required TResult Function( _SubmitLoading value)  submitLoading,required TResult Function( _SubmitSuccess value)  submitSuccess,required TResult Function( _SubmitFailure value)  submitFailure,required TResult Function( _SheetLoading value)  sheetLoading,required TResult Function( _SheetLoaded value)  sheetLoaded,required TResult Function( _SheetFailure value)  sheetFailure,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Failure():
return failure(_that);case _ConnectionError():
return connectionError(_that);case _SubmitLoading():
return submitLoading(_that);case _SubmitSuccess():
return submitSuccess(_that);case _SubmitFailure():
return submitFailure(_that);case _SheetLoading():
return sheetLoading(_that);case _SheetLoaded():
return sheetLoaded(_that);case _SheetFailure():
return sheetFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Failure value)?  failure,TResult? Function( _ConnectionError value)?  connectionError,TResult? Function( _SubmitLoading value)?  submitLoading,TResult? Function( _SubmitSuccess value)?  submitSuccess,TResult? Function( _SubmitFailure value)?  submitFailure,TResult? Function( _SheetLoading value)?  sheetLoading,TResult? Function( _SheetLoaded value)?  sheetLoaded,TResult? Function( _SheetFailure value)?  sheetFailure,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _SubmitFailure() when submitFailure != null:
return submitFailure(_that);case _SheetLoading() when sheetLoading != null:
return sheetLoading(_that);case _SheetLoaded() when sheetLoaded != null:
return sheetLoaded(_that);case _SheetFailure() when sheetFailure != null:
return sheetFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( HomeServiceEvaluationData data)?  idle,TResult Function( HomeServiceEvaluationData data)?  loading,TResult Function( HomeServiceEvaluationData data)?  loaded,TResult Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)?  failure,TResult Function( HomeServiceEvaluationData data)?  connectionError,TResult Function( HomeServiceEvaluationData data)?  submitLoading,TResult Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)?  submitSuccess,TResult Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)?  submitFailure,TResult Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType)?  sheetLoading,TResult Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType)?  sheetLoaded,TResult Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType,  BottomSheetMessageModel message)?  sheetFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Failure() when failure != null:
return failure(_that.data,_that.message);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that.data);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.data,_that.message);case _SubmitFailure() when submitFailure != null:
return submitFailure(_that.data,_that.message);case _SheetLoading() when sheetLoading != null:
return sheetLoading(_that.data,_that.sheetType);case _SheetLoaded() when sheetLoaded != null:
return sheetLoaded(_that.data,_that.sheetType);case _SheetFailure() when sheetFailure != null:
return sheetFailure(_that.data,_that.sheetType,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( HomeServiceEvaluationData data)  idle,required TResult Function( HomeServiceEvaluationData data)  loading,required TResult Function( HomeServiceEvaluationData data)  loaded,required TResult Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)  failure,required TResult Function( HomeServiceEvaluationData data)  connectionError,required TResult Function( HomeServiceEvaluationData data)  submitLoading,required TResult Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)  submitSuccess,required TResult Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)  submitFailure,required TResult Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType)  sheetLoading,required TResult Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType)  sheetLoaded,required TResult Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType,  BottomSheetMessageModel message)  sheetFailure,}) {final _that = this;
switch (_that) {
case _Idle():
return idle(_that.data);case _Loading():
return loading(_that.data);case _Loaded():
return loaded(_that.data);case _Failure():
return failure(_that.data,_that.message);case _ConnectionError():
return connectionError(_that.data);case _SubmitLoading():
return submitLoading(_that.data);case _SubmitSuccess():
return submitSuccess(_that.data,_that.message);case _SubmitFailure():
return submitFailure(_that.data,_that.message);case _SheetLoading():
return sheetLoading(_that.data,_that.sheetType);case _SheetLoaded():
return sheetLoaded(_that.data,_that.sheetType);case _SheetFailure():
return sheetFailure(_that.data,_that.sheetType,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( HomeServiceEvaluationData data)?  idle,TResult? Function( HomeServiceEvaluationData data)?  loading,TResult? Function( HomeServiceEvaluationData data)?  loaded,TResult? Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)?  failure,TResult? Function( HomeServiceEvaluationData data)?  connectionError,TResult? Function( HomeServiceEvaluationData data)?  submitLoading,TResult? Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)?  submitSuccess,TResult? Function( HomeServiceEvaluationData data,  BottomSheetMessageModel message)?  submitFailure,TResult? Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType)?  sheetLoading,TResult? Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType)?  sheetLoaded,TResult? Function( HomeServiceEvaluationData data,  HomeServiceEvaluationSheetType sheetType,  BottomSheetMessageModel message)?  sheetFailure,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Failure() when failure != null:
return failure(_that.data,_that.message);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that.data);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.data,_that.message);case _SubmitFailure() when submitFailure != null:
return submitFailure(_that.data,_that.message);case _SheetLoading() when sheetLoading != null:
return sheetLoading(_that.data,_that.sheetType);case _SheetLoaded() when sheetLoaded != null:
return sheetLoaded(_that.data,_that.sheetType);case _SheetFailure() when sheetFailure != null:
return sheetFailure(_that.data,_that.sheetType,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Idle extends HomeServiceEvaluationState {
  const _Idle({this.data = const HomeServiceEvaluationData()}): super._();
  

@override@JsonKey() final  HomeServiceEvaluationData data;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IdleCopyWith<_Idle> get copyWith => __$IdleCopyWithImpl<_Idle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'HomeServiceEvaluationState.idle(data: $data)';
}


}

/// @nodoc
abstract mixin class _$IdleCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$IdleCopyWith(_Idle value, $Res Function(_Idle) _then) = __$IdleCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data
});




}
/// @nodoc
class __$IdleCopyWithImpl<$Res>
    implements _$IdleCopyWith<$Res> {
  __$IdleCopyWithImpl(this._self, this._then);

  final _Idle _self;
  final $Res Function(_Idle) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Idle(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,
  ));
}


}

/// @nodoc


class _Loading extends HomeServiceEvaluationState {
  const _Loading({required this.data}): super._();
  

@override final  HomeServiceEvaluationData data;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'HomeServiceEvaluationState.loading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,
  ));
}


}

/// @nodoc


class _Loaded extends HomeServiceEvaluationState {
  const _Loaded({required this.data}): super._();
  

@override final  HomeServiceEvaluationData data;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'HomeServiceEvaluationState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,
  ));
}


}

/// @nodoc


class _Failure extends HomeServiceEvaluationState {
  const _Failure({required this.data, required this.message}): super._();
  

@override final  HomeServiceEvaluationData data;
 final  BottomSheetMessageModel message;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,data,message);

@override
String toString() {
  return 'HomeServiceEvaluationState.failure(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data, BottomSheetMessageModel message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
  return _then(_Failure(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _ConnectionError extends HomeServiceEvaluationState {
  const _ConnectionError({required this.data}): super._();
  

@override final  HomeServiceEvaluationData data;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionErrorCopyWith<_ConnectionError> get copyWith => __$ConnectionErrorCopyWithImpl<_ConnectionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'HomeServiceEvaluationState.connectionError(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data
});




}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ConnectionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,
  ));
}


}

/// @nodoc


class _SubmitLoading extends HomeServiceEvaluationState {
  const _SubmitLoading({required this.data}): super._();
  

@override final  HomeServiceEvaluationData data;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitLoadingCopyWith<_SubmitLoading> get copyWith => __$SubmitLoadingCopyWithImpl<_SubmitLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitLoading&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'HomeServiceEvaluationState.submitLoading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$SubmitLoadingCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$SubmitLoadingCopyWith(_SubmitLoading value, $Res Function(_SubmitLoading) _then) = __$SubmitLoadingCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data
});




}
/// @nodoc
class __$SubmitLoadingCopyWithImpl<$Res>
    implements _$SubmitLoadingCopyWith<$Res> {
  __$SubmitLoadingCopyWithImpl(this._self, this._then);

  final _SubmitLoading _self;
  final $Res Function(_SubmitLoading) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_SubmitLoading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,
  ));
}


}

/// @nodoc


class _SubmitSuccess extends HomeServiceEvaluationState {
  const _SubmitSuccess({required this.data, required this.message}): super._();
  

@override final  HomeServiceEvaluationData data;
 final  BottomSheetMessageModel message;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitSuccessCopyWith<_SubmitSuccess> get copyWith => __$SubmitSuccessCopyWithImpl<_SubmitSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitSuccess&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,data,message);

@override
String toString() {
  return 'HomeServiceEvaluationState.submitSuccess(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SubmitSuccessCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$SubmitSuccessCopyWith(_SubmitSuccess value, $Res Function(_SubmitSuccess) _then) = __$SubmitSuccessCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data, BottomSheetMessageModel message
});




}
/// @nodoc
class __$SubmitSuccessCopyWithImpl<$Res>
    implements _$SubmitSuccessCopyWith<$Res> {
  __$SubmitSuccessCopyWithImpl(this._self, this._then);

  final _SubmitSuccess _self;
  final $Res Function(_SubmitSuccess) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
  return _then(_SubmitSuccess(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _SubmitFailure extends HomeServiceEvaluationState {
  const _SubmitFailure({required this.data, required this.message}): super._();
  

@override final  HomeServiceEvaluationData data;
 final  BottomSheetMessageModel message;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitFailureCopyWith<_SubmitFailure> get copyWith => __$SubmitFailureCopyWithImpl<_SubmitFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitFailure&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,data,message);

@override
String toString() {
  return 'HomeServiceEvaluationState.submitFailure(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SubmitFailureCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$SubmitFailureCopyWith(_SubmitFailure value, $Res Function(_SubmitFailure) _then) = __$SubmitFailureCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data, BottomSheetMessageModel message
});




}
/// @nodoc
class __$SubmitFailureCopyWithImpl<$Res>
    implements _$SubmitFailureCopyWith<$Res> {
  __$SubmitFailureCopyWithImpl(this._self, this._then);

  final _SubmitFailure _self;
  final $Res Function(_SubmitFailure) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
  return _then(_SubmitFailure(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _SheetLoading extends HomeServiceEvaluationState {
  const _SheetLoading({required this.data, required this.sheetType}): super._();
  

@override final  HomeServiceEvaluationData data;
 final  HomeServiceEvaluationSheetType sheetType;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SheetLoadingCopyWith<_SheetLoading> get copyWith => __$SheetLoadingCopyWithImpl<_SheetLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SheetLoading&&(identical(other.data, data) || other.data == data)&&(identical(other.sheetType, sheetType) || other.sheetType == sheetType));
}


@override
int get hashCode => Object.hash(runtimeType,data,sheetType);

@override
String toString() {
  return 'HomeServiceEvaluationState.sheetLoading(data: $data, sheetType: $sheetType)';
}


}

/// @nodoc
abstract mixin class _$SheetLoadingCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$SheetLoadingCopyWith(_SheetLoading value, $Res Function(_SheetLoading) _then) = __$SheetLoadingCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data, HomeServiceEvaluationSheetType sheetType
});




}
/// @nodoc
class __$SheetLoadingCopyWithImpl<$Res>
    implements _$SheetLoadingCopyWith<$Res> {
  __$SheetLoadingCopyWithImpl(this._self, this._then);

  final _SheetLoading _self;
  final $Res Function(_SheetLoading) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? sheetType = null,}) {
  return _then(_SheetLoading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,sheetType: null == sheetType ? _self.sheetType : sheetType // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationSheetType,
  ));
}


}

/// @nodoc


class _SheetLoaded extends HomeServiceEvaluationState {
  const _SheetLoaded({required this.data, required this.sheetType}): super._();
  

@override final  HomeServiceEvaluationData data;
 final  HomeServiceEvaluationSheetType sheetType;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SheetLoadedCopyWith<_SheetLoaded> get copyWith => __$SheetLoadedCopyWithImpl<_SheetLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SheetLoaded&&(identical(other.data, data) || other.data == data)&&(identical(other.sheetType, sheetType) || other.sheetType == sheetType));
}


@override
int get hashCode => Object.hash(runtimeType,data,sheetType);

@override
String toString() {
  return 'HomeServiceEvaluationState.sheetLoaded(data: $data, sheetType: $sheetType)';
}


}

/// @nodoc
abstract mixin class _$SheetLoadedCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$SheetLoadedCopyWith(_SheetLoaded value, $Res Function(_SheetLoaded) _then) = __$SheetLoadedCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data, HomeServiceEvaluationSheetType sheetType
});




}
/// @nodoc
class __$SheetLoadedCopyWithImpl<$Res>
    implements _$SheetLoadedCopyWith<$Res> {
  __$SheetLoadedCopyWithImpl(this._self, this._then);

  final _SheetLoaded _self;
  final $Res Function(_SheetLoaded) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? sheetType = null,}) {
  return _then(_SheetLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,sheetType: null == sheetType ? _self.sheetType : sheetType // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationSheetType,
  ));
}


}

/// @nodoc


class _SheetFailure extends HomeServiceEvaluationState {
  const _SheetFailure({required this.data, required this.sheetType, required this.message}): super._();
  

@override final  HomeServiceEvaluationData data;
 final  HomeServiceEvaluationSheetType sheetType;
 final  BottomSheetMessageModel message;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SheetFailureCopyWith<_SheetFailure> get copyWith => __$SheetFailureCopyWithImpl<_SheetFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SheetFailure&&(identical(other.data, data) || other.data == data)&&(identical(other.sheetType, sheetType) || other.sheetType == sheetType)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,data,sheetType,message);

@override
String toString() {
  return 'HomeServiceEvaluationState.sheetFailure(data: $data, sheetType: $sheetType, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SheetFailureCopyWith<$Res> implements $HomeServiceEvaluationStateCopyWith<$Res> {
  factory _$SheetFailureCopyWith(_SheetFailure value, $Res Function(_SheetFailure) _then) = __$SheetFailureCopyWithImpl;
@override @useResult
$Res call({
 HomeServiceEvaluationData data, HomeServiceEvaluationSheetType sheetType, BottomSheetMessageModel message
});




}
/// @nodoc
class __$SheetFailureCopyWithImpl<$Res>
    implements _$SheetFailureCopyWith<$Res> {
  __$SheetFailureCopyWithImpl(this._self, this._then);

  final _SheetFailure _self;
  final $Res Function(_SheetFailure) _then;

/// Create a copy of HomeServiceEvaluationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? sheetType = null,Object? message = null,}) {
  return _then(_SheetFailure(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationData,sheetType: null == sheetType ? _self.sheetType : sheetType // ignore: cast_nullable_to_non_nullable
as HomeServiceEvaluationSheetType,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

// dart format on
