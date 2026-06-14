// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_photo_home_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddPhotoHomeServiceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPhotoHomeServiceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPhotoHomeServiceState()';
}


}

/// @nodoc
class $AddPhotoHomeServiceStateCopyWith<$Res>  {
$AddPhotoHomeServiceStateCopyWith(AddPhotoHomeServiceState _, $Res Function(AddPhotoHomeServiceState) __);
}


/// Adds pattern-matching-related methods to [AddPhotoHomeServiceState].
extension AddPhotoHomeServiceStatePatterns on AddPhotoHomeServiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddPhotoHomeServiceIdleState value)?  idle,TResult Function( AddPhotoHomeServiceErrorState value)?  error,TResult Function( AddPhotoHomeServiceSuccessState value)?  success,TResult Function( AddPhotoHomeServiceLoadingState value)?  loading,TResult Function( AddPhotoHomeServiceSubmitSuccessState value)?  submitSuccess,TResult Function( AddPhotoHomeServiceSubmitLoadingState value)?  submitLoading,TResult Function( AddPhotoHomeServiceEvaluationState value)?  evaluation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddPhotoHomeServiceIdleState() when idle != null:
return idle(_that);case AddPhotoHomeServiceErrorState() when error != null:
return error(_that);case AddPhotoHomeServiceSuccessState() when success != null:
return success(_that);case AddPhotoHomeServiceLoadingState() when loading != null:
return loading(_that);case AddPhotoHomeServiceSubmitSuccessState() when submitSuccess != null:
return submitSuccess(_that);case AddPhotoHomeServiceSubmitLoadingState() when submitLoading != null:
return submitLoading(_that);case AddPhotoHomeServiceEvaluationState() when evaluation != null:
return evaluation(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddPhotoHomeServiceIdleState value)  idle,required TResult Function( AddPhotoHomeServiceErrorState value)  error,required TResult Function( AddPhotoHomeServiceSuccessState value)  success,required TResult Function( AddPhotoHomeServiceLoadingState value)  loading,required TResult Function( AddPhotoHomeServiceSubmitSuccessState value)  submitSuccess,required TResult Function( AddPhotoHomeServiceSubmitLoadingState value)  submitLoading,required TResult Function( AddPhotoHomeServiceEvaluationState value)  evaluation,}){
final _that = this;
switch (_that) {
case AddPhotoHomeServiceIdleState():
return idle(_that);case AddPhotoHomeServiceErrorState():
return error(_that);case AddPhotoHomeServiceSuccessState():
return success(_that);case AddPhotoHomeServiceLoadingState():
return loading(_that);case AddPhotoHomeServiceSubmitSuccessState():
return submitSuccess(_that);case AddPhotoHomeServiceSubmitLoadingState():
return submitLoading(_that);case AddPhotoHomeServiceEvaluationState():
return evaluation(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddPhotoHomeServiceIdleState value)?  idle,TResult? Function( AddPhotoHomeServiceErrorState value)?  error,TResult? Function( AddPhotoHomeServiceSuccessState value)?  success,TResult? Function( AddPhotoHomeServiceLoadingState value)?  loading,TResult? Function( AddPhotoHomeServiceSubmitSuccessState value)?  submitSuccess,TResult? Function( AddPhotoHomeServiceSubmitLoadingState value)?  submitLoading,TResult? Function( AddPhotoHomeServiceEvaluationState value)?  evaluation,}){
final _that = this;
switch (_that) {
case AddPhotoHomeServiceIdleState() when idle != null:
return idle(_that);case AddPhotoHomeServiceErrorState() when error != null:
return error(_that);case AddPhotoHomeServiceSuccessState() when success != null:
return success(_that);case AddPhotoHomeServiceLoadingState() when loading != null:
return loading(_that);case AddPhotoHomeServiceSubmitSuccessState() when submitSuccess != null:
return submitSuccess(_that);case AddPhotoHomeServiceSubmitLoadingState() when submitLoading != null:
return submitLoading(_that);case AddPhotoHomeServiceEvaluationState() when evaluation != null:
return evaluation(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( DialogDataModel dialogDataModel)?  error,TResult Function()?  success,TResult Function()?  loading,TResult Function()?  submitSuccess,TResult Function()?  submitLoading,TResult Function( DialogDataModel dialogDataModel)?  evaluation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddPhotoHomeServiceIdleState() when idle != null:
return idle();case AddPhotoHomeServiceErrorState() when error != null:
return error(_that.dialogDataModel);case AddPhotoHomeServiceSuccessState() when success != null:
return success();case AddPhotoHomeServiceLoadingState() when loading != null:
return loading();case AddPhotoHomeServiceSubmitSuccessState() when submitSuccess != null:
return submitSuccess();case AddPhotoHomeServiceSubmitLoadingState() when submitLoading != null:
return submitLoading();case AddPhotoHomeServiceEvaluationState() when evaluation != null:
return evaluation(_that.dialogDataModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( DialogDataModel dialogDataModel)  error,required TResult Function()  success,required TResult Function()  loading,required TResult Function()  submitSuccess,required TResult Function()  submitLoading,required TResult Function( DialogDataModel dialogDataModel)  evaluation,}) {final _that = this;
switch (_that) {
case AddPhotoHomeServiceIdleState():
return idle();case AddPhotoHomeServiceErrorState():
return error(_that.dialogDataModel);case AddPhotoHomeServiceSuccessState():
return success();case AddPhotoHomeServiceLoadingState():
return loading();case AddPhotoHomeServiceSubmitSuccessState():
return submitSuccess();case AddPhotoHomeServiceSubmitLoadingState():
return submitLoading();case AddPhotoHomeServiceEvaluationState():
return evaluation(_that.dialogDataModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( DialogDataModel dialogDataModel)?  error,TResult? Function()?  success,TResult? Function()?  loading,TResult? Function()?  submitSuccess,TResult? Function()?  submitLoading,TResult? Function( DialogDataModel dialogDataModel)?  evaluation,}) {final _that = this;
switch (_that) {
case AddPhotoHomeServiceIdleState() when idle != null:
return idle();case AddPhotoHomeServiceErrorState() when error != null:
return error(_that.dialogDataModel);case AddPhotoHomeServiceSuccessState() when success != null:
return success();case AddPhotoHomeServiceLoadingState() when loading != null:
return loading();case AddPhotoHomeServiceSubmitSuccessState() when submitSuccess != null:
return submitSuccess();case AddPhotoHomeServiceSubmitLoadingState() when submitLoading != null:
return submitLoading();case AddPhotoHomeServiceEvaluationState() when evaluation != null:
return evaluation(_that.dialogDataModel);case _:
  return null;

}
}

}

/// @nodoc


class AddPhotoHomeServiceIdleState implements AddPhotoHomeServiceState {
  const AddPhotoHomeServiceIdleState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPhotoHomeServiceIdleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPhotoHomeServiceState.idle()';
}


}




/// @nodoc


class AddPhotoHomeServiceErrorState implements AddPhotoHomeServiceState {
  const AddPhotoHomeServiceErrorState({required this.dialogDataModel});
  

 final  DialogDataModel dialogDataModel;

/// Create a copy of AddPhotoHomeServiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddPhotoHomeServiceErrorStateCopyWith<AddPhotoHomeServiceErrorState> get copyWith => _$AddPhotoHomeServiceErrorStateCopyWithImpl<AddPhotoHomeServiceErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPhotoHomeServiceErrorState&&const DeepCollectionEquality().equals(other.dialogDataModel, dialogDataModel));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dialogDataModel));

@override
String toString() {
  return 'AddPhotoHomeServiceState.error(dialogDataModel: $dialogDataModel)';
}


}

/// @nodoc
abstract mixin class $AddPhotoHomeServiceErrorStateCopyWith<$Res> implements $AddPhotoHomeServiceStateCopyWith<$Res> {
  factory $AddPhotoHomeServiceErrorStateCopyWith(AddPhotoHomeServiceErrorState value, $Res Function(AddPhotoHomeServiceErrorState) _then) = _$AddPhotoHomeServiceErrorStateCopyWithImpl;
@useResult
$Res call({
 DialogDataModel dialogDataModel
});




}
/// @nodoc
class _$AddPhotoHomeServiceErrorStateCopyWithImpl<$Res>
    implements $AddPhotoHomeServiceErrorStateCopyWith<$Res> {
  _$AddPhotoHomeServiceErrorStateCopyWithImpl(this._self, this._then);

  final AddPhotoHomeServiceErrorState _self;
  final $Res Function(AddPhotoHomeServiceErrorState) _then;

/// Create a copy of AddPhotoHomeServiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dialogDataModel = freezed,}) {
  return _then(AddPhotoHomeServiceErrorState(
dialogDataModel: freezed == dialogDataModel ? _self.dialogDataModel : dialogDataModel // ignore: cast_nullable_to_non_nullable
as DialogDataModel,
  ));
}


}

