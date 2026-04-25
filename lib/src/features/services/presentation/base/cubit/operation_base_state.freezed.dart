// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_base_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OperationBaseState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperationBaseState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OperationBaseState<$T>()';
}


}

/// @nodoc
class $OperationBaseStateCopyWith<T,$Res>  {
$OperationBaseStateCopyWith(OperationBaseState<T> _, $Res Function(OperationBaseState<T>) __);
}


/// Adds pattern-matching-related methods to [OperationBaseState].
extension OperationBaseStatePatterns<T> on OperationBaseState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading<T> value)?  loading,TResult Function( _Loaded<T> value)?  loaded,TResult Function( _LoadingMore<T> value)?  loadingMore,TResult Function( _Error<T> value)?  error,TResult Function( _ConnectionError<T> value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _Error() when error != null:
return error(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading<T> value)  loading,required TResult Function( _Loaded<T> value)  loaded,required TResult Function( _LoadingMore<T> value)  loadingMore,required TResult Function( _Error<T> value)  error,required TResult Function( _ConnectionError<T> value)  connectionError,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _LoadingMore():
return loadingMore(_that);case _Error():
return error(_that);case _ConnectionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading<T> value)?  loading,TResult? Function( _Loaded<T> value)?  loaded,TResult? Function( _LoadingMore<T> value)?  loadingMore,TResult? Function( _Error<T> value)?  error,TResult? Function( _ConnectionError<T> value)?  connectionError,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _Error() when error != null:
return error(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  loaded,TResult Function()?  loadingMore,TResult Function( BottomSheetMessageModel message)?  error,TResult Function()?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _LoadingMore() when loadingMore != null:
return loadingMore();case _Error() when error != null:
return error(_that.message);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  loaded,required TResult Function()  loadingMore,required TResult Function( BottomSheetMessageModel message)  error,required TResult Function()  connectionError,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded();case _LoadingMore():
return loadingMore();case _Error():
return error(_that.message);case _ConnectionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function()?  loadingMore,TResult? Function( BottomSheetMessageModel message)?  error,TResult? Function()?  connectionError,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _LoadingMore() when loadingMore != null:
return loadingMore();case _Error() when error != null:
return error(_that.message);case _ConnectionError() when connectionError != null:
return connectionError();case _:
  return null;

}
}

}

/// @nodoc


class _Loading<T> implements OperationBaseState<T> {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OperationBaseState<$T>.loading()';
}


}




/// @nodoc


class _Loaded<T> implements OperationBaseState<T> {
  const _Loaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OperationBaseState<$T>.loaded()';
}


}




/// @nodoc


class _LoadingMore<T> implements OperationBaseState<T> {
  const _LoadingMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingMore<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OperationBaseState<$T>.loadingMore()';
}


}




/// @nodoc


class _Error<T> implements OperationBaseState<T> {
  const _Error(this.message);
  

 final  BottomSheetMessageModel message;

/// Create a copy of OperationBaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<T, _Error<T>> get copyWith => __$ErrorCopyWithImpl<T, _Error<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OperationBaseState<$T>.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<T,$Res> implements $OperationBaseStateCopyWith<T, $Res> {
  factory _$ErrorCopyWith(_Error<T> value, $Res Function(_Error<T>) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<T,$Res>
    implements _$ErrorCopyWith<T, $Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error<T> _self;
  final $Res Function(_Error<T>) _then;

/// Create a copy of OperationBaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error<T>(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _ConnectionError<T> implements OperationBaseState<T> {
  const _ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OperationBaseState<$T>.connectionError()';
}


}




// dart format on
