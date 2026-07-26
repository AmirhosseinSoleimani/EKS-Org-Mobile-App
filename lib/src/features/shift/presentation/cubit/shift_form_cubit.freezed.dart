// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShiftFormState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftFormState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShiftFormState()';
}


}

/// @nodoc
class $ShiftFormStateCopyWith<$Res>  {
$ShiftFormStateCopyWith(ShiftFormState _, $Res Function(ShiftFormState) __);
}


/// Adds pattern-matching-related methods to [ShiftFormState].
extension ShiftFormStatePatterns on ShiftFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Ready value)?  ready,TResult Function( _Submitting value)?  submitting,TResult Function( _Success value)?  success,TResult Function( _ValidationFailure value)?  validationFailure,TResult Function( _Failure value)?  failure,TResult Function( _ConnectionError value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Ready() when ready != null:
return ready(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Success() when success != null:
return success(_that);case _ValidationFailure() when validationFailure != null:
return validationFailure(_that);case _Failure() when failure != null:
return failure(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Ready value)  ready,required TResult Function( _Submitting value)  submitting,required TResult Function( _Success value)  success,required TResult Function( _ValidationFailure value)  validationFailure,required TResult Function( _Failure value)  failure,required TResult Function( _ConnectionError value)  connectionError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Ready():
return ready(_that);case _Submitting():
return submitting(_that);case _Success():
return success(_that);case _ValidationFailure():
return validationFailure(_that);case _Failure():
return failure(_that);case _ConnectionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Ready value)?  ready,TResult? Function( _Submitting value)?  submitting,TResult? Function( _Success value)?  success,TResult? Function( _ValidationFailure value)?  validationFailure,TResult? Function( _Failure value)?  failure,TResult? Function( _ConnectionError value)?  connectionError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Ready() when ready != null:
return ready(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Success() when success != null:
return success(_that);case _ValidationFailure() when validationFailure != null:
return validationFailure(_that);case _Failure() when failure != null:
return failure(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<CurrentSessionEnumItemEntity> shiftTypes)?  loading,TResult Function( ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  ready,TResult Function( ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  submitting,TResult Function( ShiftFormAction action,  String message)?  success,TResult Function( String message,  ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  validationFailure,TResult Function( String message,  ShiftEntity? item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  failure,TResult Function( ShiftEntity? item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.shiftTypes);case _Ready() when ready != null:
return ready(_that.item,_that.shiftTypes);case _Submitting() when submitting != null:
return submitting(_that.item,_that.shiftTypes);case _Success() when success != null:
return success(_that.action,_that.message);case _ValidationFailure() when validationFailure != null:
return validationFailure(_that.message,_that.item,_that.shiftTypes);case _Failure() when failure != null:
return failure(_that.message,_that.item,_that.shiftTypes);case _ConnectionError() when connectionError != null:
return connectionError(_that.item,_that.shiftTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<CurrentSessionEnumItemEntity> shiftTypes)  loading,required TResult Function( ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)  ready,required TResult Function( ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)  submitting,required TResult Function( ShiftFormAction action,  String message)  success,required TResult Function( String message,  ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)  validationFailure,required TResult Function( String message,  ShiftEntity? item,  List<CurrentSessionEnumItemEntity> shiftTypes)  failure,required TResult Function( ShiftEntity? item,  List<CurrentSessionEnumItemEntity> shiftTypes)  connectionError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading(_that.shiftTypes);case _Ready():
return ready(_that.item,_that.shiftTypes);case _Submitting():
return submitting(_that.item,_that.shiftTypes);case _Success():
return success(_that.action,_that.message);case _ValidationFailure():
return validationFailure(_that.message,_that.item,_that.shiftTypes);case _Failure():
return failure(_that.message,_that.item,_that.shiftTypes);case _ConnectionError():
return connectionError(_that.item,_that.shiftTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<CurrentSessionEnumItemEntity> shiftTypes)?  loading,TResult? Function( ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  ready,TResult? Function( ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  submitting,TResult? Function( ShiftFormAction action,  String message)?  success,TResult? Function( String message,  ShiftEntity item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  validationFailure,TResult? Function( String message,  ShiftEntity? item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  failure,TResult? Function( ShiftEntity? item,  List<CurrentSessionEnumItemEntity> shiftTypes)?  connectionError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.shiftTypes);case _Ready() when ready != null:
return ready(_that.item,_that.shiftTypes);case _Submitting() when submitting != null:
return submitting(_that.item,_that.shiftTypes);case _Success() when success != null:
return success(_that.action,_that.message);case _ValidationFailure() when validationFailure != null:
return validationFailure(_that.message,_that.item,_that.shiftTypes);case _Failure() when failure != null:
return failure(_that.message,_that.item,_that.shiftTypes);case _ConnectionError() when connectionError != null:
return connectionError(_that.item,_that.shiftTypes);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ShiftFormState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShiftFormState.initial()';
}


}




/// @nodoc


class _Loading implements ShiftFormState {
  const _Loading({final  List<CurrentSessionEnumItemEntity> shiftTypes = const []}): _shiftTypes = shiftTypes;
  

 final  List<CurrentSessionEnumItemEntity> _shiftTypes;
@JsonKey() List<CurrentSessionEnumItemEntity> get shiftTypes {
  if (_shiftTypes is EqualUnmodifiableListView) return _shiftTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shiftTypes);
}


/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&const DeepCollectionEquality().equals(other._shiftTypes, _shiftTypes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shiftTypes));

@override
String toString() {
  return 'ShiftFormState.loading(shiftTypes: $shiftTypes)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $ShiftFormStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@useResult
$Res call({
 List<CurrentSessionEnumItemEntity> shiftTypes
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shiftTypes = null,}) {
  return _then(_Loading(
shiftTypes: null == shiftTypes ? _self._shiftTypes : shiftTypes // ignore: cast_nullable_to_non_nullable
as List<CurrentSessionEnumItemEntity>,
  ));
}


}

/// @nodoc


class _Ready implements ShiftFormState {
  const _Ready({required this.item, final  List<CurrentSessionEnumItemEntity> shiftTypes = const []}): _shiftTypes = shiftTypes;
  

 final  ShiftEntity item;
 final  List<CurrentSessionEnumItemEntity> _shiftTypes;
@JsonKey() List<CurrentSessionEnumItemEntity> get shiftTypes {
  if (_shiftTypes is EqualUnmodifiableListView) return _shiftTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shiftTypes);
}


/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadyCopyWith<_Ready> get copyWith => __$ReadyCopyWithImpl<_Ready>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ready&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other._shiftTypes, _shiftTypes));
}


@override
int get hashCode => Object.hash(runtimeType,item,const DeepCollectionEquality().hash(_shiftTypes));

@override
String toString() {
  return 'ShiftFormState.ready(item: $item, shiftTypes: $shiftTypes)';
}


}

/// @nodoc
abstract mixin class _$ReadyCopyWith<$Res> implements $ShiftFormStateCopyWith<$Res> {
  factory _$ReadyCopyWith(_Ready value, $Res Function(_Ready) _then) = __$ReadyCopyWithImpl;
@useResult
$Res call({
 ShiftEntity item, List<CurrentSessionEnumItemEntity> shiftTypes
});




}
/// @nodoc
class __$ReadyCopyWithImpl<$Res>
    implements _$ReadyCopyWith<$Res> {
  __$ReadyCopyWithImpl(this._self, this._then);

  final _Ready _self;
  final $Res Function(_Ready) _then;

/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,Object? shiftTypes = null,}) {
  return _then(_Ready(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ShiftEntity,shiftTypes: null == shiftTypes ? _self._shiftTypes : shiftTypes // ignore: cast_nullable_to_non_nullable
as List<CurrentSessionEnumItemEntity>,
  ));
}


}

