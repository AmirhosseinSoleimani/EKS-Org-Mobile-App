// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapState()';
}


}

/// @nodoc
class $MapStateCopyWith<$Res>  {
$MapStateCopyWith(MapState _, $Res Function(MapState) __);
}


/// Adds pattern-matching-related methods to [MapState].
extension MapStatePatterns on MapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Error value)?  error,TResult Function( _PermissionSuccess value)?  permissionSuccess,TResult Function( _PermissionError value)?  permissionError,TResult Function( ConnectionErrorState value)?  connectionError,TResult Function( MapLocationToAddressLoadingState value)?  locationToAddressLoading,TResult Function( MapLocationToAddressSuccessState value)?  locationToAddressSuccess,TResult Function( MapSearchLoadingState value)?  searchLoading,TResult Function( MapSearchSuccessState value)?  searchSuccess,TResult Function( MapSearchErrorState value)?  searchError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Error() when error != null:
return error(_that);case _PermissionSuccess() when permissionSuccess != null:
return permissionSuccess(_that);case _PermissionError() when permissionError != null:
return permissionError(_that);case ConnectionErrorState() when connectionError != null:
return connectionError(_that);case MapLocationToAddressLoadingState() when locationToAddressLoading != null:
return locationToAddressLoading(_that);case MapLocationToAddressSuccessState() when locationToAddressSuccess != null:
return locationToAddressSuccess(_that);case MapSearchLoadingState() when searchLoading != null:
return searchLoading(_that);case MapSearchSuccessState() when searchSuccess != null:
return searchSuccess(_that);case MapSearchErrorState() when searchError != null:
return searchError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Error value)  error,required TResult Function( _PermissionSuccess value)  permissionSuccess,required TResult Function( _PermissionError value)  permissionError,required TResult Function( ConnectionErrorState value)  connectionError,required TResult Function( MapLocationToAddressLoadingState value)  locationToAddressLoading,required TResult Function( MapLocationToAddressSuccessState value)  locationToAddressSuccess,required TResult Function( MapSearchLoadingState value)  searchLoading,required TResult Function( MapSearchSuccessState value)  searchSuccess,required TResult Function( MapSearchErrorState value)  searchError,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Error():
return error(_that);case _PermissionSuccess():
return permissionSuccess(_that);case _PermissionError():
return permissionError(_that);case ConnectionErrorState():
return connectionError(_that);case MapLocationToAddressLoadingState():
return locationToAddressLoading(_that);case MapLocationToAddressSuccessState():
return locationToAddressSuccess(_that);case MapSearchLoadingState():
return searchLoading(_that);case MapSearchSuccessState():
return searchSuccess(_that);case MapSearchErrorState():
return searchError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Error value)?  error,TResult? Function( _PermissionSuccess value)?  permissionSuccess,TResult? Function( _PermissionError value)?  permissionError,TResult? Function( ConnectionErrorState value)?  connectionError,TResult? Function( MapLocationToAddressLoadingState value)?  locationToAddressLoading,TResult? Function( MapLocationToAddressSuccessState value)?  locationToAddressSuccess,TResult? Function( MapSearchLoadingState value)?  searchLoading,TResult? Function( MapSearchSuccessState value)?  searchSuccess,TResult? Function( MapSearchErrorState value)?  searchError,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Error() when error != null:
return error(_that);case _PermissionSuccess() when permissionSuccess != null:
return permissionSuccess(_that);case _PermissionError() when permissionError != null:
return permissionError(_that);case ConnectionErrorState() when connectionError != null:
return connectionError(_that);case MapLocationToAddressLoadingState() when locationToAddressLoading != null:
return locationToAddressLoading(_that);case MapLocationToAddressSuccessState() when locationToAddressSuccess != null:
return locationToAddressSuccess(_that);case MapSearchLoadingState() when searchLoading != null:
return searchLoading(_that);case MapSearchSuccessState() when searchSuccess != null:
return searchSuccess(_that);case MapSearchErrorState() when searchError != null:
return searchError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( BottomSheetMessageModel messageModel)?  error,TResult Function()?  permissionSuccess,TResult Function( BottomSheetMessageModel messageModel)?  permissionError,TResult Function()?  connectionError,TResult Function()?  locationToAddressLoading,TResult Function()?  locationToAddressSuccess,TResult Function()?  searchLoading,TResult Function()?  searchSuccess,TResult Function( BottomSheetMessageModel bottomSheetMessageModel)?  searchError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Error() when error != null:
return error(_that.messageModel);case _PermissionSuccess() when permissionSuccess != null:
return permissionSuccess();case _PermissionError() when permissionError != null:
return permissionError(_that.messageModel);case ConnectionErrorState() when connectionError != null:
return connectionError();case MapLocationToAddressLoadingState() when locationToAddressLoading != null:
return locationToAddressLoading();case MapLocationToAddressSuccessState() when locationToAddressSuccess != null:
return locationToAddressSuccess();case MapSearchLoadingState() when searchLoading != null:
return searchLoading();case MapSearchSuccessState() when searchSuccess != null:
return searchSuccess();case MapSearchErrorState() when searchError != null:
return searchError(_that.bottomSheetMessageModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( BottomSheetMessageModel messageModel)  error,required TResult Function()  permissionSuccess,required TResult Function( BottomSheetMessageModel messageModel)  permissionError,required TResult Function()  connectionError,required TResult Function()  locationToAddressLoading,required TResult Function()  locationToAddressSuccess,required TResult Function()  searchLoading,required TResult Function()  searchSuccess,required TResult Function( BottomSheetMessageModel bottomSheetMessageModel)  searchError,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Error():
return error(_that.messageModel);case _PermissionSuccess():
return permissionSuccess();case _PermissionError():
return permissionError(_that.messageModel);case ConnectionErrorState():
return connectionError();case MapLocationToAddressLoadingState():
return locationToAddressLoading();case MapLocationToAddressSuccessState():
return locationToAddressSuccess();case MapSearchLoadingState():
return searchLoading();case MapSearchSuccessState():
return searchSuccess();case MapSearchErrorState():
return searchError(_that.bottomSheetMessageModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( BottomSheetMessageModel messageModel)?  error,TResult? Function()?  permissionSuccess,TResult? Function( BottomSheetMessageModel messageModel)?  permissionError,TResult? Function()?  connectionError,TResult? Function()?  locationToAddressLoading,TResult? Function()?  locationToAddressSuccess,TResult? Function()?  searchLoading,TResult? Function()?  searchSuccess,TResult? Function( BottomSheetMessageModel bottomSheetMessageModel)?  searchError,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Error() when error != null:
return error(_that.messageModel);case _PermissionSuccess() when permissionSuccess != null:
return permissionSuccess();case _PermissionError() when permissionError != null:
return permissionError(_that.messageModel);case ConnectionErrorState() when connectionError != null:
return connectionError();case MapLocationToAddressLoadingState() when locationToAddressLoading != null:
return locationToAddressLoading();case MapLocationToAddressSuccessState() when locationToAddressSuccess != null:
return locationToAddressSuccess();case MapSearchLoadingState() when searchLoading != null:
return searchLoading();case MapSearchSuccessState() when searchSuccess != null:
return searchSuccess();case MapSearchErrorState() when searchError != null:
return searchError(_that.bottomSheetMessageModel);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements MapState {
  const _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapState.idle()';
}


}




/// @nodoc


class _Error implements MapState {
  const _Error({required this.messageModel});
  

 final  BottomSheetMessageModel messageModel;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.messageModel, messageModel) || other.messageModel == messageModel));
}


