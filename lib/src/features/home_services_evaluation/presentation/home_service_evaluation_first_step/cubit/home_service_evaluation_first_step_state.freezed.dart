// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_service_evaluation_first_step_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeServiceEvaluationFirstStepState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationFirstStepState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceEvaluationFirstStepState()';
}


}

/// @nodoc
class $HomeServiceEvaluationFirstStepStateCopyWith<$Res>  {
$HomeServiceEvaluationFirstStepStateCopyWith(HomeServiceEvaluationFirstStepState _, $Res Function(HomeServiceEvaluationFirstStepState) __);
}


/// Adds pattern-matching-related methods to [HomeServiceEvaluationFirstStepState].
extension HomeServiceEvaluationFirstStepStatePatterns on HomeServiceEvaluationFirstStepState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeServiceEvaluationFirstStepIdleState value)?  idle,TResult Function( HomeServiceEvaluationFirstStepLoadingState value)?  loading,TResult Function( HomeServiceEvaluationFirstStepSuccessState value)?  success,TResult Function( HomeServiceEvaluationFirstStepErrorState value)?  error,TResult Function( HomeServiceEvaluationFirstStepSubmitLoadingState value)?  submitLoading,TResult Function( HomeServiceEvaluationFirstStepSubmitSuccessState value)?  submitSuccess,TResult Function( HomeServiceEvaluationFirstStepSubmitErrorState value)?  submitError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeServiceEvaluationFirstStepIdleState() when idle != null:
return idle(_that);case HomeServiceEvaluationFirstStepLoadingState() when loading != null:
return loading(_that);case HomeServiceEvaluationFirstStepSuccessState() when success != null:
return success(_that);case HomeServiceEvaluationFirstStepErrorState() when error != null:
return error(_that);case HomeServiceEvaluationFirstStepSubmitLoadingState() when submitLoading != null:
return submitLoading(_that);case HomeServiceEvaluationFirstStepSubmitSuccessState() when submitSuccess != null:
return submitSuccess(_that);case HomeServiceEvaluationFirstStepSubmitErrorState() when submitError != null:
return submitError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeServiceEvaluationFirstStepIdleState value)  idle,required TResult Function( HomeServiceEvaluationFirstStepLoadingState value)  loading,required TResult Function( HomeServiceEvaluationFirstStepSuccessState value)  success,required TResult Function( HomeServiceEvaluationFirstStepErrorState value)  error,required TResult Function( HomeServiceEvaluationFirstStepSubmitLoadingState value)  submitLoading,required TResult Function( HomeServiceEvaluationFirstStepSubmitSuccessState value)  submitSuccess,required TResult Function( HomeServiceEvaluationFirstStepSubmitErrorState value)  submitError,}){
final _that = this;
switch (_that) {
case HomeServiceEvaluationFirstStepIdleState():
return idle(_that);case HomeServiceEvaluationFirstStepLoadingState():
return loading(_that);case HomeServiceEvaluationFirstStepSuccessState():
return success(_that);case HomeServiceEvaluationFirstStepErrorState():
return error(_that);case HomeServiceEvaluationFirstStepSubmitLoadingState():
return submitLoading(_that);case HomeServiceEvaluationFirstStepSubmitSuccessState():
return submitSuccess(_that);case HomeServiceEvaluationFirstStepSubmitErrorState():
return submitError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeServiceEvaluationFirstStepIdleState value)?  idle,TResult? Function( HomeServiceEvaluationFirstStepLoadingState value)?  loading,TResult? Function( HomeServiceEvaluationFirstStepSuccessState value)?  success,TResult? Function( HomeServiceEvaluationFirstStepErrorState value)?  error,TResult? Function( HomeServiceEvaluationFirstStepSubmitLoadingState value)?  submitLoading,TResult? Function( HomeServiceEvaluationFirstStepSubmitSuccessState value)?  submitSuccess,TResult? Function( HomeServiceEvaluationFirstStepSubmitErrorState value)?  submitError,}){
final _that = this;
switch (_that) {
case HomeServiceEvaluationFirstStepIdleState() when idle != null:
return idle(_that);case HomeServiceEvaluationFirstStepLoadingState() when loading != null:
return loading(_that);case HomeServiceEvaluationFirstStepSuccessState() when success != null:
return success(_that);case HomeServiceEvaluationFirstStepErrorState() when error != null:
return error(_that);case HomeServiceEvaluationFirstStepSubmitLoadingState() when submitLoading != null:
return submitLoading(_that);case HomeServiceEvaluationFirstStepSubmitSuccessState() when submitSuccess != null:
return submitSuccess(_that);case HomeServiceEvaluationFirstStepSubmitErrorState() when submitError != null:
return submitError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function()?  success,TResult Function( BottomSheetMessageModel message)?  error,TResult Function()?  submitLoading,TResult Function()?  submitSuccess,TResult Function( BottomSheetMessageModel message)?  submitError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeServiceEvaluationFirstStepIdleState() when idle != null:
return idle();case HomeServiceEvaluationFirstStepLoadingState() when loading != null:
return loading();case HomeServiceEvaluationFirstStepSuccessState() when success != null:
return success();case HomeServiceEvaluationFirstStepErrorState() when error != null:
return error(_that.message);case HomeServiceEvaluationFirstStepSubmitLoadingState() when submitLoading != null:
return submitLoading();case HomeServiceEvaluationFirstStepSubmitSuccessState() when submitSuccess != null:
return submitSuccess();case HomeServiceEvaluationFirstStepSubmitErrorState() when submitError != null:
return submitError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function()  success,required TResult Function( BottomSheetMessageModel message)  error,required TResult Function()  submitLoading,required TResult Function()  submitSuccess,required TResult Function( BottomSheetMessageModel message)  submitError,}) {final _that = this;
switch (_that) {
case HomeServiceEvaluationFirstStepIdleState():
return idle();case HomeServiceEvaluationFirstStepLoadingState():
return loading();case HomeServiceEvaluationFirstStepSuccessState():
return success();case HomeServiceEvaluationFirstStepErrorState():
return error(_that.message);case HomeServiceEvaluationFirstStepSubmitLoadingState():
return submitLoading();case HomeServiceEvaluationFirstStepSubmitSuccessState():
return submitSuccess();case HomeServiceEvaluationFirstStepSubmitErrorState():
return submitError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( BottomSheetMessageModel message)?  error,TResult? Function()?  submitLoading,TResult? Function()?  submitSuccess,TResult? Function( BottomSheetMessageModel message)?  submitError,}) {final _that = this;
switch (_that) {
case HomeServiceEvaluationFirstStepIdleState() when idle != null:
return idle();case HomeServiceEvaluationFirstStepLoadingState() when loading != null:
return loading();case HomeServiceEvaluationFirstStepSuccessState() when success != null:
return success();case HomeServiceEvaluationFirstStepErrorState() when error != null:
return error(_that.message);case HomeServiceEvaluationFirstStepSubmitLoadingState() when submitLoading != null:
return submitLoading();case HomeServiceEvaluationFirstStepSubmitSuccessState() when submitSuccess != null:
return submitSuccess();case HomeServiceEvaluationFirstStepSubmitErrorState() when submitError != null:
return submitError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class HomeServiceEvaluationFirstStepIdleState implements HomeServiceEvaluationFirstStepState {
  const HomeServiceEvaluationFirstStepIdleState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationFirstStepIdleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceEvaluationFirstStepState.idle()';
}


}




/// @nodoc


class HomeServiceEvaluationFirstStepLoadingState implements HomeServiceEvaluationFirstStepState {
  const HomeServiceEvaluationFirstStepLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationFirstStepLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceEvaluationFirstStepState.loading()';
}


}