/// @nodoc


class _Submitting implements ShiftFormState {
  const _Submitting({required this.item, final  List<CurrentSessionEnumItemEntity> shiftTypes = const []}): _shiftTypes = shiftTypes;
  

 final  ShiftEntity item;
 final  List<CurrentSessionEnumItemEntity> _shiftTypes;
@JsonKey() List<CurrentSessionEnumItemEntity> get shiftTypes {
  if (_shiftTypes is EqualUnmodifiableListView) return _shiftTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shiftTypes);
}


/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittingCopyWith<_Submitting> get copyWith => __$SubmittingCopyWithImpl<_Submitting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitting&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other._shiftTypes, _shiftTypes));
}


@override
int get hashCode => Object.hash(runtimeType,item,const DeepCollectionEquality().hash(_shiftTypes));

@override
String toString() {
  return 'ShiftFormState.submitting(item: $item, shiftTypes: $shiftTypes)';
}


}

/// @nodoc
abstract mixin class _$SubmittingCopyWith<$Res> implements $ShiftFormStateCopyWith<$Res> {
  factory _$SubmittingCopyWith(_Submitting value, $Res Function(_Submitting) _then) = __$SubmittingCopyWithImpl;
@useResult
$Res call({
 ShiftEntity item, List<CurrentSessionEnumItemEntity> shiftTypes
});




}
/// @nodoc
class __$SubmittingCopyWithImpl<$Res>
    implements _$SubmittingCopyWith<$Res> {
  __$SubmittingCopyWithImpl(this._self, this._then);

  final _Submitting _self;
  final $Res Function(_Submitting) _then;

/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,Object? shiftTypes = null,}) {
  return _then(_Submitting(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ShiftEntity,shiftTypes: null == shiftTypes ? _self._shiftTypes : shiftTypes // ignore: cast_nullable_to_non_nullable
as List<CurrentSessionEnumItemEntity>,
  ));
}


}

/// @nodoc


class _Success implements ShiftFormState {
  const _Success({required this.action, required this.message});
  

 final  ShiftFormAction action;
 final  String message;

/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.action, action) || other.action == action)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,action,message);

