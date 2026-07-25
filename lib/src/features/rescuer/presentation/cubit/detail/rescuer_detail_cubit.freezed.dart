// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rescuer_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RescuerDetailStateData {

  RescuerEntity? get rescuer;

  List<SkillCertificateEntity> get skillCertificates;

  List<SanHistoryEntity> get histories;

  bool get isDeleting;

  /// Create a copy of RescuerDetailStateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RescuerDetailStateDataCopyWith<RescuerDetailStateData> get copyWith =>
      _$RescuerDetailStateDataCopyWithImpl<RescuerDetailStateData>(
          this as RescuerDetailStateData, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RescuerDetailStateData &&
            (identical(other.rescuer, rescuer) || other.rescuer == rescuer) &&
            const DeepCollectionEquality().equals(
                other.skillCertificates, skillCertificates) &&
            const DeepCollectionEquality().equals(other.histories, histories) &&
            (identical(other.isDeleting, isDeleting) ||
                other.isDeleting == isDeleting));
  }


  @override
  int get hashCode =>
      Object.hash(runtimeType, rescuer,
      const DeepCollectionEquality().hash(skillCertificates),
      const DeepCollectionEquality().hash(histories), isDeleting);

  @override
  String toString() {
    return 'RescuerDetailStateData(rescuer: $rescuer, skillCertificates: $skillCertificates, histories: $histories, isDeleting: $isDeleting)';
  }


}

/// @nodoc
abstract mixin class $RescuerDetailStateDataCopyWith<$Res> {
  factory $RescuerDetailStateDataCopyWith(RescuerDetailStateData value,
      $Res Function(RescuerDetailStateData) _then) = _$RescuerDetailStateDataCopyWithImpl;

  @useResult
  $Res call({
    RescuerEntity? rescuer, List<
        SkillCertificateEntity> skillCertificates, List<
        SanHistoryEntity> histories, bool isDeleting
  });


}

/// @nodoc
class _$RescuerDetailStateDataCopyWithImpl<$Res>
    implements $RescuerDetailStateDataCopyWith<$Res> {
  _$RescuerDetailStateDataCopyWithImpl(this._self, this._then);

  final RescuerDetailStateData _self;
  final $Res Function(RescuerDetailStateData) _then;

  /// Create a copy of RescuerDetailStateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? rescuer = freezed, Object? skillCertificates = null, Object? histories = null, Object? isDeleting = null,}) {
    return _then(_self.copyWith(
      rescuer: freezed == rescuer
          ? _self.rescuer
          : rescuer // ignore: cast_nullable_to_non_nullable
      as RescuerEntity?,
      skillCertificates: null == skillCertificates
          ? _self.skillCertificates
          : skillCertificates // ignore: cast_nullable_to_non_nullable
      as List<SkillCertificateEntity>,
      histories: null == histories
          ? _self.histories
          : histories // ignore: cast_nullable_to_non_nullable
      as List<SanHistoryEntity>,
      isDeleting: null == isDeleting
          ? _self.isDeleting
          : isDeleting // ignore: cast_nullable_to_non_nullable
      as bool,
    ));
  }

}


/// Adds pattern-matching-related methods to [RescuerDetailStateData].
extension RescuerDetailStateDataPatterns on RescuerDetailStateData {
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

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  TResult Function( _RescuerDetailStateData value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _RescuerDetailStateData() when $default != null:
  return $default(_that);case _:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RescuerDetailStateData value) $default,){
  final _that = this;
  switch (_that) {
  case _RescuerDetailStateData():
  return $default(_that);case _:
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RescuerDetailStateData value)? $default,){
  final _that = this;
  switch (_that) {
  case _RescuerDetailStateData() when $default != null:
  return $default(_that);case _:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RescuerEntity? rescuer, List<SkillCertificateEntity> skillCertificates, List<SanHistoryEntity> histories, bool isDeleting)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _RescuerDetailStateData() when $default != null:
  return $default(_that.rescuer,_that.skillCertificates,_that.histories,_that.isDeleting);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RescuerEntity? rescuer, List<SkillCertificateEntity> skillCertificates, List<SanHistoryEntity> histories, bool isDeleting) $default,) {final _that = this;
  switch (_that) {
  case _RescuerDetailStateData():
  return $default(_that.rescuer,_that.skillCertificates,_that.histories,_that.isDeleting);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RescuerEntity? rescuer, List<SkillCertificateEntity> skillCertificates, List<SanHistoryEntity> histories, bool isDeleting)? $default,) {final _that = this;
  switch (_that) {
  case _RescuerDetailStateData() when $default != null:
  return $default(_that.rescuer,_that.skillCertificates,_that.histories,_that.isDeleting);case _:
  return null;

  }
  }

}

