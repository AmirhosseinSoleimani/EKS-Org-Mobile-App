// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rescuer_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RescuerListStateData {

 List<RescuerEntity> get items; List<RescuerEntity> get filteredItems; RescuerStatusFilter get selectedStatus; int? get deletingRescuerId;
/// Create a copy of RescuerListStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<RescuerListStateData> get copyWith => _$RescuerListStateDataCopyWithImpl<RescuerListStateData>(this as RescuerListStateData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RescuerListStateData&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.filteredItems, filteredItems)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.deletingRescuerId, deletingRescuerId) || other.deletingRescuerId == deletingRescuerId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(filteredItems),selectedStatus,deletingRescuerId);

@override
String toString() {
  return 'RescuerListStateData(items: $items, filteredItems: $filteredItems, selectedStatus: $selectedStatus, deletingRescuerId: $deletingRescuerId)';
}


}

/// @nodoc
abstract mixin class $RescuerListStateDataCopyWith<$Res>  {
  factory $RescuerListStateDataCopyWith(RescuerListStateData value, $Res Function(RescuerListStateData) _then) = _$RescuerListStateDataCopyWithImpl;
@useResult
$Res call({
 List<RescuerEntity> items, List<RescuerEntity> filteredItems, RescuerStatusFilter selectedStatus, int? deletingRescuerId
});




}
/// @nodoc
class _$RescuerListStateDataCopyWithImpl<$Res>
    implements $RescuerListStateDataCopyWith<$Res> {
  _$RescuerListStateDataCopyWithImpl(this._self, this._then);

  final RescuerListStateData _self;
  final $Res Function(RescuerListStateData) _then;

/// Create a copy of RescuerListStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? filteredItems = null,Object? selectedStatus = null,Object? deletingRescuerId = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<RescuerEntity>,filteredItems: null == filteredItems ? _self.filteredItems : filteredItems // ignore: cast_nullable_to_non_nullable
as List<RescuerEntity>,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as RescuerStatusFilter,deletingRescuerId: freezed == deletingRescuerId ? _self.deletingRescuerId : deletingRescuerId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RescuerListStateData].
extension RescuerListStateDataPatterns on RescuerListStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RescuerListStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RescuerListStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RescuerListStateData value)  $default,){
final _that = this;
switch (_that) {
case _RescuerListStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RescuerListStateData value)?  $default,){
final _that = this;
switch (_that) {
case _RescuerListStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RescuerEntity> items,  List<RescuerEntity> filteredItems,  RescuerStatusFilter selectedStatus,  int? deletingRescuerId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RescuerListStateData() when $default != null:
return $default(_that.items,_that.filteredItems,_that.selectedStatus,_that.deletingRescuerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RescuerEntity> items,  List<RescuerEntity> filteredItems,  RescuerStatusFilter selectedStatus,  int? deletingRescuerId)  $default,) {final _that = this;
switch (_that) {
case _RescuerListStateData():
return $default(_that.items,_that.filteredItems,_that.selectedStatus,_that.deletingRescuerId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RescuerEntity> items,  List<RescuerEntity> filteredItems,  RescuerStatusFilter selectedStatus,  int? deletingRescuerId)?  $default,) {final _that = this;
switch (_that) {
case _RescuerListStateData() when $default != null:
return $default(_that.items,_that.filteredItems,_that.selectedStatus,_that.deletingRescuerId);case _:
  return null;

}
}

}

/// @nodoc


class _RescuerListStateData implements RescuerListStateData {
  const _RescuerListStateData({final  List<RescuerEntity> items = const [], final  List<RescuerEntity> filteredItems = const [], this.selectedStatus = RescuerStatusFilter.all, this.deletingRescuerId}): _items = items,_filteredItems = filteredItems;
  

 final  List<RescuerEntity> _items;
@override@JsonKey() List<RescuerEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<RescuerEntity> _filteredItems;
@override@JsonKey() List<RescuerEntity> get filteredItems {
  if (_filteredItems is EqualUnmodifiableListView) return _filteredItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredItems);
}

@override@JsonKey() final  RescuerStatusFilter selectedStatus;
@override final  int? deletingRescuerId;

/// Create a copy of RescuerListStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RescuerListStateDataCopyWith<_RescuerListStateData> get copyWith => __$RescuerListStateDataCopyWithImpl<_RescuerListStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RescuerListStateData&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._filteredItems, _filteredItems)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.deletingRescuerId, deletingRescuerId) || other.deletingRescuerId == deletingRescuerId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_filteredItems),selectedStatus,deletingRescuerId);

@override
String toString() {
  return 'RescuerListStateData(items: $items, filteredItems: $filteredItems, selectedStatus: $selectedStatus, deletingRescuerId: $deletingRescuerId)';
}


}

