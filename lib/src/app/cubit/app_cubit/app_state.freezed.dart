// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppState()';
}


}

/// @nodoc
class $AppStateCopyWith<$Res>  {
$AppStateCopyWith(AppState _, $Res Function(AppState) __);
}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppInitial value)?  initial,TResult Function( AppUnauthenticated value)?  unauthenticated,TResult Function( AppDeepLinkReceived value)?  deepLinkReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppInitial() when initial != null:
return initial(_that);case AppUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AppDeepLinkReceived() when deepLinkReceived != null:
return deepLinkReceived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppInitial value)  initial,required TResult Function( AppUnauthenticated value)  unauthenticated,required TResult Function( AppDeepLinkReceived value)  deepLinkReceived,}){
final _that = this;
switch (_that) {
case AppInitial():
return initial(_that);case AppUnauthenticated():
return unauthenticated(_that);case AppDeepLinkReceived():
return deepLinkReceived(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppInitial value)?  initial,TResult? Function( AppUnauthenticated value)?  unauthenticated,TResult? Function( AppDeepLinkReceived value)?  deepLinkReceived,}){
final _that = this;
switch (_that) {
case AppInitial() when initial != null:
return initial(_that);case AppUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AppDeepLinkReceived() when deepLinkReceived != null:
return deepLinkReceived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int? nonce)?  unauthenticated,TResult Function( String refId)?  deepLinkReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppInitial() when initial != null:
return initial();case AppUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.nonce);case AppDeepLinkReceived() when deepLinkReceived != null:
return deepLinkReceived(_that.refId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int? nonce)  unauthenticated,required TResult Function( String refId)  deepLinkReceived,}) {final _that = this;
switch (_that) {
case AppInitial():
return initial();case AppUnauthenticated():
return unauthenticated(_that.nonce);case AppDeepLinkReceived():
return deepLinkReceived(_that.refId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int? nonce)?  unauthenticated,TResult? Function( String refId)?  deepLinkReceived,}) {final _that = this;
switch (_that) {
case AppInitial() when initial != null:
return initial();case AppUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.nonce);case AppDeepLinkReceived() when deepLinkReceived != null:
return deepLinkReceived(_that.refId);case _:
  return null;

}
}

}

/// @nodoc


class AppInitial implements AppState {
  const AppInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppState.initial()';
}


}




/// @nodoc


class AppUnauthenticated implements AppState {
  const AppUnauthenticated([this.nonce]);
  

 final  int? nonce;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUnauthenticatedCopyWith<AppUnauthenticated> get copyWith => _$AppUnauthenticatedCopyWithImpl<AppUnauthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUnauthenticated&&(identical(other.nonce, nonce) || other.nonce == nonce));
}


@override
int get hashCode => Object.hash(runtimeType,nonce);

@override
String toString() {
  return 'AppState.unauthenticated(nonce: $nonce)';
}


}

/// @nodoc
abstract mixin class $AppUnauthenticatedCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory $AppUnauthenticatedCopyWith(AppUnauthenticated value, $Res Function(AppUnauthenticated) _then) = _$AppUnauthenticatedCopyWithImpl;
@useResult
$Res call({
 int? nonce
});




}
/// @nodoc
class _$AppUnauthenticatedCopyWithImpl<$Res>
    implements $AppUnauthenticatedCopyWith<$Res> {
  _$AppUnauthenticatedCopyWithImpl(this._self, this._then);

  final AppUnauthenticated _self;
  final $Res Function(AppUnauthenticated) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? nonce = freezed,}) {
  return _then(AppUnauthenticated(
freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class AppDeepLinkReceived implements AppState {
  const AppDeepLinkReceived({required this.refId});
  

 final  String refId;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppDeepLinkReceivedCopyWith<AppDeepLinkReceived> get copyWith => _$AppDeepLinkReceivedCopyWithImpl<AppDeepLinkReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppDeepLinkReceived&&(identical(other.refId, refId) || other.refId == refId));
}


@override
int get hashCode => Object.hash(runtimeType,refId);

@override
String toString() {
  return 'AppState.deepLinkReceived(refId: $refId)';
}


}

/// @nodoc
abstract mixin class $AppDeepLinkReceivedCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory $AppDeepLinkReceivedCopyWith(AppDeepLinkReceived value, $Res Function(AppDeepLinkReceived) _then) = _$AppDeepLinkReceivedCopyWithImpl;
@useResult
$Res call({
 String refId
});




}
/// @nodoc
class _$AppDeepLinkReceivedCopyWithImpl<$Res>
    implements $AppDeepLinkReceivedCopyWith<$Res> {
  _$AppDeepLinkReceivedCopyWithImpl(this._self, this._then);

  final AppDeepLinkReceived _self;
  final $Res Function(AppDeepLinkReceived) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? refId = null,}) {
  return _then(AppDeepLinkReceived(
refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
