// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evaluation_aid_service_request_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EvaluationAidServiceRequestState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvaluationAidServiceRequestState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EvaluationAidServiceRequestState()';
}


}

/// @nodoc
class $EvaluationAidServiceRequestStateCopyWith<$Res>  {
$EvaluationAidServiceRequestStateCopyWith(EvaluationAidServiceRequestState _, $Res Function(EvaluationAidServiceRequestState) __);
}


/// Adds pattern-matching-related methods to [EvaluationAidServiceRequestState].
extension EvaluationAidServiceRequestStatePatterns on EvaluationAidServiceRequestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _ConnectionError value)?  connectionError,TResult Function( _SubmitLoading value)?  submitLoading,TResult Function( _SubmitSuccess value)?  submitSuccess,TResult Function( _ShowAddPartAndLaborBottomSheet value)?  showAddPartAndLaborBottomSheet,TResult Function( _CloseBottomSheetBeforeRefresh value)?  closeBottomSheetAndRefresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _ShowAddPartAndLaborBottomSheet() when showAddPartAndLaborBottomSheet != null:
return showAddPartAndLaborBottomSheet(_that);case _CloseBottomSheetBeforeRefresh() when closeBottomSheetAndRefresh != null:
return closeBottomSheetAndRefresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _ConnectionError value)  connectionError,required TResult Function( _SubmitLoading value)  submitLoading,required TResult Function( _SubmitSuccess value)  submitSuccess,required TResult Function( _ShowAddPartAndLaborBottomSheet value)  showAddPartAndLaborBottomSheet,required TResult Function( _CloseBottomSheetBeforeRefresh value)  closeBottomSheetAndRefresh,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _ConnectionError():
return connectionError(_that);case _SubmitLoading():
return submitLoading(_that);case _SubmitSuccess():
return submitSuccess(_that);case _ShowAddPartAndLaborBottomSheet():
return showAddPartAndLaborBottomSheet(_that);case _CloseBottomSheetBeforeRefresh():
return closeBottomSheetAndRefresh(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _ConnectionError value)?  connectionError,TResult? Function( _SubmitLoading value)?  submitLoading,TResult? Function( _SubmitSuccess value)?  submitSuccess,TResult? Function( _ShowAddPartAndLaborBottomSheet value)?  showAddPartAndLaborBottomSheet,TResult? Function( _CloseBottomSheetBeforeRefresh value)?  closeBottomSheetAndRefresh,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _ShowAddPartAndLaborBottomSheet() when showAddPartAndLaborBottomSheet != null:
return showAddPartAndLaborBottomSheet(_that);case _CloseBottomSheetBeforeRefresh() when closeBottomSheetAndRefresh != null:
return closeBottomSheetAndRefresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function()?  loaded,TResult Function( BottomSheetMessageModel message)?  error,TResult Function()?  connectionError,TResult Function()?  submitLoading,TResult Function( String id)?  submitSuccess,TResult Function()?  showAddPartAndLaborBottomSheet,TResult Function()?  closeBottomSheetAndRefresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _Error() when error != null:
return error(_that.message);case _ConnectionError() when connectionError != null:
return connectionError();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.id);case _ShowAddPartAndLaborBottomSheet() when showAddPartAndLaborBottomSheet != null:
return showAddPartAndLaborBottomSheet();case _CloseBottomSheetBeforeRefresh() when closeBottomSheetAndRefresh != null:
return closeBottomSheetAndRefresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function( BottomSheetMessageModel message)  error,required TResult Function()  connectionError,required TResult Function()  submitLoading,required TResult Function( String id)  submitSuccess,required TResult Function()  showAddPartAndLaborBottomSheet,required TResult Function()  closeBottomSheetAndRefresh,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Loading():
return loading();case _Loaded():
return loaded();case _Error():
return error(_that.message);case _ConnectionError():
return connectionError();case _SubmitLoading():
return submitLoading();case _SubmitSuccess():
return submitSuccess(_that.id);case _ShowAddPartAndLaborBottomSheet():
return showAddPartAndLaborBottomSheet();case _CloseBottomSheetBeforeRefresh():
return closeBottomSheetAndRefresh();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function( BottomSheetMessageModel message)?  error,TResult? Function()?  connectionError,TResult? Function()?  submitLoading,TResult? Function( String id)?  submitSuccess,TResult? Function()?  showAddPartAndLaborBottomSheet,TResult? Function()?  closeBottomSheetAndRefresh,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _Error() when error != null:
return error(_that.message);case _ConnectionError() when connectionError != null:
return connectionError();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that.id);case _ShowAddPartAndLaborBottomSheet() when showAddPartAndLaborBottomSheet != null:
return showAddPartAndLaborBottomSheet();case _CloseBottomSheetBeforeRefresh() when closeBottomSheetAndRefresh != null:
return closeBottomSheetAndRefresh();case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements EvaluationAidServiceRequestState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EvaluationAidServiceRequestState.idle()';
}


}




/// @nodoc


class _Loading implements EvaluationAidServiceRequestState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EvaluationAidServiceRequestState.loading()';
}


}




/// @nodoc


class _Loaded implements EvaluationAidServiceRequestState {
  const _Loaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EvaluationAidServiceRequestState.loaded()';
}


}




/// @nodoc


class _Error implements EvaluationAidServiceRequestState {
  const _Error({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of EvaluationAidServiceRequestState
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
  return 'EvaluationAidServiceRequestState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $EvaluationAidServiceRequestStateCopyWith<$Res> {
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

/// Create a copy of EvaluationAidServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _ConnectionError implements EvaluationAidServiceRequestState {
  const _ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EvaluationAidServiceRequestState.connectionError()';
}


}




/// @nodoc


class _SubmitLoading implements EvaluationAidServiceRequestState {
  const _SubmitLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EvaluationAidServiceRequestState.submitLoading()';
}


}




/// @nodoc


class _SubmitSuccess implements EvaluationAidServiceRequestState {
  const _SubmitSuccess({required this.id});
  

 final  String id;

/// Create a copy of EvaluationAidServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitSuccessCopyWith<_SubmitSuccess> get copyWith => __$SubmitSuccessCopyWithImpl<_SubmitSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitSuccess&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'EvaluationAidServiceRequestState.submitSuccess(id: $id)';
}


}

/// @nodoc
abstract mixin class _$SubmitSuccessCopyWith<$Res> implements $EvaluationAidServiceRequestStateCopyWith<$Res> {
  factory _$SubmitSuccessCopyWith(_SubmitSuccess value, $Res Function(_SubmitSuccess) _then) = __$SubmitSuccessCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$SubmitSuccessCopyWithImpl<$Res>
    implements _$SubmitSuccessCopyWith<$Res> {
  __$SubmitSuccessCopyWithImpl(this._self, this._then);

  final _SubmitSuccess _self;
  final $Res Function(_SubmitSuccess) _then;

/// Create a copy of EvaluationAidServiceRequestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_SubmitSuccess(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ShowAddPartAndLaborBottomSheet implements EvaluationAidServiceRequestState {
  const _ShowAddPartAndLaborBottomSheet();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShowAddPartAndLaborBottomSheet);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EvaluationAidServiceRequestState.showAddPartAndLaborBottomSheet()';
}


}




/// @nodoc


class _CloseBottomSheetBeforeRefresh implements EvaluationAidServiceRequestState {
  const _CloseBottomSheetBeforeRefresh();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CloseBottomSheetBeforeRefresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EvaluationAidServiceRequestState.closeBottomSheetAndRefresh()';
}


}




// dart format on