/// @nodoc


class _RescuerDetailStateData implements RescuerDetailStateData {
  const _RescuerDetailStateData({this.rescuer, final List<
      SkillCertificateEntity> skillCertificates = const [], final List<
      SanHistoryEntity> histories = const [], this.isDeleting = false})
      : _skillCertificates = skillCertificates,
        _histories = histories;


  @override final RescuerEntity? rescuer;
  final List<SkillCertificateEntity> _skillCertificates;

  @override
  @JsonKey()
  List<SkillCertificateEntity> get skillCertificates {
    if (_skillCertificates is EqualUnmodifiableListView)
      return _skillCertificates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skillCertificates);
  }

  final List<SanHistoryEntity> _histories;

  @override
  @JsonKey()
  List<SanHistoryEntity> get histories {
    if (_histories is EqualUnmodifiableListView) return _histories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_histories);
  }

  @override
  @JsonKey()
  final bool isDeleting;

  /// Create a copy of RescuerDetailStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RescuerDetailStateDataCopyWith<_RescuerDetailStateData> get copyWith =>
      __$RescuerDetailStateDataCopyWithImpl<_RescuerDetailStateData>(
          this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _RescuerDetailStateData &&
            (identical(other.rescuer, rescuer) || other.rescuer == rescuer) &&
            const DeepCollectionEquality().equals(
                other._skillCertificates, _skillCertificates) &&
            const DeepCollectionEquality().equals(
                other._histories, _histories) &&
            (identical(other.isDeleting, isDeleting) ||
                other.isDeleting == isDeleting));
  }


  @override
  int get hashCode =>
      Object.hash(runtimeType, rescuer,
      const DeepCollectionEquality().hash(_skillCertificates),
      const DeepCollectionEquality().hash(_histories), isDeleting);

  @override
  String toString() {
    return 'RescuerDetailStateData(rescuer: $rescuer, skillCertificates: $skillCertificates, histories: $histories, isDeleting: $isDeleting)';
  }


}

/// @nodoc
abstract mixin class _$RescuerDetailStateDataCopyWith<$Res>
    implements $RescuerDetailStateDataCopyWith<$Res> {
  factory _$RescuerDetailStateDataCopyWith(_RescuerDetailStateData value,
      $Res Function(_RescuerDetailStateData) _then) = __$RescuerDetailStateDataCopyWithImpl;

  @override
  @useResult
  $Res call({
    RescuerEntity? rescuer, List<
        SkillCertificateEntity> skillCertificates, List<
        SanHistoryEntity> histories, bool isDeleting
  });


}

/// @nodoc
class __$RescuerDetailStateDataCopyWithImpl<$Res>
    implements _$RescuerDetailStateDataCopyWith<$Res> {
  __$RescuerDetailStateDataCopyWithImpl(this._self, this._then);

  final _RescuerDetailStateData _self;
  final $Res Function(_RescuerDetailStateData) _then;

  /// Create a copy of RescuerDetailStateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? rescuer = freezed, Object? skillCertificates = null, Object? histories = null, Object? isDeleting = null,}) {
    return _then(_RescuerDetailStateData(
      rescuer: freezed == rescuer
          ? _self.rescuer
          : rescuer // ignore: cast_nullable_to_non_nullable
      as RescuerEntity?,
      skillCertificates: null == skillCertificates
          ? _self._skillCertificates
          : skillCertificates // ignore: cast_nullable_to_non_nullable
      as List<SkillCertificateEntity>,
      histories: null == histories
          ? _self._histories
          : histories // ignore: cast_nullable_to_non_nullable
      as List<SanHistoryEntity>,
      isDeleting: null == isDeleting
          ? _self.isDeleting
          : isDeleting // ignore: cast_nullable_to_non_nullable
      as bool,
    ));
  }


}

/// @nodoc
mixin _$RescuerDetailState {

  RescuerDetailStateData get data;

  /// Create a copy of RescuerDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RescuerDetailStateCopyWith<RescuerDetailState> get copyWith =>
      _$RescuerDetailStateCopyWithImpl<RescuerDetailState>(
          this as RescuerDetailState, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RescuerDetailState &&
            (identical(other.data, data) || other.data == data));
  }


  @override
  int get hashCode => Object.hash(runtimeType, data);

  @override
  String toString() {
    return 'RescuerDetailState(data: $data)';
  }


}