/// @nodoc


class AddPhotoHomeServiceSuccessState implements AddPhotoHomeServiceState {
  const AddPhotoHomeServiceSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPhotoHomeServiceSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPhotoHomeServiceState.success()';
}


}




/// @nodoc


class AddPhotoHomeServiceLoadingState implements AddPhotoHomeServiceState {
  const AddPhotoHomeServiceLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPhotoHomeServiceLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPhotoHomeServiceState.loading()';
}


}




/// @nodoc


class AddPhotoHomeServiceSubmitSuccessState implements AddPhotoHomeServiceState {
  const AddPhotoHomeServiceSubmitSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPhotoHomeServiceSubmitSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPhotoHomeServiceState.submitSuccess()';
}


}




/// @nodoc


class AddPhotoHomeServiceSubmitLoadingState implements AddPhotoHomeServiceState {
  const AddPhotoHomeServiceSubmitLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPhotoHomeServiceSubmitLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddPhotoHomeServiceState.submitLoading()';
}


}




/// @nodoc


class AddPhotoHomeServiceEvaluationState implements AddPhotoHomeServiceState {
  const AddPhotoHomeServiceEvaluationState({required this.dialogDataModel});
  

 final  DialogDataModel dialogDataModel;

/// Create a copy of AddPhotoHomeServiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddPhotoHomeServiceEvaluationStateCopyWith<AddPhotoHomeServiceEvaluationState> get copyWith => _$AddPhotoHomeServiceEvaluationStateCopyWithImpl<AddPhotoHomeServiceEvaluationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddPhotoHomeServiceEvaluationState&&const DeepCollectionEquality().equals(other.dialogDataModel, dialogDataModel));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dialogDataModel));

@override
String toString() {
  return 'AddPhotoHomeServiceState.evaluation(dialogDataModel: $dialogDataModel)';
}


}

