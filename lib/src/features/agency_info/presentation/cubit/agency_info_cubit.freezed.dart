// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_info_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AgencyInfoStateData {

 List<AgencyInfoEntity> get items; List<AgencyInfoEntity> get selectorItems; AgencyInfoEntity? get selectedAgency; AgencyInfoFilterParamEntity get filter; int get totalCount; bool get hasMore; bool get isInitialLoading; bool get isRefreshing; bool get isPaginationLoading; bool get isSelectorLoading; int? get loadingDetailId; String get selectorSearchText; String? get errorMessage;
/// Create a copy of AgencyInfoStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgencyInfoStateDataCopyWith<AgencyInfoStateData> get copyWith => _$AgencyInfoStateDataCopyWithImpl<AgencyInfoStateData>(this as AgencyInfoStateData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgencyInfoStateData&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.selectorItems, selectorItems)&&(identical(other.selectedAgency, selectedAgency) || other.selectedAgency == selectedAgency)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isPaginationLoading, isPaginationLoading) || other.isPaginationLoading == isPaginationLoading)&&(identical(other.isSelectorLoading, isSelectorLoading) || other.isSelectorLoading == isSelectorLoading)&&(identical(other.loadingDetailId, loadingDetailId) || other.loadingDetailId == loadingDetailId)&&(identical(other.selectorSearchText, selectorSearchText) || other.selectorSearchText == selectorSearchText)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(selectorItems),selectedAgency,filter,totalCount,hasMore,isInitialLoading,isRefreshing,isPaginationLoading,isSelectorLoading,loadingDetailId,selectorSearchText,errorMessage);