/// @nodoc
abstract mixin class $RescuerDetailStateCopyWith<$Res> {
  factory $RescuerDetailStateCopyWith(RescuerDetailState value,
      $Res Function(RescuerDetailState) _then) = _$RescuerDetailStateCopyWithImpl;

  @useResult
  $Res call({
    RescuerDetailStateData data
  });


  $RescuerDetailStateDataCopyWith<$Res> get data;

}

/// @nodoc
class _$RescuerDetailStateCopyWithImpl<$Res>
    implements $RescuerDetailStateCopyWith<$Res> {
  _$RescuerDetailStateCopyWithImpl(this._self, this._then);

  final RescuerDetailState _self;
  final $Res Function(RescuerDetailState) _then;

  /// Create a copy of RescuerDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null,}) {
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
      as RescuerDetailStateData,
    ));
  }

  /// Create a copy of RescuerDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RescuerDetailStateDataCopyWith<$Res> get data {
    return $RescuerDetailStateDataCopyWith<$Res>(_self.data, (value) {
      return _then(_self.copyWith(data: value));
    });
  }
}


/// Adds pattern-matching-related methods to [RescuerDetailState].
extension RescuerDetailStatePatterns on RescuerDetailState {
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

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  {

  TResult

  Function

  (

  _Idle

  value

  )

  ?

  idle

  ,

  TResult

  Function

  (

  _Loading

  value

  )

  ?

  loading

  ,

  TResult

  Function

  (

  _Loaded

  value

  )

  ?

  loaded

  ,

  TResult

  Function

  (

  _ActionLoading

  value

  )

  ?

  actionLoading

  ,

  TResult

  Function

  (

  _Error

  value

  )

  ?

  error

  ,

  TResult

  Function

  (

  _ActionError

  value

  )

  ?

  actionError

  ,

  TResult

  Function

  (

  _ConnectionError

  value

  )

  ?

  connectionError

  ,

  required

  TResult

  orElse

  (

  )

  ,
}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _ActionLoading() when actionLoading != null:
return actionLoading(_that);case _Error() when error != null:
return error(_that);case _ActionError() when actionError != null:
return actionError(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs
TResult map<TResult extends Object?>(
    {required TResult Function( _Idle value) idle, required TResult Function( _Loading value) loading, required TResult Function( _Loaded value) loaded, required TResult Function( _ActionLoading value) actionLoading, required TResult Function( _Error value) error, required TResult Function( _ActionError value) actionError, required TResult Function( _ConnectionError value) connectionError,}) {
  final _that = this;
  switch (_that) {
    case _Idle():
      return idle(_that);
    case _Loading():
      return loading(_that);
    case _Loaded():
      return loaded(_that);
    case _ActionLoading():
      return actionLoading(_that);
    case _Error():
      return error(_that);
    case _ActionError():
      return actionError(_that);
    case _ConnectionError():
      return connectionError(_that);
    case _:
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

@optionalTypeArgs
TResult? mapOrNull<TResult extends Object?>(
    {TResult? Function( _Idle value)? idle, TResult? Function( _Loading value)? loading, TResult? Function( _Loaded value)? loaded, TResult? Function( _ActionLoading value)? actionLoading, TResult? Function( _Error value)? error, TResult? Function( _ActionError value)? actionError, TResult? Function( _ConnectionError value)? connectionError,}) {
  final _that = this;
  switch (_that) {
    case _Idle() when idle != null:
      return idle(_that);
    case _Loading() when loading != null:
      return loading(_that);
    case _Loaded() when loaded != null:
      return loaded(_that);
    case _ActionLoading() when actionLoading != null:
      return actionLoading(_that);
    case _Error() when error != null:
      return error(_that);
    case _ActionError() when actionError != null:
      return actionError(_that);
    case _ConnectionError() when connectionError != null:
      return connectionError(_that);
    case _:
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

@optionalTypeArgs TResult maybeWhen
<
TResult extends Object?>(
{
TResult
Function
(
RescuerDetailStateData
data
)
?
idle
,
TResult
Function
(
RescuerDetailStateData
data
)
?
loading
,
TResult
Function
(
RescuerDetailStateData
data
)
?
loaded
,
TResult
Function
(
RescuerDetailStateData
data
)
?
actionLoading
,
TResult
Function
(
RescuerDetailStateData
data
,
BottomSheetMessageModel
message
)
?
error
,
TResult
Function
(
RescuerDetailStateData
data
,
String
message
)
?
actionError
,
TResult
Function
(
RescuerDetailStateData
data
)
?
connectionError
,
required
TResult
orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _ActionLoading() when actionLoading != null:
return actionLoading(_that.data);case _Error() when error != null:
return error(_that.data,_that.message);case _ActionError() when actionError != null:
return actionError(_that.data,_that.message);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RescuerDetailStateData data) idle,required TResult Function( RescuerDetailStateData data) loading,required TResult Function( RescuerDetailStateData data) loaded,required TResult Function( RescuerDetailStateData data) actionLoading,required TResult Function( RescuerDetailStateData data, BottomSheetMessageModel message) error,required TResult Function( RescuerDetailStateData data, String message) actionError,required TResult Function( RescuerDetailStateData data) connectionError,}) {final _that = this;
switch (_that) {
case _Idle():
return idle(_that.data);case _Loading():
return loading(_that.data);case _Loaded():
return loaded(_that.data);case _ActionLoading():
return actionLoading(_that.data);case _Error():
return error(_that.data,_that.message);case _ActionError():
return actionError(_that.data,_that.message);case _ConnectionError():
return connectionError(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RescuerDetailStateData data)? idle,TResult? Function( RescuerDetailStateData data)? loading,TResult? Function( RescuerDetailStateData data)? loaded,TResult? Function( RescuerDetailStateData data)? actionLoading,TResult? Function( RescuerDetailStateData data, BottomSheetMessageModel message)? error,TResult? Function( RescuerDetailStateData data, String message)? actionError,TResult? Function( RescuerDetailStateData data)? connectionError,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _ActionLoading() when actionLoading != null:
return actionLoading(_that.data);case _Error() when error != null:
return error(_that.data,_that.message);case _ActionError() when actionError != null:
return actionError(_that.data,_that.message);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _:
return null;

}
}

}

/// @nodoc


class _Idle implements RescuerDetailState {
const _Idle({this.data = const RescuerDetailStateData()});


@override@JsonKey() final RescuerDetailStateData data;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IdleCopyWith<_Idle> get copyWith => __$IdleCopyWithImpl<_Idle>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
return 'RescuerDetailState.idle(data: $data)';
}


}

/// @nodoc
abstract mixin class _$IdleCopyWith<$Res> implements $RescuerDetailStateCopyWith<$Res> {
factory _$IdleCopyWith(_Idle value, $Res Function(_Idle) _then) = __$IdleCopyWithImpl;
@override @useResult
$Res call({
RescuerDetailStateData data
});


@override $RescuerDetailStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$IdleCopyWithImpl<$Res>
implements _$IdleCopyWith<$Res> {
__$IdleCopyWithImpl(this._self, this._then);

final _Idle _self;
final $Res Function(_Idle) _then;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
return _then(_Idle(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerDetailStateData,
));
}

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerDetailStateDataCopyWith<$Res> get data {

return $RescuerDetailStateDataCopyWith<$Res>(_self.data, (value) {
return _then(_self.copyWith(data: value));
});
}
}

/// @nodoc


class _Loading implements RescuerDetailState {
const _Loading({required this.data});


@override final RescuerDetailStateData data;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
return 'RescuerDetailState.loading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $RescuerDetailStateCopyWith<$Res> {
factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
RescuerDetailStateData data
});


@override $RescuerDetailStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
implements _$LoadingCopyWith<$Res> {
__$LoadingCopyWithImpl(this._self, this._then);

final _Loading _self;
final $Res Function(_Loading) _then;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
return _then(_Loading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerDetailStateData,
));
}

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerDetailStateDataCopyWith<$Res> get data {

return $RescuerDetailStateDataCopyWith<$Res>(_self.data, (value) {
return _then(_self.copyWith(data: value));
});
}
}