@override
int get hashCode => Object.hash(runtimeType,messageModel);

@override
String toString() {
  return 'MapState.error(messageModel: $messageModel)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $MapStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel messageModel
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messageModel = null,}) {
  return _then(_Error(
messageModel: null == messageModel ? _self.messageModel : messageModel // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class _PermissionSuccess implements MapState {
  const _PermissionSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapState.permissionSuccess()';
}


}




/// @nodoc


class _PermissionError implements MapState {
  const _PermissionError({required this.messageModel});
  

 final  BottomSheetMessageModel messageModel;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PermissionErrorCopyWith<_PermissionError> get copyWith => __$PermissionErrorCopyWithImpl<_PermissionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionError&&(identical(other.messageModel, messageModel) || other.messageModel == messageModel));
}


@override
int get hashCode => Object.hash(runtimeType,messageModel);

@override
String toString() {
  return 'MapState.permissionError(messageModel: $messageModel)';
}


}

/// @nodoc
abstract mixin class _$PermissionErrorCopyWith<$Res> implements $MapStateCopyWith<$Res> {
  factory _$PermissionErrorCopyWith(_PermissionError value, $Res Function(_PermissionError) _then) = __$PermissionErrorCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel messageModel
});




}
/// @nodoc
class __$PermissionErrorCopyWithImpl<$Res>
    implements _$PermissionErrorCopyWith<$Res> {
  __$PermissionErrorCopyWithImpl(this._self, this._then);

  final _PermissionError _self;
  final $Res Function(_PermissionError) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messageModel = null,}) {
  return _then(_PermissionError(
messageModel: null == messageModel ? _self.messageModel : messageModel // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

/// @nodoc


class ConnectionErrorState implements MapState {
  const ConnectionErrorState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionErrorState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapState.connectionError()';
}


}




/// @nodoc


class MapLocationToAddressLoadingState implements MapState {
  const MapLocationToAddressLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapLocationToAddressLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapState.locationToAddressLoading()';
}


}




/// @nodoc


class MapLocationToAddressSuccessState implements MapState {
  const MapLocationToAddressSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapLocationToAddressSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapState.locationToAddressSuccess()';
}


}