@override
String toString() {
  return 'AgencyInfoStateData(items: $items, selectorItems: $selectorItems, selectedAgency: $selectedAgency, filter: $filter, totalCount: $totalCount, hasMore: $hasMore, isInitialLoading: $isInitialLoading, isRefreshing: $isRefreshing, isPaginationLoading: $isPaginationLoading, isSelectorLoading: $isSelectorLoading, loadingDetailId: $loadingDetailId, selectorSearchText: $selectorSearchText, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AgencyInfoStateDataCopyWith<$Res>  {
  factory $AgencyInfoStateDataCopyWith(AgencyInfoStateData value, $Res Function(AgencyInfoStateData) _then) = _$AgencyInfoStateDataCopyWithImpl;
@useResult
$Res call({
 List<AgencyInfoEntity> items, List<AgencyInfoEntity> selectorItems, AgencyInfoEntity? selectedAgency, AgencyInfoFilterParamEntity filter, int totalCount, bool hasMore, bool isInitialLoading, bool isRefreshing, bool isPaginationLoading, bool isSelectorLoading, int? loadingDetailId, String selectorSearchText, String? errorMessage
});




}
/// @nodoc
class _$AgencyInfoStateDataCopyWithImpl<$Res>
    implements $AgencyInfoStateDataCopyWith<$Res> {
  _$AgencyInfoStateDataCopyWithImpl(this._self, this._then);

  final AgencyInfoStateData _self;
  final $Res Function(AgencyInfoStateData) _then;

/// Create a copy of AgencyInfoStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? selectorItems = null,Object? selectedAgency = freezed,Object? filter = null,Object? totalCount = null,Object? hasMore = null,Object? isInitialLoading = null,Object? isRefreshing = null,Object? isPaginationLoading = null,Object? isSelectorLoading = null,Object? loadingDetailId = freezed,Object? selectorSearchText = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AgencyInfoEntity>,selectorItems: null == selectorItems ? _self.selectorItems : selectorItems // ignore: cast_nullable_to_non_nullable
as List<AgencyInfoEntity>,selectedAgency: freezed == selectedAgency ? _self.selectedAgency : selectedAgency // ignore: cast_nullable_to_non_nullable
as AgencyInfoEntity?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as AgencyInfoFilterParamEntity,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isPaginationLoading: null == isPaginationLoading ? _self.isPaginationLoading : isPaginationLoading // ignore: cast_nullable_to_non_nullable
as bool,isSelectorLoading: null == isSelectorLoading ? _self.isSelectorLoading : isSelectorLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingDetailId: freezed == loadingDetailId ? _self.loadingDetailId : loadingDetailId // ignore: cast_nullable_to_non_nullable
as int?,selectorSearchText: null == selectorSearchText ? _self.selectorSearchText : selectorSearchText // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AgencyInfoStateData].
extension AgencyInfoStateDataPatterns on AgencyInfoStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgencyInfoStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgencyInfoStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgencyInfoStateData value)  $default,){
final _that = this;
switch (_that) {
case _AgencyInfoStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgencyInfoStateData value)?  $default,){
final _that = this;
switch (_that) {
case _AgencyInfoStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AgencyInfoEntity> items,  List<AgencyInfoEntity> selectorItems,  AgencyInfoEntity? selectedAgency,  AgencyInfoFilterParamEntity filter,  int totalCount,  bool hasMore,  bool isInitialLoading,  bool isRefreshing,  bool isPaginationLoading,  bool isSelectorLoading,  int? loadingDetailId,  String selectorSearchText,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgencyInfoStateData() when $default != null:
return $default(_that.items,_that.selectorItems,_that.selectedAgency,_that.filter,_that.totalCount,_that.hasMore,_that.isInitialLoading,_that.isRefreshing,_that.isPaginationLoading,_that.isSelectorLoading,_that.loadingDetailId,_that.selectorSearchText,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AgencyInfoEntity> items,  List<AgencyInfoEntity> selectorItems,  AgencyInfoEntity? selectedAgency,  AgencyInfoFilterParamEntity filter,  int totalCount,  bool hasMore,  bool isInitialLoading,  bool isRefreshing,  bool isPaginationLoading,  bool isSelectorLoading,  int? loadingDetailId,  String selectorSearchText,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AgencyInfoStateData():
return $default(_that.items,_that.selectorItems,_that.selectedAgency,_that.filter,_that.totalCount,_that.hasMore,_that.isInitialLoading,_that.isRefreshing,_that.isPaginationLoading,_that.isSelectorLoading,_that.loadingDetailId,_that.selectorSearchText,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AgencyInfoEntity> items,  List<AgencyInfoEntity> selectorItems,  AgencyInfoEntity? selectedAgency,  AgencyInfoFilterParamEntity filter,  int totalCount,  bool hasMore,  bool isInitialLoading,  bool isRefreshing,  bool isPaginationLoading,  bool isSelectorLoading,  int? loadingDetailId,  String selectorSearchText,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AgencyInfoStateData() when $default != null:
return $default(_that.items,_that.selectorItems,_that.selectedAgency,_that.filter,_that.totalCount,_that.hasMore,_that.isInitialLoading,_that.isRefreshing,_that.isPaginationLoading,_that.isSelectorLoading,_that.loadingDetailId,_that.selectorSearchText,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AgencyInfoStateData implements AgencyInfoStateData {
  const _AgencyInfoStateData({final  List<AgencyInfoEntity> items = const [], final  List<AgencyInfoEntity> selectorItems = const [], this.selectedAgency, this.filter = const AgencyInfoFilterParamEntity(), this.totalCount = 0, this.hasMore = true, this.isInitialLoading = false, this.isRefreshing = false, this.isPaginationLoading = false, this.isSelectorLoading = false, this.loadingDetailId, this.selectorSearchText = '', this.errorMessage}): _items = items,_selectorItems = selectorItems;
  

 final  List<AgencyInfoEntity> _items;
@override@JsonKey() List<AgencyInfoEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<AgencyInfoEntity> _selectorItems;
@override@JsonKey() List<AgencyInfoEntity> get selectorItems {
  if (_selectorItems is EqualUnmodifiableListView) return _selectorItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectorItems);
}

@override final  AgencyInfoEntity? selectedAgency;
@override@JsonKey() final  AgencyInfoFilterParamEntity filter;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isPaginationLoading;
@override@JsonKey() final  bool isSelectorLoading;
@override final  int? loadingDetailId;
@override@JsonKey() final  String selectorSearchText;
@override final  String? errorMessage;

/// Create a copy of AgencyInfoStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgencyInfoStateDataCopyWith<_AgencyInfoStateData> get copyWith => __$AgencyInfoStateDataCopyWithImpl<_AgencyInfoStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgencyInfoStateData&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._selectorItems, _selectorItems)&&(identical(other.selectedAgency, selectedAgency) || other.selectedAgency == selectedAgency)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isPaginationLoading, isPaginationLoading) || other.isPaginationLoading == isPaginationLoading)&&(identical(other.isSelectorLoading, isSelectorLoading) || other.isSelectorLoading == isSelectorLoading)&&(identical(other.loadingDetailId, loadingDetailId) || other.loadingDetailId == loadingDetailId)&&(identical(other.selectorSearchText, selectorSearchText) || other.selectorSearchText == selectorSearchText)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_selectorItems),selectedAgency,filter,totalCount,hasMore,isInitialLoading,isRefreshing,isPaginationLoading,isSelectorLoading,loadingDetailId,selectorSearchText,errorMessage);

@override
String toString() {
  return 'AgencyInfoStateData(items: $items, selectorItems: $selectorItems, selectedAgency: $selectedAgency, filter: $filter, totalCount: $totalCount, hasMore: $hasMore, isInitialLoading: $isInitialLoading, isRefreshing: $isRefreshing, isPaginationLoading: $isPaginationLoading, isSelectorLoading: $isSelectorLoading, loadingDetailId: $loadingDetailId, selectorSearchText: $selectorSearchText, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AgencyInfoStateDataCopyWith<$Res> implements $AgencyInfoStateDataCopyWith<$Res> {
  factory _$AgencyInfoStateDataCopyWith(_AgencyInfoStateData value, $Res Function(_AgencyInfoStateData) _then) = __$AgencyInfoStateDataCopyWithImpl;
@override @useResult
$Res call({
 List<AgencyInfoEntity> items, List<AgencyInfoEntity> selectorItems, AgencyInfoEntity? selectedAgency, AgencyInfoFilterParamEntity filter, int totalCount, bool hasMore, bool isInitialLoading, bool isRefreshing, bool isPaginationLoading, bool isSelectorLoading, int? loadingDetailId, String selectorSearchText, String? errorMessage
});




}
/// @nodoc
class __$AgencyInfoStateDataCopyWithImpl<$Res>
    implements _$AgencyInfoStateDataCopyWith<$Res> {
  __$AgencyInfoStateDataCopyWithImpl(this._self, this._then);

  final _AgencyInfoStateData _self;
  final $Res Function(_AgencyInfoStateData) _then;

/// Create a copy of AgencyInfoStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? selectorItems = null,Object? selectedAgency = freezed,Object? filter = null,Object? totalCount = null,Object? hasMore = null,Object? isInitialLoading = null,Object? isRefreshing = null,Object? isPaginationLoading = null,Object? isSelectorLoading = null,Object? loadingDetailId = freezed,Object? selectorSearchText = null,Object? errorMessage = freezed,}) {
  return _then(_AgencyInfoStateData(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AgencyInfoEntity>,selectorItems: null == selectorItems ? _self._selectorItems : selectorItems // ignore: cast_nullable_to_non_nullable
as List<AgencyInfoEntity>,selectedAgency: freezed == selectedAgency ? _self.selectedAgency : selectedAgency // ignore: cast_nullable_to_non_nullable
as AgencyInfoEntity?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as AgencyInfoFilterParamEntity,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isPaginationLoading: null == isPaginationLoading ? _self.isPaginationLoading : isPaginationLoading // ignore: cast_nullable_to_non_nullable
as bool,isSelectorLoading: null == isSelectorLoading ? _self.isSelectorLoading : isSelectorLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingDetailId: freezed == loadingDetailId ? _self.loadingDetailId : loadingDetailId // ignore: cast_nullable_to_non_nullable
as int?,selectorSearchText: null == selectorSearchText ? _self.selectorSearchText : selectorSearchText // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AgencyInfoState {

 AgencyInfoStateData get data;
/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgencyInfoStateCopyWith<AgencyInfoState> get copyWith => _$AgencyInfoStateCopyWithImpl<AgencyInfoState>(this as AgencyInfoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgencyInfoState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AgencyInfoState(data: $data)';
}


}

/// @nodoc
abstract mixin class $AgencyInfoStateCopyWith<$Res>  {
  factory $AgencyInfoStateCopyWith(AgencyInfoState value, $Res Function(AgencyInfoState) _then) = _$AgencyInfoStateCopyWithImpl;
@useResult
$Res call({
 AgencyInfoStateData data
});


$AgencyInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class _$AgencyInfoStateCopyWithImpl<$Res>
    implements $AgencyInfoStateCopyWith<$Res> {
  _$AgencyInfoStateCopyWithImpl(this._self, this._then);

  final AgencyInfoState _self;
  final $Res Function(AgencyInfoState) _then;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AgencyInfoStateData,
  ));
}
/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgencyInfoStateDataCopyWith<$Res> get data {
  
  return $AgencyInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AgencyInfoState].
extension AgencyInfoStatePatterns on AgencyInfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Empty value)?  empty,TResult Function( _Failure value)?  failure,TResult Function( _ConnectionError value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Empty() when empty != null:
return empty(_that);case _Failure() when failure != null:
return failure(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Empty value)  empty,required TResult Function( _Failure value)  failure,required TResult Function( _ConnectionError value)  connectionError,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Empty():
return empty(_that);case _Failure():
return failure(_that);case _ConnectionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Empty value)?  empty,TResult? Function( _Failure value)?  failure,TResult? Function( _ConnectionError value)?  connectionError,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Empty() when empty != null:
return empty(_that);case _Failure() when failure != null:
return failure(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AgencyInfoStateData data)?  idle,TResult Function( AgencyInfoStateData data)?  loading,TResult Function( AgencyInfoStateData data)?  loaded,TResult Function( AgencyInfoStateData data)?  empty,TResult Function( AgencyInfoStateData data)?  failure,TResult Function( AgencyInfoStateData data)?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Empty() when empty != null:
return empty(_that.data);case _Failure() when failure != null:
return failure(_that.data);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AgencyInfoStateData data)  idle,required TResult Function( AgencyInfoStateData data)  loading,required TResult Function( AgencyInfoStateData data)  loaded,required TResult Function( AgencyInfoStateData data)  empty,required TResult Function( AgencyInfoStateData data)  failure,required TResult Function( AgencyInfoStateData data)  connectionError,}) {final _that = this;
switch (_that) {
case _Idle():
return idle(_that.data);case _Loading():
return loading(_that.data);case _Loaded():
return loaded(_that.data);case _Empty():
return empty(_that.data);case _Failure():
return failure(_that.data);case _ConnectionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AgencyInfoStateData data)?  idle,TResult? Function( AgencyInfoStateData data)?  loading,TResult? Function( AgencyInfoStateData data)?  loaded,TResult? Function( AgencyInfoStateData data)?  empty,TResult? Function( AgencyInfoStateData data)?  failure,TResult? Function( AgencyInfoStateData data)?  connectionError,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Empty() when empty != null:
return empty(_that.data);case _Failure() when failure != null:
return failure(_that.data);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements AgencyInfoState {
  const _Idle({this.data = const AgencyInfoStateData()});
  

@override@JsonKey() final  AgencyInfoStateData data;

/// Create a copy of AgencyInfoState
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
  return 'AgencyInfoState.idle(data: $data)';
}


}

/// @nodoc
abstract mixin class _$IdleCopyWith<$Res> implements $AgencyInfoStateCopyWith<$Res> {
  factory _$IdleCopyWith(_Idle value, $Res Function(_Idle) _then) = __$IdleCopyWithImpl;
@override @useResult
$Res call({
 AgencyInfoStateData data
});


@override $AgencyInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$IdleCopyWithImpl<$Res>
    implements _$IdleCopyWith<$Res> {
  __$IdleCopyWithImpl(this._self, this._then);

  final _Idle _self;
  final $Res Function(_Idle) _then;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Idle(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AgencyInfoStateData,
  ));
}

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgencyInfoStateDataCopyWith<$Res> get data {
  
  return $AgencyInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loading implements AgencyInfoState {
  const _Loading({required this.data});
  

@override final  AgencyInfoStateData data;

/// Create a copy of AgencyInfoState
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
  return 'AgencyInfoState.loading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $AgencyInfoStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 AgencyInfoStateData data
});


@override $AgencyInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AgencyInfoStateData,
  ));
}

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgencyInfoStateDataCopyWith<$Res> get data {
  
  return $AgencyInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loaded implements AgencyInfoState {
  const _Loaded({required this.data});
  

@override final  AgencyInfoStateData data;

/// Create a copy of AgencyInfoState
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
  return 'AgencyInfoState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AgencyInfoStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
 AgencyInfoStateData data
});


