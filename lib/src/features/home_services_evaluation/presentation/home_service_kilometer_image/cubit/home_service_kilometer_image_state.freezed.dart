// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_service_kilometer_image_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeServiceKilometerImageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceKilometerImageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceKilometerImageState()';
}


}

/// @nodoc
class $HomeServiceKilometerImageStateCopyWith<$Res>  {
$HomeServiceKilometerImageStateCopyWith(HomeServiceKilometerImageState _, $Res Function(HomeServiceKilometerImageState) __);
}


/// Adds pattern-matching-related methods to [HomeServiceKilometerImageState].
extension HomeServiceKilometerImageStatePatterns on HomeServiceKilometerImageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Error value)?  error,TResult Function( _Success value)?  success,TResult Function( _Loading value)?  loading,TResult Function( _SubmitSuccess value)?  submitSuccess,TResult Function( _SubmitLoading value)?  submitLoading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Error() when error != null:
return error(_that);case _Success() when success != null:
return success(_that);case _Loading() when loading != null:
return loading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Error value)  error,required TResult Function( _Success value)  success,required TResult Function( _Loading value)  loading,required TResult Function( _SubmitSuccess value)  submitSuccess,required TResult Function( _SubmitLoading value)  submitLoading,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Error():
return error(_that);case _Success():
return success(_that);case _Loading():
return loading(_that);case _SubmitSuccess():
return submitSuccess(_that);case _SubmitLoading():
return submitLoading(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Error value)?  error,TResult? Function( _Success value)?  success,TResult? Function( _Loading value)?  loading,TResult? Function( _SubmitSuccess value)?  submitSuccess,TResult? Function( _SubmitLoading value)?  submitLoading,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Error() when error != null:
return error(_that);case _Success() when success != null:
return success(_that);case _Loading() when loading != null:
return loading(_that);case _SubmitSuccess() when submitSuccess != null:
return submitSuccess(_that);case _SubmitLoading() when submitLoading != null:
return submitLoading(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( DialogDataModel dialogDataModel)?  error,TResult Function()?  success,TResult Function()?  loading,TResult Function()?  submitSuccess,TResult Function()?  submitLoading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Error() when error != null:
return error(_that.dialogDataModel);case _Success() when success != null:
return success();case _Loading() when loading != null:
return loading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( DialogDataModel dialogDataModel)  error,required TResult Function()  success,required TResult Function()  loading,required TResult Function()  submitSuccess,required TResult Function()  submitLoading,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Error():
return error(_that.dialogDataModel);case _Success():
return success();case _Loading():
return loading();case _SubmitSuccess():
return submitSuccess();case _SubmitLoading():
return submitLoading();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( DialogDataModel dialogDataModel)?  error,TResult? Function()?  success,TResult? Function()?  loading,TResult? Function()?  submitSuccess,TResult? Function()?  submitLoading,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Error() when error != null:
return error(_that.dialogDataModel);case _Success() when success != null:
return success();case _Loading() when loading != null:
return loading();case _SubmitSuccess() when submitSuccess != null:
return submitSuccess();case _SubmitLoading() when submitLoading != null:
return submitLoading();case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements HomeServiceKilometerImageState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceKilometerImageState.idle()';
}


}




/// @nodoc


class _Error implements HomeServiceKilometerImageState {
  const _Error({required this.dialogDataModel});
  

 final  DialogDataModel dialogDataModel;

/// Create a copy of HomeServiceKilometerImageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&const DeepCollectionEquality().equals(other.dialogDataModel, dialogDataModel));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dialogDataModel));

@override
String toString() {
  return 'HomeServiceKilometerImageState.error(dialogDataModel: $dialogDataModel)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $HomeServiceKilometerImageStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 DialogDataModel dialogDataModel
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of HomeServiceKilometerImageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dialogDataModel = freezed,}) {
  return _then(_Error(
dialogDataModel: freezed == dialogDataModel ? _self.dialogDataModel : dialogDataModel // ignore: cast_nullable_to_non_nullable
as DialogDataModel,
  ));
}


}

/// @nodoc


class _Success implements HomeServiceKilometerImageState {
  const _Success();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceKilometerImageState.success()';
}


}




/// @nodoc


class _Loading implements HomeServiceKilometerImageState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceKilometerImageState.loading()';
}


}




/// @nodoc


class _SubmitSuccess implements HomeServiceKilometerImageState {
  const _SubmitSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceKilometerImageState.submitSuccess()';
}


}




/// @nodoc


class _SubmitLoading implements HomeServiceKilometerImageState {
  const _SubmitLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceKilometerImageState.submitLoading()';
}


}




// dart format on
