// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int? nonce) unauthenticated,
    required TResult Function(String refId) deepLinkReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int? nonce)? unauthenticated,
    TResult? Function(String refId)? deepLinkReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int? nonce)? unauthenticated,
    TResult Function(String refId)? deepLinkReceived,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitial value) initial,
    required TResult Function(AppUnauthenticated value) unauthenticated,
    required TResult Function(AppDeepLinkReceived value) deepLinkReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitial value)? initial,
    TResult? Function(AppUnauthenticated value)? unauthenticated,
    TResult? Function(AppDeepLinkReceived value)? deepLinkReceived,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitial value)? initial,
    TResult Function(AppUnauthenticated value)? unauthenticated,
    TResult Function(AppDeepLinkReceived value)? deepLinkReceived,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppInitialImplCopyWith<$Res> {
  factory _$$AppInitialImplCopyWith(
          _$AppInitialImpl value, $Res Function(_$AppInitialImpl) then) =
      __$$AppInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppInitialImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppInitialImpl>
    implements _$$AppInitialImplCopyWith<$Res> {
  __$$AppInitialImplCopyWithImpl(
      _$AppInitialImpl _value, $Res Function(_$AppInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AppInitialImpl implements AppInitial {
  const _$AppInitialImpl();

  @override
  String toString() {
    return 'AppState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int? nonce) unauthenticated,
    required TResult Function(String refId) deepLinkReceived,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int? nonce)? unauthenticated,
    TResult? Function(String refId)? deepLinkReceived,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int? nonce)? unauthenticated,
    TResult Function(String refId)? deepLinkReceived,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitial value) initial,
    required TResult Function(AppUnauthenticated value) unauthenticated,
    required TResult Function(AppDeepLinkReceived value) deepLinkReceived,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitial value)? initial,
    TResult? Function(AppUnauthenticated value)? unauthenticated,
    TResult? Function(AppDeepLinkReceived value)? deepLinkReceived,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitial value)? initial,
    TResult Function(AppUnauthenticated value)? unauthenticated,
    TResult Function(AppDeepLinkReceived value)? deepLinkReceived,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AppInitial implements AppState {
  const factory AppInitial() = _$AppInitialImpl;
}

/// @nodoc
abstract class _$$AppUnauthenticatedImplCopyWith<$Res> {
  factory _$$AppUnauthenticatedImplCopyWith(_$AppUnauthenticatedImpl value,
          $Res Function(_$AppUnauthenticatedImpl) then) =
      __$$AppUnauthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? nonce});
}

/// @nodoc
class __$$AppUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppUnauthenticatedImpl>
    implements _$$AppUnauthenticatedImplCopyWith<$Res> {
  __$$AppUnauthenticatedImplCopyWithImpl(_$AppUnauthenticatedImpl _value,
      $Res Function(_$AppUnauthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonce = freezed,
  }) {
    return _then(_$AppUnauthenticatedImpl(
      freezed == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AppUnauthenticatedImpl implements AppUnauthenticated {
  const _$AppUnauthenticatedImpl([this.nonce]);

  @override
  final int? nonce;

  @override
  String toString() {
    return 'AppState.unauthenticated(nonce: $nonce)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUnauthenticatedImpl &&
            (identical(other.nonce, nonce) || other.nonce == nonce));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nonce);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUnauthenticatedImplCopyWith<_$AppUnauthenticatedImpl> get copyWith =>
      __$$AppUnauthenticatedImplCopyWithImpl<_$AppUnauthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int? nonce) unauthenticated,
    required TResult Function(String refId) deepLinkReceived,
  }) {
    return unauthenticated(nonce);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int? nonce)? unauthenticated,
    TResult? Function(String refId)? deepLinkReceived,
  }) {
    return unauthenticated?.call(nonce);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int? nonce)? unauthenticated,
    TResult Function(String refId)? deepLinkReceived,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(nonce);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitial value) initial,
    required TResult Function(AppUnauthenticated value) unauthenticated,
    required TResult Function(AppDeepLinkReceived value) deepLinkReceived,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitial value)? initial,
    TResult? Function(AppUnauthenticated value)? unauthenticated,
    TResult? Function(AppDeepLinkReceived value)? deepLinkReceived,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitial value)? initial,
    TResult Function(AppUnauthenticated value)? unauthenticated,
    TResult Function(AppDeepLinkReceived value)? deepLinkReceived,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AppUnauthenticated implements AppState {
  const factory AppUnauthenticated([final int? nonce]) =
      _$AppUnauthenticatedImpl;

  int? get nonce;
  @JsonKey(ignore: true)
  _$$AppUnauthenticatedImplCopyWith<_$AppUnauthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppDeepLinkReceivedImplCopyWith<$Res> {
  factory _$$AppDeepLinkReceivedImplCopyWith(_$AppDeepLinkReceivedImpl value,
          $Res Function(_$AppDeepLinkReceivedImpl) then) =
      __$$AppDeepLinkReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String refId});
}

/// @nodoc
class __$$AppDeepLinkReceivedImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppDeepLinkReceivedImpl>
    implements _$$AppDeepLinkReceivedImplCopyWith<$Res> {
  __$$AppDeepLinkReceivedImplCopyWithImpl(_$AppDeepLinkReceivedImpl _value,
      $Res Function(_$AppDeepLinkReceivedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refId = null,
  }) {
    return _then(_$AppDeepLinkReceivedImpl(
      refId: null == refId
          ? _value.refId
          : refId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AppDeepLinkReceivedImpl implements AppDeepLinkReceived {
  const _$AppDeepLinkReceivedImpl({required this.refId});

  @override
  final String refId;

  @override
  String toString() {
    return 'AppState.deepLinkReceived(refId: $refId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDeepLinkReceivedImpl &&
            (identical(other.refId, refId) || other.refId == refId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, refId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDeepLinkReceivedImplCopyWith<_$AppDeepLinkReceivedImpl> get copyWith =>
      __$$AppDeepLinkReceivedImplCopyWithImpl<_$AppDeepLinkReceivedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int? nonce) unauthenticated,
    required TResult Function(String refId) deepLinkReceived,
  }) {
    return deepLinkReceived(refId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int? nonce)? unauthenticated,
    TResult? Function(String refId)? deepLinkReceived,
  }) {
    return deepLinkReceived?.call(refId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int? nonce)? unauthenticated,
    TResult Function(String refId)? deepLinkReceived,
    required TResult orElse(),
  }) {
    if (deepLinkReceived != null) {
      return deepLinkReceived(refId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppInitial value) initial,
    required TResult Function(AppUnauthenticated value) unauthenticated,
    required TResult Function(AppDeepLinkReceived value) deepLinkReceived,
  }) {
    return deepLinkReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppInitial value)? initial,
    TResult? Function(AppUnauthenticated value)? unauthenticated,
    TResult? Function(AppDeepLinkReceived value)? deepLinkReceived,
  }) {
    return deepLinkReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppInitial value)? initial,
    TResult Function(AppUnauthenticated value)? unauthenticated,
    TResult Function(AppDeepLinkReceived value)? deepLinkReceived,
    required TResult orElse(),
  }) {
    if (deepLinkReceived != null) {
      return deepLinkReceived(this);
    }
    return orElse();
  }
}

abstract class AppDeepLinkReceived implements AppState {
  const factory AppDeepLinkReceived({required final String refId}) =
      _$AppDeepLinkReceivedImpl;

  String get refId;
  @JsonKey(ignore: true)
  _$$AppDeepLinkReceivedImplCopyWith<_$AppDeepLinkReceivedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
