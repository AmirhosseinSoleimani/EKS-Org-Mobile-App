// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relief_request_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReliefRequestListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReliefRequestListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReliefRequestListState()';
}


}

/// @nodoc
class $ReliefRequestListStateCopyWith<$Res>  {
$ReliefRequestListStateCopyWith(ReliefRequestListState _, $Res Function(ReliefRequestListState) __);
}


/// Adds pattern-matching-related methods to [ReliefRequestListState].
extension ReliefRequestListStatePatterns on ReliefRequestListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _LoadingMore value)?  loadingMore,TResult Function( _Error value)?  error,TResult Function( _LoadingMoreError value)?  loadingMoreError,TResult Function( _ConnectionError value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _Error() when error != null:
return error(_that);case _LoadingMoreError() when loadingMoreError != null:
return loadingMoreError(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _LoadingMore value)  loadingMore,required TResult Function( _Error value)  error,required TResult Function( _LoadingMoreError value)  loadingMoreError,required TResult Function( _ConnectionError value)  connectionError,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _LoadingMore():
return loadingMore(_that);case _Error():
return error(_that);case _LoadingMoreError():
return loadingMoreError(_that);case _ConnectionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _LoadingMore value)?  loadingMore,TResult? Function( _Error value)?  error,TResult? Function( _LoadingMoreError value)?  loadingMoreError,TResult? Function( _ConnectionError value)?  connectionError,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _Error() when error != null:
return error(_that);case _LoadingMoreError() when loadingMoreError != null:
return loadingMoreError(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function()?  loaded,TResult Function()?  loadingMore,TResult Function( BottomSheetMessageModel message)?  error,TResult Function( String message)?  loadingMoreError,TResult Function()?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _LoadingMore() when loadingMore != null:
return loadingMore();case _Error() when error != null:
return error(_that.message);case _LoadingMoreError() when loadingMoreError != null:
return loadingMoreError(_that.message);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function()  loadingMore,required TResult Function( BottomSheetMessageModel message)  error,required TResult Function( String message)  loadingMoreError,required TResult Function()  connectionError,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Loading():
return loading();case _Loaded():
return loaded();case _LoadingMore():
return loadingMore();case _Error():
return error(_that.message);case _LoadingMoreError():
return loadingMoreError(_that.message);case _ConnectionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function()?  loadingMore,TResult? Function( BottomSheetMessageModel message)?  error,TResult? Function( String message)?  loadingMoreError,TResult? Function()?  connectionError,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _LoadingMore() when loadingMore != null:
return loadingMore();case _Error() when error != null:
return error(_that.message);case _LoadingMoreError() when loadingMoreError != null:
return loadingMoreError(_that.message);case _ConnectionError() when connectionError != null:
return connectionError();case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements ReliefRequestListState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReliefRequestListState.idle()';
}


}




/// @nodoc


class _Loading implements ReliefRequestListState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReliefRequestListState.loading()';
}


}




/// @nodoc


class _Loaded implements ReliefRequestListState {
  const _Loaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReliefRequestListState.loaded()';
}


}




/// @nodoc


class _LoadingMore implements ReliefRequestListState {
  const _LoadingMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReliefRequestListState.loadingMore()';
}


}




/// @nodoc


class _Error implements ReliefRequestListState {
  const _Error({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of ReliefRequestListState
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
  return 'ReliefRequestListState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ReliefRequestListStateCopyWith<$Res> {
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

/// Create a copy of ReliefRequestListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _LoadingMoreError implements ReliefRequestListState {
  const _LoadingMoreError({required this.message});
  

 final  String message;

/// Create a copy of ReliefRequestListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingMoreErrorCopyWith<_LoadingMoreError> get copyWith => __$LoadingMoreErrorCopyWithImpl<_LoadingMoreError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingMoreError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ReliefRequestListState.loadingMoreError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$LoadingMoreErrorCopyWith<$Res> implements $ReliefRequestListStateCopyWith<$Res> {
  factory _$LoadingMoreErrorCopyWith(_LoadingMoreError value, $Res Function(_LoadingMoreError) _then) = __$LoadingMoreErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$LoadingMoreErrorCopyWithImpl<$Res>
    implements _$LoadingMoreErrorCopyWith<$Res> {
  __$LoadingMoreErrorCopyWithImpl(this._self, this._then);

  final _LoadingMoreError _self;
  final $Res Function(_LoadingMoreError) _then;

/// Create a copy of ReliefRequestListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_LoadingMoreError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ConnectionError implements ReliefRequestListState {
  const _ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReliefRequestListState.connectionError()';
}


}




// dart format on
