// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ThemeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String errorMessage) error,
    required TResult Function(AppTheme appTheme, IconData icon) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppTheme appTheme, IconData icon)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String errorMessage)? error,
    TResult Function(AppTheme appTheme, IconData icon)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeLoadingState value) loading,
    required TResult Function(ThemeErrorState value) error,
    required TResult Function(ThemeSuccessState value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ThemeLoadingState value)? loading,
    TResult? Function(ThemeErrorState value)? error,
    TResult? Function(ThemeSuccessState value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeLoadingState value)? loading,
    TResult Function(ThemeErrorState value)? error,
    TResult Function(ThemeSuccessState value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
          ThemeState value, $Res Function(ThemeState) then) =
      _$ThemeStateCopyWithImpl<$Res, ThemeState>;
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res, $Val extends ThemeState>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ThemeLoadingStateImplCopyWith<$Res> {
  factory _$$ThemeLoadingStateImplCopyWith(_$ThemeLoadingStateImpl value,
          $Res Function(_$ThemeLoadingStateImpl) then) =
      __$$ThemeLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ThemeLoadingStateImplCopyWithImpl<$Res>
    extends _$ThemeStateCopyWithImpl<$Res, _$ThemeLoadingStateImpl>
    implements _$$ThemeLoadingStateImplCopyWith<$Res> {
  __$$ThemeLoadingStateImplCopyWithImpl(_$ThemeLoadingStateImpl _value,
      $Res Function(_$ThemeLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ThemeLoadingStateImpl implements ThemeLoadingState {
  const _$ThemeLoadingStateImpl();

  @override
  String toString() {
    return 'ThemeState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ThemeLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String errorMessage) error,
    required TResult Function(AppTheme appTheme, IconData icon) success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppTheme appTheme, IconData icon)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String errorMessage)? error,
    TResult Function(AppTheme appTheme, IconData icon)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeLoadingState value) loading,
    required TResult Function(ThemeErrorState value) error,
    required TResult Function(ThemeSuccessState value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ThemeLoadingState value)? loading,
    TResult? Function(ThemeErrorState value)? error,
    TResult? Function(ThemeSuccessState value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeLoadingState value)? loading,
    TResult Function(ThemeErrorState value)? error,
    TResult Function(ThemeSuccessState value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ThemeLoadingState implements ThemeState {
  const factory ThemeLoadingState() = _$ThemeLoadingStateImpl;
}

/// @nodoc
abstract class _$$ThemeErrorStateImplCopyWith<$Res> {
  factory _$$ThemeErrorStateImplCopyWith(_$ThemeErrorStateImpl value,
          $Res Function(_$ThemeErrorStateImpl) then) =
      __$$ThemeErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$ThemeErrorStateImplCopyWithImpl<$Res>
    extends _$ThemeStateCopyWithImpl<$Res, _$ThemeErrorStateImpl>
    implements _$$ThemeErrorStateImplCopyWith<$Res> {
  __$$ThemeErrorStateImplCopyWithImpl(
      _$ThemeErrorStateImpl _value, $Res Function(_$ThemeErrorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$ThemeErrorStateImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ThemeErrorStateImpl implements ThemeErrorState {
  const _$ThemeErrorStateImpl({required this.errorMessage});

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'ThemeState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeErrorStateImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeErrorStateImplCopyWith<_$ThemeErrorStateImpl> get copyWith =>
      __$$ThemeErrorStateImplCopyWithImpl<_$ThemeErrorStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String errorMessage) error,
    required TResult Function(AppTheme appTheme, IconData icon) success,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppTheme appTheme, IconData icon)? success,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String errorMessage)? error,
    TResult Function(AppTheme appTheme, IconData icon)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeLoadingState value) loading,
    required TResult Function(ThemeErrorState value) error,
    required TResult Function(ThemeSuccessState value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ThemeLoadingState value)? loading,
    TResult? Function(ThemeErrorState value)? error,
    TResult? Function(ThemeSuccessState value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeLoadingState value)? loading,
    TResult Function(ThemeErrorState value)? error,
    TResult Function(ThemeSuccessState value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ThemeErrorState implements ThemeState {
  const factory ThemeErrorState({required final String errorMessage}) =
      _$ThemeErrorStateImpl;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$ThemeErrorStateImplCopyWith<_$ThemeErrorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ThemeSuccessStateImplCopyWith<$Res> {
  factory _$$ThemeSuccessStateImplCopyWith(_$ThemeSuccessStateImpl value,
          $Res Function(_$ThemeSuccessStateImpl) then) =
      __$$ThemeSuccessStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppTheme appTheme, IconData icon});
}

/// @nodoc
class __$$ThemeSuccessStateImplCopyWithImpl<$Res>
    extends _$ThemeStateCopyWithImpl<$Res, _$ThemeSuccessStateImpl>
    implements _$$ThemeSuccessStateImplCopyWith<$Res> {
  __$$ThemeSuccessStateImplCopyWithImpl(_$ThemeSuccessStateImpl _value,
      $Res Function(_$ThemeSuccessStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appTheme = null,
    Object? icon = null,
  }) {
    return _then(_$ThemeSuccessStateImpl(
      appTheme: null == appTheme
          ? _value.appTheme
          : appTheme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
    ));
  }
}

/// @nodoc

class _$ThemeSuccessStateImpl implements ThemeSuccessState {
  const _$ThemeSuccessStateImpl({required this.appTheme, required this.icon});

  @override
  final AppTheme appTheme;
  @override
  final IconData icon;

  @override
  String toString() {
    return 'ThemeState.success(appTheme: $appTheme, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeSuccessStateImpl &&
            (identical(other.appTheme, appTheme) ||
                other.appTheme == appTheme) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, appTheme, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeSuccessStateImplCopyWith<_$ThemeSuccessStateImpl> get copyWith =>
      __$$ThemeSuccessStateImplCopyWithImpl<_$ThemeSuccessStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String errorMessage) error,
    required TResult Function(AppTheme appTheme, IconData icon) success,
  }) {
    return success(appTheme, icon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String errorMessage)? error,
    TResult? Function(AppTheme appTheme, IconData icon)? success,
  }) {
    return success?.call(appTheme, icon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String errorMessage)? error,
    TResult Function(AppTheme appTheme, IconData icon)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(appTheme, icon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeLoadingState value) loading,
    required TResult Function(ThemeErrorState value) error,
    required TResult Function(ThemeSuccessState value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ThemeLoadingState value)? loading,
    TResult? Function(ThemeErrorState value)? error,
    TResult? Function(ThemeSuccessState value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeLoadingState value)? loading,
    TResult Function(ThemeErrorState value)? error,
    TResult Function(ThemeSuccessState value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ThemeSuccessState implements ThemeState {
  const factory ThemeSuccessState(
      {required final AppTheme appTheme,
      required final IconData icon}) = _$ThemeSuccessStateImpl;

  AppTheme get appTheme;
  IconData get icon;
  @JsonKey(ignore: true)
  _$$ThemeSuccessStateImplCopyWith<_$ThemeSuccessStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
