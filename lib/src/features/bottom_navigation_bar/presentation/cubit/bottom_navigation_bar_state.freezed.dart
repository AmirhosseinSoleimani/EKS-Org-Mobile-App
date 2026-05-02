// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_navigation_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BottomNavigationBarState {

 int get currentIndex; int get activeCount;
/// Create a copy of BottomNavigationBarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BottomNavigationBarStateCopyWith<BottomNavigationBarState> get copyWith => _$BottomNavigationBarStateCopyWithImpl<BottomNavigationBarState>(this as BottomNavigationBarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BottomNavigationBarState&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.activeCount, activeCount) || other.activeCount == activeCount));
}


@override
int get hashCode => Object.hash(runtimeType,currentIndex,activeCount);

@override
String toString() {
  return 'BottomNavigationBarState(currentIndex: $currentIndex, activeCount: $activeCount)';
}


}

/// @nodoc
abstract mixin class $BottomNavigationBarStateCopyWith<$Res>  {
  factory $BottomNavigationBarStateCopyWith(BottomNavigationBarState value, $Res Function(BottomNavigationBarState) _then) = _$BottomNavigationBarStateCopyWithImpl;
@useResult
$Res call({
 int currentIndex, int activeCount
});




}
/// @nodoc
class _$BottomNavigationBarStateCopyWithImpl<$Res>
    implements $BottomNavigationBarStateCopyWith<$Res> {
  _$BottomNavigationBarStateCopyWithImpl(this._self, this._then);

  final BottomNavigationBarState _self;
  final $Res Function(BottomNavigationBarState) _then;

/// Create a copy of BottomNavigationBarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentIndex = null,Object? activeCount = null,}) {
  return _then(_self.copyWith(
currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,activeCount: null == activeCount ? _self.activeCount : activeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BottomNavigationBarState].
extension BottomNavigationBarStatePatterns on BottomNavigationBarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CurrentIndexState value)?  currentIndex,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentIndexState() when currentIndex != null:
return currentIndex(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CurrentIndexState value)  currentIndex,}){
final _that = this;
switch (_that) {
case _CurrentIndexState():
return currentIndex(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CurrentIndexState value)?  currentIndex,}){
final _that = this;
switch (_that) {
case _CurrentIndexState() when currentIndex != null:
return currentIndex(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int currentIndex,  int activeCount)?  currentIndex,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentIndexState() when currentIndex != null:
return currentIndex(_that.currentIndex,_that.activeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int currentIndex,  int activeCount)  currentIndex,}) {final _that = this;
switch (_that) {
case _CurrentIndexState():
return currentIndex(_that.currentIndex,_that.activeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int currentIndex,  int activeCount)?  currentIndex,}) {final _that = this;
switch (_that) {
case _CurrentIndexState() when currentIndex != null:
return currentIndex(_that.currentIndex,_that.activeCount);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentIndexState implements BottomNavigationBarState {
  const _CurrentIndexState(this.currentIndex, {this.activeCount = 0});
  

@override final  int currentIndex;
@override@JsonKey() final  int activeCount;

/// Create a copy of BottomNavigationBarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentIndexStateCopyWith<_CurrentIndexState> get copyWith => __$CurrentIndexStateCopyWithImpl<_CurrentIndexState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentIndexState&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.activeCount, activeCount) || other.activeCount == activeCount));
}


@override
int get hashCode => Object.hash(runtimeType,currentIndex,activeCount);

@override
String toString() {
  return 'BottomNavigationBarState.currentIndex(currentIndex: $currentIndex, activeCount: $activeCount)';
}


}

/// @nodoc
abstract mixin class _$CurrentIndexStateCopyWith<$Res> implements $BottomNavigationBarStateCopyWith<$Res> {
  factory _$CurrentIndexStateCopyWith(_CurrentIndexState value, $Res Function(_CurrentIndexState) _then) = __$CurrentIndexStateCopyWithImpl;
@override @useResult
$Res call({
 int currentIndex, int activeCount
});




}
/// @nodoc
class __$CurrentIndexStateCopyWithImpl<$Res>
    implements _$CurrentIndexStateCopyWith<$Res> {
  __$CurrentIndexStateCopyWithImpl(this._self, this._then);

  final _CurrentIndexState _self;
  final $Res Function(_CurrentIndexState) _then;

/// Create a copy of BottomNavigationBarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentIndex = null,Object? activeCount = null,}) {
  return _then(_CurrentIndexState(
null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,activeCount: null == activeCount ? _self.activeCount : activeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