/// @nodoc
abstract mixin class $AddPhotoHomeServiceEvaluationStateCopyWith<$Res> implements $AddPhotoHomeServiceStateCopyWith<$Res> {
  factory $AddPhotoHomeServiceEvaluationStateCopyWith(AddPhotoHomeServiceEvaluationState value, $Res Function(AddPhotoHomeServiceEvaluationState) _then) = _$AddPhotoHomeServiceEvaluationStateCopyWithImpl;
@useResult
$Res call({
 DialogDataModel dialogDataModel
});




}
/// @nodoc
class _$AddPhotoHomeServiceEvaluationStateCopyWithImpl<$Res>
    implements $AddPhotoHomeServiceEvaluationStateCopyWith<$Res> {
  _$AddPhotoHomeServiceEvaluationStateCopyWithImpl(this._self, this._then);

  final AddPhotoHomeServiceEvaluationState _self;
  final $Res Function(AddPhotoHomeServiceEvaluationState) _then;

/// Create a copy of AddPhotoHomeServiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dialogDataModel = freezed,}) {
  return _then(AddPhotoHomeServiceEvaluationState(
dialogDataModel: freezed == dialogDataModel ? _self.dialogDataModel : dialogDataModel // ignore: cast_nullable_to_non_nullable
as DialogDataModel,
  ));
}


}

// dart format on
