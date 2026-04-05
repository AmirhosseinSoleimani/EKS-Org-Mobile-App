// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_navigation_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BottomNavigationBarState {
  int get currentIndex => throw _privateConstructorUsedError;
  int get activeCount => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int currentIndex, int activeCount) currentIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int currentIndex, int activeCount)? currentIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int currentIndex, int activeCount)? currentIndex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CurrentIndexState value) currentIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CurrentIndexState value)? currentIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CurrentIndexState value)? currentIndex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BottomNavigationBarStateCopyWith<BottomNavigationBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BottomNavigationBarStateCopyWith<$Res> {
  factory $BottomNavigationBarStateCopyWith(BottomNavigationBarState value,
          $Res Function(BottomNavigationBarState) then) =
      _$BottomNavigationBarStateCopyWithImpl<$Res, BottomNavigationBarState>;
  @useResult
  $Res call({int currentIndex, int activeCount});
}

/// @nodoc
class _$BottomNavigationBarStateCopyWithImpl<$Res,
        $Val extends BottomNavigationBarState>
    implements $BottomNavigationBarStateCopyWith<$Res> {
  _$BottomNavigationBarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIndex = null,
    Object? activeCount = null,
  }) {
    return _then(_value.copyWith(
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      activeCount: null == activeCount
          ? _value.activeCount
          : activeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrentIndexStateImplCopyWith<$Res>
    implements $BottomNavigationBarStateCopyWith<$Res> {
  factory _$$CurrentIndexStateImplCopyWith(_$CurrentIndexStateImpl value,
          $Res Function(_$CurrentIndexStateImpl) then) =
      __$$CurrentIndexStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentIndex, int activeCount});
}

/// @nodoc
class __$$CurrentIndexStateImplCopyWithImpl<$Res>
    extends _$BottomNavigationBarStateCopyWithImpl<$Res,
        _$CurrentIndexStateImpl>
    implements _$$CurrentIndexStateImplCopyWith<$Res> {
  __$$CurrentIndexStateImplCopyWithImpl(_$CurrentIndexStateImpl _value,
      $Res Function(_$CurrentIndexStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIndex = null,
    Object? activeCount = null,
  }) {
    return _then(_$CurrentIndexStateImpl(
      null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      activeCount: null == activeCount
          ? _value.activeCount
          : activeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CurrentIndexStateImpl implements _CurrentIndexState {
  const _$CurrentIndexStateImpl(this.currentIndex, {this.activeCount = 0});

  @override
  final int currentIndex;
  @override
  @JsonKey()
  final int activeCount;

  @override
  String toString() {
    return 'BottomNavigationBarState.currentIndex(currentIndex: $currentIndex, activeCount: $activeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentIndexStateImpl &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.activeCount, activeCount) ||
                other.activeCount == activeCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentIndex, activeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentIndexStateImplCopyWith<_$CurrentIndexStateImpl> get copyWith =>
      __$$CurrentIndexStateImplCopyWithImpl<_$CurrentIndexStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int currentIndex, int activeCount) currentIndex,
  }) {
    return currentIndex(this.currentIndex, activeCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int currentIndex, int activeCount)? currentIndex,
  }) {
    return currentIndex?.call(this.currentIndex, activeCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int currentIndex, int activeCount)? currentIndex,
    required TResult orElse(),
  }) {
    if (currentIndex != null) {
      return currentIndex(this.currentIndex, activeCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CurrentIndexState value) currentIndex,
  }) {
    return currentIndex(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CurrentIndexState value)? currentIndex,
  }) {
    return currentIndex?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CurrentIndexState value)? currentIndex,
    required TResult orElse(),
  }) {
    if (currentIndex != null) {
      return currentIndex(this);
    }
    return orElse();
  }
}

abstract class _CurrentIndexState implements BottomNavigationBarState {
  const factory _CurrentIndexState(final int currentIndex,
      {final int activeCount}) = _$CurrentIndexStateImpl;

  @override
  int get currentIndex;
  @override
  int get activeCount;
  @override
  @JsonKey(ignore: true)
  _$$CurrentIndexStateImplCopyWith<_$CurrentIndexStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
