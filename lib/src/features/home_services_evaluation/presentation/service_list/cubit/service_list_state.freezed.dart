// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceListState()';
}


}

/// @nodoc
class $ServiceListStateCopyWith<$Res>  {
$ServiceListStateCopyWith(ServiceListState _, $Res Function(ServiceListState) __);
}


/// Adds pattern-matching-related methods to [ServiceListState].
extension ServiceListStatePatterns on ServiceListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServiceListStateIdleState value)?  idle,TResult Function( ServiceListStateLoadingState value)?  loading,TResult Function( ServiceListStateSuccessState value)?  success,TResult Function( ServiceListStateErrorState value)?  error,TResult Function( ServiceListStateGetServiceLoadingState value)?  getServiceLoading,TResult Function( ServiceListStateGetServiceSuccessState value)?  getServiceSuccess,TResult Function( ServiceListStateSelectServiceLoadingState value)?  selectServiceLoading,TResult Function( ServiceListStateSelectServiceSuccessState value)?  selectServiceSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServiceListStateIdleState() when idle != null:
return idle(_that);case ServiceListStateLoadingState() when loading != null:
return loading(_that);case ServiceListStateSuccessState() when success != null:
return success(_that);case ServiceListStateErrorState() when error != null:
return error(_that);case ServiceListStateGetServiceLoadingState() when getServiceLoading != null:
return getServiceLoading(_that);case ServiceListStateGetServiceSuccessState() when getServiceSuccess != null:
return getServiceSuccess(_that);case ServiceListStateSelectServiceLoadingState() when selectServiceLoading != null:
return selectServiceLoading(_that);case ServiceListStateSelectServiceSuccessState() when selectServiceSuccess != null:
return selectServiceSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServiceListStateIdleState value)  idle,required TResult Function( ServiceListStateLoadingState value)  loading,required TResult Function( ServiceListStateSuccessState value)  success,required TResult Function( ServiceListStateErrorState value)  error,required TResult Function( ServiceListStateGetServiceLoadingState value)  getServiceLoading,required TResult Function( ServiceListStateGetServiceSuccessState value)  getServiceSuccess,required TResult Function( ServiceListStateSelectServiceLoadingState value)  selectServiceLoading,required TResult Function( ServiceListStateSelectServiceSuccessState value)  selectServiceSuccess,}){
final _that = this;
switch (_that) {
case ServiceListStateIdleState():
return idle(_that);case ServiceListStateLoadingState():
return loading(_that);case ServiceListStateSuccessState():
return success(_that);case ServiceListStateErrorState():
return error(_that);case ServiceListStateGetServiceLoadingState():
return getServiceLoading(_that);case ServiceListStateGetServiceSuccessState():
return getServiceSuccess(_that);case ServiceListStateSelectServiceLoadingState():
return selectServiceLoading(_that);case ServiceListStateSelectServiceSuccessState():
return selectServiceSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServiceListStateIdleState value)?  idle,TResult? Function( ServiceListStateLoadingState value)?  loading,TResult? Function( ServiceListStateSuccessState value)?  success,TResult? Function( ServiceListStateErrorState value)?  error,TResult? Function( ServiceListStateGetServiceLoadingState value)?  getServiceLoading,TResult? Function( ServiceListStateGetServiceSuccessState value)?  getServiceSuccess,TResult? Function( ServiceListStateSelectServiceLoadingState value)?  selectServiceLoading,TResult? Function( ServiceListStateSelectServiceSuccessState value)?  selectServiceSuccess,}){
final _that = this;
switch (_that) {
case ServiceListStateIdleState() when idle != null:
return idle(_that);case ServiceListStateLoadingState() when loading != null:
return loading(_that);case ServiceListStateSuccessState() when success != null:
return success(_that);case ServiceListStateErrorState() when error != null:
return error(_that);case ServiceListStateGetServiceLoadingState() when getServiceLoading != null:
return getServiceLoading(_that);case ServiceListStateGetServiceSuccessState() when getServiceSuccess != null:
return getServiceSuccess(_that);case ServiceListStateSelectServiceLoadingState() when selectServiceLoading != null:
return selectServiceLoading(_that);case ServiceListStateSelectServiceSuccessState() when selectServiceSuccess != null:
return selectServiceSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function()?  success,TResult Function( BottomSheetMessageModel bottomSheetMessage)?  error,TResult Function()?  getServiceLoading,TResult Function()?  getServiceSuccess,TResult Function()?  selectServiceLoading,TResult Function()?  selectServiceSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServiceListStateIdleState() when idle != null:
return idle();case ServiceListStateLoadingState() when loading != null:
return loading();case ServiceListStateSuccessState() when success != null:
return success();case ServiceListStateErrorState() when error != null:
return error(_that.bottomSheetMessage);case ServiceListStateGetServiceLoadingState() when getServiceLoading != null:
return getServiceLoading();case ServiceListStateGetServiceSuccessState() when getServiceSuccess != null:
return getServiceSuccess();case ServiceListStateSelectServiceLoadingState() when selectServiceLoading != null:
return selectServiceLoading();case ServiceListStateSelectServiceSuccessState() when selectServiceSuccess != null:
return selectServiceSuccess();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function()  success,required TResult Function( BottomSheetMessageModel bottomSheetMessage)  error,required TResult Function()  getServiceLoading,required TResult Function()  getServiceSuccess,required TResult Function()  selectServiceLoading,required TResult Function()  selectServiceSuccess,}) {final _that = this;
switch (_that) {
case ServiceListStateIdleState():
return idle();case ServiceListStateLoadingState():
return loading();case ServiceListStateSuccessState():
return success();case ServiceListStateErrorState():
return error(_that.bottomSheetMessage);case ServiceListStateGetServiceLoadingState():
return getServiceLoading();case ServiceListStateGetServiceSuccessState():
return getServiceSuccess();case ServiceListStateSelectServiceLoadingState():
return selectServiceLoading();case ServiceListStateSelectServiceSuccessState():
return selectServiceSuccess();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( BottomSheetMessageModel bottomSheetMessage)?  error,TResult? Function()?  getServiceLoading,TResult? Function()?  getServiceSuccess,TResult? Function()?  selectServiceLoading,TResult? Function()?  selectServiceSuccess,}) {final _that = this;
switch (_that) {
case ServiceListStateIdleState() when idle != null:
return idle();case ServiceListStateLoadingState() when loading != null:
return loading();case ServiceListStateSuccessState() when success != null:
return success();case ServiceListStateErrorState() when error != null:
return error(_that.bottomSheetMessage);case ServiceListStateGetServiceLoadingState() when getServiceLoading != null:
return getServiceLoading();case ServiceListStateGetServiceSuccessState() when getServiceSuccess != null:
return getServiceSuccess();case ServiceListStateSelectServiceLoadingState() when selectServiceLoading != null:
return selectServiceLoading();case ServiceListStateSelectServiceSuccessState() when selectServiceSuccess != null:
return selectServiceSuccess();case _:
  return null;

}
}

}