@override
String toString() {
  return 'ShiftFormState.success(action: $action, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $ShiftFormStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 ShiftFormAction action, String message
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,Object? message = null,}) {
  return _then(_Success(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ShiftFormAction,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ValidationFailure implements ShiftFormState {
  const _ValidationFailure({required this.message, required this.item, final  List<CurrentSessionEnumItemEntity> shiftTypes = const []}): _shiftTypes = shiftTypes;
  

 final  String message;
 final  ShiftEntity item;
 final  List<CurrentSessionEnumItemEntity> _shiftTypes;
@JsonKey() List<CurrentSessionEnumItemEntity> get shiftTypes {
  if (_shiftTypes is EqualUnmodifiableListView) return _shiftTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shiftTypes);
}


/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidationFailureCopyWith<_ValidationFailure> get copyWith => __$ValidationFailureCopyWithImpl<_ValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidationFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other._shiftTypes, _shiftTypes));
}


@override
int get hashCode => Object.hash(runtimeType,message,item,const DeepCollectionEquality().hash(_shiftTypes));

@override
String toString() {
  return 'ShiftFormState.validationFailure(message: $message, item: $item, shiftTypes: $shiftTypes)';
}


}

/// @nodoc
abstract mixin class _$ValidationFailureCopyWith<$Res> implements $ShiftFormStateCopyWith<$Res> {
  factory _$ValidationFailureCopyWith(_ValidationFailure value, $Res Function(_ValidationFailure) _then) = __$ValidationFailureCopyWithImpl;
@useResult
$Res call({
 String message, ShiftEntity item, List<CurrentSessionEnumItemEntity> shiftTypes
});




}
/// @nodoc
class __$ValidationFailureCopyWithImpl<$Res>
    implements _$ValidationFailureCopyWith<$Res> {
  __$ValidationFailureCopyWithImpl(this._self, this._then);

  final _ValidationFailure _self;
  final $Res Function(_ValidationFailure) _then;

/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? item = null,Object? shiftTypes = null,}) {
  return _then(_ValidationFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ShiftEntity,shiftTypes: null == shiftTypes ? _self._shiftTypes : shiftTypes // ignore: cast_nullable_to_non_nullable
as List<CurrentSessionEnumItemEntity>,
  ));
}


}

/// @nodoc


class _Failure implements ShiftFormState {
  const _Failure({required this.message, this.item, final  List<CurrentSessionEnumItemEntity> shiftTypes = const []}): _shiftTypes = shiftTypes;
  

 final  String message;
 final  ShiftEntity? item;
 final  List<CurrentSessionEnumItemEntity> _shiftTypes;
@JsonKey() List<CurrentSessionEnumItemEntity> get shiftTypes {
  if (_shiftTypes is EqualUnmodifiableListView) return _shiftTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shiftTypes);
}


/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message)&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other._shiftTypes, _shiftTypes));
}


@override
int get hashCode => Object.hash(runtimeType,message,item,const DeepCollectionEquality().hash(_shiftTypes));

@override
String toString() {
  return 'ShiftFormState.failure(message: $message, item: $item, shiftTypes: $shiftTypes)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $ShiftFormStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message, ShiftEntity? item, List<CurrentSessionEnumItemEntity> shiftTypes
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? item = freezed,Object? shiftTypes = null,}) {
  return _then(_Failure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ShiftEntity?,shiftTypes: null == shiftTypes ? _self._shiftTypes : shiftTypes // ignore: cast_nullable_to_non_nullable
as List<CurrentSessionEnumItemEntity>,
  ));
}


}

/// @nodoc


class _ConnectionError implements ShiftFormState {
  const _ConnectionError({this.item, final  List<CurrentSessionEnumItemEntity> shiftTypes = const []}): _shiftTypes = shiftTypes;
  

 final  ShiftEntity? item;
 final  List<CurrentSessionEnumItemEntity> _shiftTypes;
@JsonKey() List<CurrentSessionEnumItemEntity> get shiftTypes {
  if (_shiftTypes is EqualUnmodifiableListView) return _shiftTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shiftTypes);
}


/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionErrorCopyWith<_ConnectionError> get copyWith => __$ConnectionErrorCopyWithImpl<_ConnectionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other._shiftTypes, _shiftTypes));
}


@override
int get hashCode => Object.hash(runtimeType,item,const DeepCollectionEquality().hash(_shiftTypes));

@override
String toString() {
  return 'ShiftFormState.connectionError(item: $item, shiftTypes: $shiftTypes)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $ShiftFormStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@useResult
$Res call({
 ShiftEntity? item, List<CurrentSessionEnumItemEntity> shiftTypes
});




}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of ShiftFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = freezed,Object? shiftTypes = null,}) {
  return _then(_ConnectionError(
item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ShiftEntity?,shiftTypes: null == shiftTypes ? _self._shiftTypes : shiftTypes // ignore: cast_nullable_to_non_nullable
as List<CurrentSessionEnumItemEntity>,
  ));
}


}

// dart format on
