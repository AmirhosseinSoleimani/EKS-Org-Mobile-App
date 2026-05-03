// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'online_map_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnlineMapState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnlineMapState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineMapState()';
}


}

/// @nodoc
class $OnlineMapStateCopyWith<$Res>  {
$OnlineMapStateCopyWith(OnlineMapState _, $Res Function(OnlineMapState) __);
}


/// Adds pattern-matching-related methods to [OnlineMapState].
extension OnlineMapStatePatterns on OnlineMapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _LoadedWithoutMap value)?  loadedWithoutMap,TResult Function( _MapLoading value)?  mapLoading,TResult Function( _Error value)?  error,TResult Function( _Refresh value)?  refresh,TResult Function( _ConnectionError value)?  connectionError,TResult Function( _DetailsToggled value)?  detailsToggled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _LoadedWithoutMap() when loadedWithoutMap != null:
return loadedWithoutMap(_that);case _MapLoading() when mapLoading != null:
return mapLoading(_that);case _Error() when error != null:
return error(_that);case _Refresh() when refresh != null:
return refresh(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _DetailsToggled() when detailsToggled != null:
return detailsToggled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _LoadedWithoutMap value)  loadedWithoutMap,required TResult Function( _MapLoading value)  mapLoading,required TResult Function( _Error value)  error,required TResult Function( _Refresh value)  refresh,required TResult Function( _ConnectionError value)  connectionError,required TResult Function( _DetailsToggled value)  detailsToggled,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _LoadedWithoutMap():
return loadedWithoutMap(_that);case _MapLoading():
return mapLoading(_that);case _Error():
return error(_that);case _Refresh():
return refresh(_that);case _ConnectionError():
return connectionError(_that);case _DetailsToggled():
return detailsToggled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _LoadedWithoutMap value)?  loadedWithoutMap,TResult? Function( _MapLoading value)?  mapLoading,TResult? Function( _Error value)?  error,TResult? Function( _Refresh value)?  refresh,TResult? Function( _ConnectionError value)?  connectionError,TResult? Function( _DetailsToggled value)?  detailsToggled,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _LoadedWithoutMap() when loadedWithoutMap != null:
return loadedWithoutMap(_that);case _MapLoading() when mapLoading != null:
return mapLoading(_that);case _Error() when error != null:
return error(_that);case _Refresh() when refresh != null:
return refresh(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _DetailsToggled() when detailsToggled != null:
return detailsToggled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function()?  loaded,TResult Function()?  loadedWithoutMap,TResult Function()?  mapLoading,TResult Function( BottomSheetMessageModel message)?  error,TResult Function()?  refresh,TResult Function()?  connectionError,TResult Function( bool isExpanded)?  detailsToggled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _LoadedWithoutMap() when loadedWithoutMap != null:
return loadedWithoutMap();case _MapLoading() when mapLoading != null:
return mapLoading();case _Error() when error != null:
return error(_that.message);case _Refresh() when refresh != null:
return refresh();case _ConnectionError() when connectionError != null:
return connectionError();case _DetailsToggled() when detailsToggled != null:
return detailsToggled(_that.isExpanded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function()  loadedWithoutMap,required TResult Function()  mapLoading,required TResult Function( BottomSheetMessageModel message)  error,required TResult Function()  refresh,required TResult Function()  connectionError,required TResult Function( bool isExpanded)  detailsToggled,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Loading():
return loading();case _Loaded():
return loaded();case _LoadedWithoutMap():
return loadedWithoutMap();case _MapLoading():
return mapLoading();case _Error():
return error(_that.message);case _Refresh():
return refresh();case _ConnectionError():
return connectionError();case _DetailsToggled():
return detailsToggled(_that.isExpanded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function()?  loadedWithoutMap,TResult? Function()?  mapLoading,TResult? Function( BottomSheetMessageModel message)?  error,TResult? Function()?  refresh,TResult? Function()?  connectionError,TResult? Function( bool isExpanded)?  detailsToggled,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded();case _LoadedWithoutMap() when loadedWithoutMap != null:
return loadedWithoutMap();case _MapLoading() when mapLoading != null:
return mapLoading();case _Error() when error != null:
return error(_that.message);case _Refresh() when refresh != null:
return refresh();case _ConnectionError() when connectionError != null:
return connectionError();case _DetailsToggled() when detailsToggled != null:
return detailsToggled(_that.isExpanded);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements OnlineMapState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineMapState.idle()';
}


}




/// @nodoc


class _Loading implements OnlineMapState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineMapState.loading()';
}


}




/// @nodoc


class _Loaded implements OnlineMapState {
  const _Loaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineMapState.loaded()';
}


}




/// @nodoc


class _LoadedWithoutMap implements OnlineMapState {
  const _LoadedWithoutMap();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedWithoutMap);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineMapState.loadedWithoutMap()';
}


}




/// @nodoc


class _MapLoading implements OnlineMapState {
  const _MapLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineMapState.mapLoading()';
}


}




/// @nodoc


class _Error implements OnlineMapState {
  const _Error({required this.message});
  

 final  BottomSheetMessageModel message;

/// Create a copy of OnlineMapState
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
  return 'OnlineMapState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $OnlineMapStateCopyWith<$Res> {
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

/// Create a copy of OnlineMapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _Refresh implements OnlineMapState {
  const _Refresh();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineMapState.refresh()';
}


}




/// @nodoc


class _ConnectionError implements OnlineMapState {
  const _ConnectionError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineMapState.connectionError()';
}


}




/// @nodoc


class _DetailsToggled implements OnlineMapState {
  const _DetailsToggled({required this.isExpanded});
  

 final  bool isExpanded;

/// Create a copy of OnlineMapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailsToggledCopyWith<_DetailsToggled> get copyWith => __$DetailsToggledCopyWithImpl<_DetailsToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailsToggled&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded));
}


@override
int get hashCode => Object.hash(runtimeType,isExpanded);

@override
String toString() {
  return 'OnlineMapState.detailsToggled(isExpanded: $isExpanded)';
}


}

/// @nodoc
abstract mixin class _$DetailsToggledCopyWith<$Res> implements $OnlineMapStateCopyWith<$Res> {
  factory _$DetailsToggledCopyWith(_DetailsToggled value, $Res Function(_DetailsToggled) _then) = __$DetailsToggledCopyWithImpl;
@useResult
$Res call({
 bool isExpanded
});




}
/// @nodoc
class __$DetailsToggledCopyWithImpl<$Res>
    implements _$DetailsToggledCopyWith<$Res> {
  __$DetailsToggledCopyWithImpl(this._self, this._then);

  final _DetailsToggled _self;
  final $Res Function(_DetailsToggled) _then;

/// Create a copy of OnlineMapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isExpanded = null,}) {
  return _then(_DetailsToggled(
isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