/// @nodoc
abstract mixin class _$RescuerListStateDataCopyWith<$Res> implements $RescuerListStateDataCopyWith<$Res> {
  factory _$RescuerListStateDataCopyWith(_RescuerListStateData value, $Res Function(_RescuerListStateData) _then) = __$RescuerListStateDataCopyWithImpl;
@override @useResult
$Res call({
 List<RescuerEntity> items, List<RescuerEntity> filteredItems, RescuerStatusFilter selectedStatus, int? deletingRescuerId
});




}
/// @nodoc
class __$RescuerListStateDataCopyWithImpl<$Res>
    implements _$RescuerListStateDataCopyWith<$Res> {
  __$RescuerListStateDataCopyWithImpl(this._self, this._then);

  final _RescuerListStateData _self;
  final $Res Function(_RescuerListStateData) _then;

/// Create a copy of RescuerListStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? filteredItems = null,Object? selectedStatus = null,Object? deletingRescuerId = freezed,}) {
  return _then(_RescuerListStateData(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RescuerEntity>,filteredItems: null == filteredItems ? _self._filteredItems : filteredItems // ignore: cast_nullable_to_non_nullable
as List<RescuerEntity>,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as RescuerStatusFilter,deletingRescuerId: freezed == deletingRescuerId ? _self.deletingRescuerId : deletingRescuerId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$RescuerListState {

 RescuerListStateData get data;
/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RescuerListStateCopyWith<RescuerListState> get copyWith => _$RescuerListStateCopyWithImpl<RescuerListState>(this as RescuerListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RescuerListState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'RescuerListState(data: $data)';
}


}

/// @nodoc
abstract mixin class $RescuerListStateCopyWith<$Res>  {
  factory $RescuerListStateCopyWith(RescuerListState value, $Res Function(RescuerListState) _then) = _$RescuerListStateCopyWithImpl;
@useResult
$Res call({
 RescuerListStateData data
});


$RescuerListStateDataCopyWith<$Res> get data;

}
/// @nodoc
class _$RescuerListStateCopyWithImpl<$Res>
    implements $RescuerListStateCopyWith<$Res> {
  _$RescuerListStateCopyWithImpl(this._self, this._then);

  final RescuerListState _self;
  final $Res Function(RescuerListState) _then;

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerListStateData,
  ));
}
/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<$Res> get data {
  
  return $RescuerListStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [RescuerListState].
extension RescuerListStatePatterns on RescuerListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _ActionLoading value)?  actionLoading,TResult Function( _Error value)?  error,TResult Function( _ActionError value)?  actionError,TResult Function( _ConnectionError value)?  connectionError,required TResult orElse(),}){
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _ActionLoading value)  actionLoading,required TResult Function( _Error value)  error,required TResult Function( _ActionError value)  actionError,required TResult Function( _ConnectionError value)  connectionError,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _ActionLoading():
return actionLoading(_that);case _Error():
return error(_that);case _ActionError():
return actionError(_that);case _ConnectionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _ActionLoading value)?  actionLoading,TResult? Function( _Error value)?  error,TResult? Function( _ActionError value)?  actionError,TResult? Function( _ConnectionError value)?  connectionError,}){
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RescuerListStateData data)?  idle,TResult Function( RescuerListStateData data)?  loading,TResult Function( RescuerListStateData data)?  loaded,TResult Function( RescuerListStateData data)?  actionLoading,TResult Function( RescuerListStateData data,  BottomSheetMessageModel message)?  error,TResult Function( RescuerListStateData data,  String message)?  actionError,TResult Function( RescuerListStateData data)?  connectionError,required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RescuerListStateData data)  idle,required TResult Function( RescuerListStateData data)  loading,required TResult Function( RescuerListStateData data)  loaded,required TResult Function( RescuerListStateData data)  actionLoading,required TResult Function( RescuerListStateData data,  BottomSheetMessageModel message)  error,required TResult Function( RescuerListStateData data,  String message)  actionError,required TResult Function( RescuerListStateData data)  connectionError,}) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RescuerListStateData data)?  idle,TResult? Function( RescuerListStateData data)?  loading,TResult? Function( RescuerListStateData data)?  loaded,TResult? Function( RescuerListStateData data)?  actionLoading,TResult? Function( RescuerListStateData data,  BottomSheetMessageModel message)?  error,TResult? Function( RescuerListStateData data,  String message)?  actionError,TResult? Function( RescuerListStateData data)?  connectionError,}) {final _that = this;
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


class _Idle implements RescuerListState {
  const _Idle({this.data = const RescuerListStateData()});
  

@override@JsonKey() final  RescuerListStateData data;

/// Create a copy of RescuerListState
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
  return 'RescuerListState.idle(data: $data)';
}


}

