// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ThemeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ThemeState()';
}


}

/// @nodoc
class $ThemeStateCopyWith<$Res>  {
$ThemeStateCopyWith(ThemeState _, $Res Function(ThemeState) __);
}


/// Adds pattern-matching-related methods to [ThemeState].
extension ThemeStatePatterns on ThemeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ThemeLoadingState value)?  loading,TResult Function( ThemeErrorState value)?  error,TResult Function( ThemeSuccessState value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ThemeLoadingState() when loading != null:
return loading(_that);case ThemeErrorState() when error != null:
return error(_that);case ThemeSuccessState() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ThemeLoadingState value)  loading,required TResult Function( ThemeErrorState value)  error,required TResult Function( ThemeSuccessState value)  success,}){
final _that = this;
switch (_that) {
case ThemeLoadingState():
return loading(_that);case ThemeErrorState():
return error(_that);case ThemeSuccessState():
return success(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ThemeLoadingState value)?  loading,TResult? Function( ThemeErrorState value)?  error,TResult? Function( ThemeSuccessState value)?  success,}){
final _that = this;
switch (_that) {
case ThemeLoadingState() when loading != null:
return loading(_that);case ThemeErrorState() when error != null:
return error(_that);case ThemeSuccessState() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String errorMessage)?  error,TResult Function( AppTheme appTheme,  IconData icon)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ThemeLoadingState() when loading != null:
return loading();case ThemeErrorState() when error != null:
return error(_that.errorMessage);case ThemeSuccessState() when success != null:
return success(_that.appTheme,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String errorMessage)  error,required TResult Function( AppTheme appTheme,  IconData icon)  success,}) {final _that = this;
switch (_that) {
case ThemeLoadingState():
return loading();case ThemeErrorState():
return error(_that.errorMessage);case ThemeSuccessState():
return success(_that.appTheme,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String errorMessage)?  error,TResult? Function( AppTheme appTheme,  IconData icon)?  success,}) {final _that = this;
switch (_that) {
case ThemeLoadingState() when loading != null:
return loading();case ThemeErrorState() when error != null:
return error(_that.errorMessage);case ThemeSuccessState() when success != null:
return success(_that.appTheme,_that.icon);case _:
  return null;

}
}

}

/// @nodoc


class ThemeLoadingState implements ThemeState {
  const ThemeLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ThemeState.loading()';
}


}




/// @nodoc


class ThemeErrorState implements ThemeState {
  const ThemeErrorState({required this.errorMessage});
  

 final  String errorMessage;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeErrorStateCopyWith<ThemeErrorState> get copyWith => _$ThemeErrorStateCopyWithImpl<ThemeErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeErrorState&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'ThemeState.error(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ThemeErrorStateCopyWith<$Res> implements $ThemeStateCopyWith<$Res> {
  factory $ThemeErrorStateCopyWith(ThemeErrorState value, $Res Function(ThemeErrorState) _then) = _$ThemeErrorStateCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class _$ThemeErrorStateCopyWithImpl<$Res>
    implements $ThemeErrorStateCopyWith<$Res> {
  _$ThemeErrorStateCopyWithImpl(this._self, this._then);

  final ThemeErrorState _self;
  final $Res Function(ThemeErrorState) _then;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(ThemeErrorState(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ThemeSuccessState implements ThemeState {
  const ThemeSuccessState({required this.appTheme, required this.icon});
  

 final  AppTheme appTheme;
 final  IconData icon;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeSuccessStateCopyWith<ThemeSuccessState> get copyWith => _$ThemeSuccessStateCopyWithImpl<ThemeSuccessState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeSuccessState&&(identical(other.appTheme, appTheme) || other.appTheme == appTheme)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,appTheme,icon);

@override
String toString() {
  return 'ThemeState.success(appTheme: $appTheme, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $ThemeSuccessStateCopyWith<$Res> implements $ThemeStateCopyWith<$Res> {
  factory $ThemeSuccessStateCopyWith(ThemeSuccessState value, $Res Function(ThemeSuccessState) _then) = _$ThemeSuccessStateCopyWithImpl;
@useResult
$Res call({
 AppTheme appTheme, IconData icon
});




}
/// @nodoc
class _$ThemeSuccessStateCopyWithImpl<$Res>
    implements $ThemeSuccessStateCopyWith<$Res> {
  _$ThemeSuccessStateCopyWithImpl(this._self, this._then);

  final ThemeSuccessState _self;
  final $Res Function(ThemeSuccessState) _then;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? appTheme = null,Object? icon = null,}) {
  return _then(ThemeSuccessState(
appTheme: null == appTheme ? _self.appTheme : appTheme // ignore: cast_nullable_to_non_nullable
as AppTheme,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,
  ));
}


}

// dart format on