/// @nodoc


class HomeServiceEvaluationFirstStepSuccessState implements HomeServiceEvaluationFirstStepState {
  const HomeServiceEvaluationFirstStepSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationFirstStepSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceEvaluationFirstStepState.success()';
}


}




/// @nodoc


class HomeServiceEvaluationFirstStepErrorState implements HomeServiceEvaluationFirstStepState {
  const HomeServiceEvaluationFirstStepErrorState({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of HomeServiceEvaluationFirstStepState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeServiceEvaluationFirstStepErrorStateCopyWith<HomeServiceEvaluationFirstStepErrorState> get copyWith => _$HomeServiceEvaluationFirstStepErrorStateCopyWithImpl<HomeServiceEvaluationFirstStepErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationFirstStepErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HomeServiceEvaluationFirstStepState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $HomeServiceEvaluationFirstStepErrorStateCopyWith<$Res> implements $HomeServiceEvaluationFirstStepStateCopyWith<$Res> {
  factory $HomeServiceEvaluationFirstStepErrorStateCopyWith(HomeServiceEvaluationFirstStepErrorState value, $Res Function(HomeServiceEvaluationFirstStepErrorState) _then) = _$HomeServiceEvaluationFirstStepErrorStateCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel message
});




}
/// @nodoc
class _$HomeServiceEvaluationFirstStepErrorStateCopyWithImpl<$Res>
    implements $HomeServiceEvaluationFirstStepErrorStateCopyWith<$Res> {
  _$HomeServiceEvaluationFirstStepErrorStateCopyWithImpl(this._self, this._then);

  final HomeServiceEvaluationFirstStepErrorState _self;
  final $Res Function(HomeServiceEvaluationFirstStepErrorState) _then;

/// Create a copy of HomeServiceEvaluationFirstStepState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HomeServiceEvaluationFirstStepErrorState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class HomeServiceEvaluationFirstStepSubmitLoadingState implements HomeServiceEvaluationFirstStepState {
  const HomeServiceEvaluationFirstStepSubmitLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationFirstStepSubmitLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceEvaluationFirstStepState.submitLoading()';
}


}