/// @nodoc


class _Loaded implements RescuerDetailState {
const _Loaded({required this.data});


@override final RescuerDetailStateData data;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
return 'RescuerDetailState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $RescuerDetailStateCopyWith<$Res> {
factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
RescuerDetailStateData data
});


@override $RescuerDetailStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
implements _$LoadedCopyWith<$Res> {
__$LoadedCopyWithImpl(this._self, this._then);

final _Loaded _self;
final $Res Function(_Loaded) _then;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
return _then(_Loaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerDetailStateData,
));
}

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerDetailStateDataCopyWith<$Res> get data {

return $RescuerDetailStateDataCopyWith<$Res>(_self.data, (value) {
return _then(_self.copyWith(data: value));
});
}
}

/// @nodoc


class _ActionLoading implements RescuerDetailState {
const _ActionLoading({required this.data});


@override final RescuerDetailStateData data;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActionLoadingCopyWith<_ActionLoading> get copyWith => __$ActionLoadingCopyWithImpl<_ActionLoading>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActionLoading&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
return 'RescuerDetailState.actionLoading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ActionLoadingCopyWith<$Res> implements $RescuerDetailStateCopyWith<$Res> {
factory _$ActionLoadingCopyWith(_ActionLoading value, $Res Function(_ActionLoading) _then) = __$ActionLoadingCopyWithImpl;
@override @useResult
$Res call({
RescuerDetailStateData data
});


@override $RescuerDetailStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ActionLoadingCopyWithImpl<$Res>
implements _$ActionLoadingCopyWith<$Res> {
__$ActionLoadingCopyWithImpl(this._self, this._then);

final _ActionLoading _self;
final $Res Function(_ActionLoading) _then;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
return _then(_ActionLoading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerDetailStateData,
));
}

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerDetailStateDataCopyWith<$Res> get data {

return $RescuerDetailStateDataCopyWith<$Res>(_self.data, (value) {
return _then(_self.copyWith(data: value));
});
}
}