/// @nodoc
abstract mixin class _$IdleCopyWith<$Res> implements $RescuerListStateCopyWith<$Res> {
  factory _$IdleCopyWith(_Idle value, $Res Function(_Idle) _then) = __$IdleCopyWithImpl;
@override @useResult
$Res call({
 RescuerListStateData data
});


@override $RescuerListStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$IdleCopyWithImpl<$Res>
    implements _$IdleCopyWith<$Res> {
  __$IdleCopyWithImpl(this._self, this._then);

  final _Idle _self;
  final $Res Function(_Idle) _then;

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Idle(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerListStateData,
  ));
}

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<$Res> get data {
  
  return $RescuerListStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loading implements RescuerListState {
  const _Loading({required this.data});
  

@override final  RescuerListStateData data;

/// Create a copy of RescuerListState
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
  return 'RescuerListState.loading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $RescuerListStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 RescuerListStateData data
});


@override $RescuerListStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerListStateData,
  ));
}

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<$Res> get data {
  
  return $RescuerListStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loaded implements RescuerListState {
  const _Loaded({required this.data});
  

@override final  RescuerListStateData data;

/// Create a copy of RescuerListState
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
  return 'RescuerListState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $RescuerListStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
 RescuerListStateData data
});


@override $RescuerListStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerListStateData,
  ));
}

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<$Res> get data {
  
  return $RescuerListStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _ActionLoading implements RescuerListState {
  const _ActionLoading({required this.data});
  

@override final  RescuerListStateData data;

/// Create a copy of RescuerListState
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
  return 'RescuerListState.actionLoading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ActionLoadingCopyWith<$Res> implements $RescuerListStateCopyWith<$Res> {
  factory _$ActionLoadingCopyWith(_ActionLoading value, $Res Function(_ActionLoading) _then) = __$ActionLoadingCopyWithImpl;
@override @useResult
$Res call({
 RescuerListStateData data
});


@override $RescuerListStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ActionLoadingCopyWithImpl<$Res>
    implements _$ActionLoadingCopyWith<$Res> {
  __$ActionLoadingCopyWithImpl(this._self, this._then);

  final _ActionLoading _self;
  final $Res Function(_ActionLoading) _then;

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ActionLoading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerListStateData,
  ));
}

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<$Res> get data {
  
  return $RescuerListStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Error implements RescuerListState {
  const _Error({required this.data, required this.message});
  

@override final  RescuerListStateData data;
 final  BottomSheetMessageModel message;

/// Create a copy of RescuerListState
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
  return 'RescuerListState.error(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $RescuerListStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@override @useResult
$Res call({
 RescuerListStateData data, BottomSheetMessageModel message
});


@override $RescuerListStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
  return _then(_Error(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerListStateData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<$Res> get data {
  
  return $RescuerListStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _ActionError implements RescuerListState {
  const _ActionError({required this.data, required this.message});
  

@override final  RescuerListStateData data;
 final  String message;

/// Create a copy of RescuerListState
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
  return 'RescuerListState.actionError(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ActionErrorCopyWith<$Res> implements $RescuerListStateCopyWith<$Res> {
  factory _$ActionErrorCopyWith(_ActionError value, $Res Function(_ActionError) _then) = __$ActionErrorCopyWithImpl;
@override @useResult
$Res call({
 RescuerListStateData data, String message
});


@override $RescuerListStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ActionErrorCopyWithImpl<$Res>
    implements _$ActionErrorCopyWith<$Res> {
  __$ActionErrorCopyWithImpl(this._self, this._then);

  final _ActionError _self;
  final $Res Function(_ActionError) _then;

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
  return _then(_ActionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerListStateData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<$Res> get data {
  
  return $RescuerListStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _ConnectionError implements RescuerListState {
  const _ConnectionError({required this.data});
  

@override final  RescuerListStateData data;

/// Create a copy of RescuerListState
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
  return 'RescuerListState.connectionError(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $RescuerListStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@override @useResult
$Res call({
 RescuerListStateData data
});


@override $RescuerListStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ConnectionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as RescuerListStateData,
  ));
}

/// Create a copy of RescuerListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RescuerListStateDataCopyWith<$Res> get data {
  
  return $RescuerListStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