/// @nodoc


class MapSearchLoadingState implements MapState {
  const MapSearchLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapSearchLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapState.searchLoading()';
}


}




/// @nodoc


class MapSearchSuccessState implements MapState {
  const MapSearchSuccessState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapSearchSuccessState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MapState.searchSuccess()';
}


}




/// @nodoc


class MapSearchErrorState implements MapState {
  const MapSearchErrorState({required this.bottomSheetMessageModel});
  

 final  BottomSheetMessageModel bottomSheetMessageModel;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapSearchErrorStateCopyWith<MapSearchErrorState> get copyWith => _$MapSearchErrorStateCopyWithImpl<MapSearchErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapSearchErrorState&&(identical(other.bottomSheetMessageModel, bottomSheetMessageModel) || other.bottomSheetMessageModel == bottomSheetMessageModel));
}


@override
int get hashCode => Object.hash(runtimeType,bottomSheetMessageModel);

@override
String toString() {
  return 'MapState.searchError(bottomSheetMessageModel: $bottomSheetMessageModel)';
}


}

/// @nodoc
abstract mixin class $MapSearchErrorStateCopyWith<$Res> implements $MapStateCopyWith<$Res> {
  factory $MapSearchErrorStateCopyWith(MapSearchErrorState value, $Res Function(MapSearchErrorState) _then) = _$MapSearchErrorStateCopyWithImpl;
@useResult
$Res call({
 BottomSheetMessageModel bottomSheetMessageModel
});




}
/// @nodoc
class _$MapSearchErrorStateCopyWithImpl<$Res>
    implements $MapSearchErrorStateCopyWith<$Res> {
  _$MapSearchErrorStateCopyWithImpl(this._self, this._then);

  final MapSearchErrorState _self;
  final $Res Function(MapSearchErrorState) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bottomSheetMessageModel = null,}) {
  return _then(MapSearchErrorState(
bottomSheetMessageModel: null == bottomSheetMessageModel ? _self.bottomSheetMessageModel : bottomSheetMessageModel // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}


}

// dart format on