/// @nodoc


class ServiceListStateIdleState implements ServiceListState {
  const ServiceListStateIdleState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListStateIdleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceListState.idle()';
}


}




/// @nodoc


class ServiceListStateLoadingState implements ServiceListState {
  const ServiceListStateLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListStateLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceListState.loading()';
}


}




/// @nodoc


class ServiceListStateSuccessState implements ServiceListState {
  const ServiceListStateSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListStateSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceListState.success()';
}


}




/// @nodoc


class ServiceListStateErrorState implements ServiceListState {
  const ServiceListStateErrorState({required this.bottomSheetMessage});
  

 final  BottomSheetMessageModel bottomSheetMessage;

/// Create a copy of ServiceListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceListStateErrorStateCopyWith<ServiceListStateErrorState> get copyWith => _$ServiceListStateErrorStateCopyWithImpl<ServiceListStateErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListStateErrorState&&(identical(other.bottomSheetMessage, bottomSheetMessage) || other.bottomSheetMessage == bottomSheetMessage));
}


@override
int get hashCode => Object.hash(runtimeType,bottomSheetMessage);

@override
String toString() {
  return 'ServiceListState.error(bottomSheetMessage: $bottomSheetMessage)';
}


}

/// @nodoc
abstract mixin class $ServiceListStateErrorStateCopyWith<$Res> implements $ServiceListStateCopyWith<$Res> {
  factory $ServiceListStateErrorStateCopyWith(ServiceListStateErrorState value, $Res Function(ServiceListStateErrorState) _then) = _$ServiceListStateErrorStateCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel bottomSheetMessage
});




}
/// @nodoc
class _$ServiceListStateErrorStateCopyWithImpl<$Res>
    implements $ServiceListStateErrorStateCopyWith<$Res> {
  _$ServiceListStateErrorStateCopyWithImpl(this._self, this._then);

  final ServiceListStateErrorState _self;
  final $Res Function(ServiceListStateErrorState) _then;

/// Create a copy of ServiceListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bottomSheetMessage = null,}) {
  return _then(ServiceListStateErrorState(
bottomSheetMessage: null == bottomSheetMessage ? _self.bottomSheetMessage : bottomSheetMessage // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class ServiceListStateGetServiceLoadingState implements ServiceListState {
  const ServiceListStateGetServiceLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListStateGetServiceLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceListState.getServiceLoading()';
}


}




/// @nodoc


class ServiceListStateGetServiceSuccessState implements ServiceListState {
  const ServiceListStateGetServiceSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListStateGetServiceSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceListState.getServiceSuccess()';
}


}




/// @nodoc


class ServiceListStateSelectServiceLoadingState implements ServiceListState {
  const ServiceListStateSelectServiceLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListStateSelectServiceLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceListState.selectServiceLoading()';
}


}




/// @nodoc


class ServiceListStateSelectServiceSuccessState implements ServiceListState {
  const ServiceListStateSelectServiceSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceListStateSelectServiceSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceListState.selectServiceSuccess()';
}


}




// dart format on