/// @nodoc


class _Error implements RescuerDetailState {
const _Error({required this.data, required this.message});


@override final RescuerDetailStateData data;
final BottomSheetMessageModel message;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,data,message);

@override
String toString() {
return 'RescuerDetailState.error(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $RescuerDetailStateCopyWith<$Res> {
factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@override @useResult
$Res call({
RescuerDetailStateData data, BottomSheetMessageModel message
});


@override $RescuerDetailStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
implements _$ErrorCopyWith<$Res> {
__$ErrorCopyWithImpl(this._self, this._then);

final _Error _self;
final $Res Function(_Error) _then;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
return _then(_Error(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerDetailStateData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
));
}

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerDetailStateDataCopyWith<$Res> get data {

return $RescuerDetailStateDataCopyWith<$Res>(_self.data, (value) {
return _then(_self.copyWith(data: value));
});
}
}

/// @nodoc


class _ActionError implements RescuerDetailState {
const _ActionError({required this.data, required this.message});


@override final RescuerDetailStateData data;
final String message;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActionErrorCopyWith<_ActionError> get copyWith => __$ActionErrorCopyWithImpl<_ActionError>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActionError&&(identical(other.data, data) || other.data == data)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,data,message);

@override
String toString() {
return 'RescuerDetailState.actionError(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ActionErrorCopyWith<$Res> implements $RescuerDetailStateCopyWith<$Res> {
factory _$ActionErrorCopyWith(_ActionError value, $Res Function(_ActionError) _then) = __$ActionErrorCopyWithImpl;
@override @useResult
$Res call({
RescuerDetailStateData data, String message
});


@override $RescuerDetailStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ActionErrorCopyWithImpl<$Res>
implements _$ActionErrorCopyWith<$Res> {
__$ActionErrorCopyWithImpl(this._self, this._then);

final _ActionError _self;
final $Res Function(_ActionError) _then;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
return _then(_ActionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerDetailStateData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
));
}

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerDetailStateDataCopyWith<$Res> get data {

return $RescuerDetailStateDataCopyWith<$Res>(_self.data, (value) {
return _then(_self.copyWith(data: value));
});
}
}

/// @nodoc


class _ConnectionError implements RescuerDetailState {
const _ConnectionError({required this.data});


@override final RescuerDetailStateData data;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionErrorCopyWith<_ConnectionError> get copyWith => __$ConnectionErrorCopyWithImpl<_ConnectionError>(this, _$identity);


@override
bool operator ==(Object other) {
return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
return 'RescuerDetailState.connectionError(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $RescuerDetailStateCopyWith<$Res> {
factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@override @useResult
$Res call({
RescuerDetailStateData data
});


@override $RescuerDetailStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
implements _$ConnectionErrorCopyWith<$Res> {
__$ConnectionErrorCopyWithImpl(this._self, this._then);

final _ConnectionError _self;
final $Res Function(_ConnectionError) _then;

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
return _then(_ConnectionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerDetailStateData,
));
}

/// Create a copy of RescuerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerDetailStateDataCopyWith<$Res> get data {

return $RescuerDetailStateDataCopyWith<$Res>(_self.data, (value) {
return _then(_self.copyWith(data: value));
});
}
}

// dart format on