/// @nodoc


class HomeServiceEvaluationFirstStepSubmitSuccessState implements HomeServiceEvaluationFirstStepState {
  const HomeServiceEvaluationFirstStepSubmitSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationFirstStepSubmitSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeServiceEvaluationFirstStepState.submitSuccess()';
}


}




/// @nodoc


class HomeServiceEvaluationFirstStepSubmitErrorState implements HomeServiceEvaluationFirstStepState {
  const HomeServiceEvaluationFirstStepSubmitErrorState({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of HomeServiceEvaluationFirstStepState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeServiceEvaluationFirstStepSubmitErrorStateCopyWith<HomeServiceEvaluationFirstStepSubmitErrorState> get copyWith => _$HomeServiceEvaluationFirstStepSubmitErrorStateCopyWithImpl<HomeServiceEvaluationFirstStepSubmitErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeServiceEvaluationFirstStepSubmitErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HomeServiceEvaluationFirstStepState.submitError(message: $message)';
}


}

/// @nodoc
abstract mixin class $HomeServiceEvaluationFirstStepSubmitErrorStateCopyWith<$Res> implements $HomeServiceEvaluationFirstStepStateCopyWith<$Res> {
  factory $HomeServiceEvaluationFirstStepSubmitErrorStateCopyWith(HomeServiceEvaluationFirstStepSubmitErrorState value, $Res Function(HomeServiceEvaluationFirstStepSubmitErrorState) _then) = _$HomeServiceEvaluationFirstStepSubmitErrorStateCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel message
});




}
/// @nodoc
class _$HomeServiceEvaluationFirstStepSubmitErrorStateCopyWithImpl<$Res>
    implements $HomeServiceEvaluationFirstStepSubmitErrorStateCopyWith<$Res> {
  _$HomeServiceEvaluationFirstStepSubmitErrorStateCopyWithImpl(this._self, this._then);

  final HomeServiceEvaluationFirstStepSubmitErrorState _self;
  final $Res Function(HomeServiceEvaluationFirstStepSubmitErrorState) _then;

/// Create a copy of HomeServiceEvaluationFirstStepState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HomeServiceEvaluationFirstStepSubmitErrorState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

// dart format on