@override $AgencyInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AgencyInfoStateData,
  ));
}

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgencyInfoStateDataCopyWith<$Res> get data {
  
  return $AgencyInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Empty implements AgencyInfoState {
  const _Empty({required this.data});
  

@override final  AgencyInfoStateData data;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmptyCopyWith<_Empty> get copyWith => __$EmptyCopyWithImpl<_Empty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Empty&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AgencyInfoState.empty(data: $data)';
}


}

/// @nodoc
abstract mixin class _$EmptyCopyWith<$Res> implements $AgencyInfoStateCopyWith<$Res> {
  factory _$EmptyCopyWith(_Empty value, $Res Function(_Empty) _then) = __$EmptyCopyWithImpl;
@override @useResult
$Res call({
 AgencyInfoStateData data
});


@override $AgencyInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$EmptyCopyWithImpl<$Res>
    implements _$EmptyCopyWith<$Res> {
  __$EmptyCopyWithImpl(this._self, this._then);

  final _Empty _self;
  final $Res Function(_Empty) _then;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Empty(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AgencyInfoStateData,
  ));
}

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgencyInfoStateDataCopyWith<$Res> get data {
  
  return $AgencyInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Failure implements AgencyInfoState {
  const _Failure({required this.data});
  

@override final  AgencyInfoStateData data;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'AgencyInfoState.failure(data: $data)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $AgencyInfoStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@override @useResult
$Res call({
 AgencyInfoStateData data
});


@override $AgencyInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Failure(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AgencyInfoStateData,
  ));
}

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgencyInfoStateDataCopyWith<$Res> get data {
  
  return $AgencyInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _ConnectionError implements AgencyInfoState {
  const _ConnectionError({required this.data});
  

@override final  AgencyInfoStateData data;

/// Create a copy of AgencyInfoState
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
  return 'AgencyInfoState.connectionError(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $AgencyInfoStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@override @useResult
$Res call({
 AgencyInfoStateData data
});


@override $AgencyInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ConnectionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AgencyInfoStateData,
  ));
}

/// Create a copy of AgencyInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgencyInfoStateDataCopyWith<$Res> get data {
  
  return $AgencyInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
