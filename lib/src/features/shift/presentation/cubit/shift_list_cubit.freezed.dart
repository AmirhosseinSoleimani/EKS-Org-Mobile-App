// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShiftListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShiftListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShiftListState()';
}


}

/// @nodoc
class $ShiftListStateCopyWith<$Res>  {
$ShiftListStateCopyWith(ShiftListState _, $Res Function(ShiftListState) __);
}


/// Adds pattern-matching-related methods to [ShiftListState].
extension ShiftListStatePatterns on ShiftListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Empty value)?  empty,TResult Function( _LoadingMore value)?  loadingMore,TResult Function( _Deleting value)?  deleting,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,TResult Function( _ConnectionError value)?  connectionError,TResult Function( _Exporting value)?  exporting,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Empty() when empty != null:
return empty(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _Deleting() when deleting != null:
return deleting(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _Exporting() when exporting != null:
return exporting(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Empty value)  empty,required TResult Function( _LoadingMore value)  loadingMore,required TResult Function( _Deleting value)  deleting,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,required TResult Function( _ConnectionError value)  connectionError,required TResult Function( _Exporting value)  exporting,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Empty():
return empty(_that);case _LoadingMore():
return loadingMore(_that);case _Deleting():
return deleting(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _ConnectionError():
return connectionError(_that);case _Exporting():
return exporting(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Empty value)?  empty,TResult? Function( _LoadingMore value)?  loadingMore,TResult? Function( _Deleting value)?  deleting,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,TResult? Function( _ConnectionError value)?  connectionError,TResult? Function( _Exporting value)?  exporting,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Empty() when empty != null:
return empty(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _Deleting() when deleting != null:
return deleting(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _ConnectionError() when connectionError != null:
return connectionError(_that);case _Exporting() when exporting != null:
return exporting(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( ShiftFilterParamEntity filter)?  loading,TResult Function( List<ShiftEntity> items,  int totalCount,  bool hasMore,  ShiftFilterParamEntity filter)?  loaded,TResult Function( ShiftFilterParamEntity filter)?  empty,TResult Function( List<ShiftEntity> items,  int totalCount,  ShiftFilterParamEntity filter)?  loadingMore,TResult Function( List<ShiftEntity> items,  int deletingItemId)?  deleting,TResult Function( ShiftListAction action,  String message)?  success,TResult Function( String message,  List<ShiftEntity> items)?  failure,TResult Function( ShiftFilterParamEntity filter,  List<ShiftEntity> items)?  connectionError,TResult Function( List<ShiftEntity> items,  ShiftFilterParamEntity filter)?  exporting,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.filter);case _Loaded() when loaded != null:
return loaded(_that.items,_that.totalCount,_that.hasMore,_that.filter);case _Empty() when empty != null:
return empty(_that.filter);case _LoadingMore() when loadingMore != null:
return loadingMore(_that.items,_that.totalCount,_that.filter);case _Deleting() when deleting != null:
return deleting(_that.items,_that.deletingItemId);case _Success() when success != null:
return success(_that.action,_that.message);case _Failure() when failure != null:
return failure(_that.message,_that.items);case _ConnectionError() when connectionError != null:
return connectionError(_that.filter,_that.items);case _Exporting() when exporting != null:
return exporting(_that.items,_that.filter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( ShiftFilterParamEntity filter)  loading,required TResult Function( List<ShiftEntity> items,  int totalCount,  bool hasMore,  ShiftFilterParamEntity filter)  loaded,required TResult Function( ShiftFilterParamEntity filter)  empty,required TResult Function( List<ShiftEntity> items,  int totalCount,  ShiftFilterParamEntity filter)  loadingMore,required TResult Function( List<ShiftEntity> items,  int deletingItemId)  deleting,required TResult Function( ShiftListAction action,  String message)  success,required TResult Function( String message,  List<ShiftEntity> items)  failure,required TResult Function( ShiftFilterParamEntity filter,  List<ShiftEntity> items)  connectionError,required TResult Function( List<ShiftEntity> items,  ShiftFilterParamEntity filter)  exporting,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading(_that.filter);case _Loaded():
return loaded(_that.items,_that.totalCount,_that.hasMore,_that.filter);case _Empty():
return empty(_that.filter);case _LoadingMore():
return loadingMore(_that.items,_that.totalCount,_that.filter);case _Deleting():
return deleting(_that.items,_that.deletingItemId);case _Success():
return success(_that.action,_that.message);case _Failure():
return failure(_that.message,_that.items);case _ConnectionError():
return connectionError(_that.filter,_that.items);case _Exporting():
return exporting(_that.items,_that.filter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( ShiftFilterParamEntity filter)?  loading,TResult? Function( List<ShiftEntity> items,  int totalCount,  bool hasMore,  ShiftFilterParamEntity filter)?  loaded,TResult? Function( ShiftFilterParamEntity filter)?  empty,TResult? Function( List<ShiftEntity> items,  int totalCount,  ShiftFilterParamEntity filter)?  loadingMore,TResult? Function( List<ShiftEntity> items,  int deletingItemId)?  deleting,TResult? Function( ShiftListAction action,  String message)?  success,TResult? Function( String message,  List<ShiftEntity> items)?  failure,TResult? Function( ShiftFilterParamEntity filter,  List<ShiftEntity> items)?  connectionError,TResult? Function( List<ShiftEntity> items,  ShiftFilterParamEntity filter)?  exporting,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.filter);case _Loaded() when loaded != null:
return loaded(_that.items,_that.totalCount,_that.hasMore,_that.filter);case _Empty() when empty != null:
return empty(_that.filter);case _LoadingMore() when loadingMore != null:
return loadingMore(_that.items,_that.totalCount,_that.filter);case _Deleting() when deleting != null:
return deleting(_that.items,_that.deletingItemId);case _Success() when success != null:
return success(_that.action,_that.message);case _Failure() when failure != null:
return failure(_that.message,_that.items);case _ConnectionError() when connectionError != null:
return connectionError(_that.filter,_that.items);case _Exporting() when exporting != null:
return exporting(_that.items,_that.filter);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ShiftListState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShiftListState.initial()';
}


}




/// @nodoc


class _Loading implements ShiftListState {
  const _Loading({required this.filter});
  

 final  ShiftFilterParamEntity filter;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'ShiftListState.loading(filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@useResult
$Res call({
 ShiftFilterParamEntity filter
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(_Loading(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ShiftFilterParamEntity,
  ));
}


}

/// @nodoc


class _Loaded implements ShiftListState {
  const _Loaded({required final  List<ShiftEntity> items, required this.totalCount, required this.hasMore, required this.filter}): _items = items;
  

 final  List<ShiftEntity> _items;
 List<ShiftEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int totalCount;
 final  bool hasMore;
 final  ShiftFilterParamEntity filter;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,hasMore,filter);

@override
String toString() {
  return 'ShiftListState.loaded(items: $items, totalCount: $totalCount, hasMore: $hasMore, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<ShiftEntity> items, int totalCount, bool hasMore, ShiftFilterParamEntity filter
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? hasMore = null,Object? filter = null,}) {
  return _then(_Loaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ShiftEntity>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ShiftFilterParamEntity,
  ));
}


}

/// @nodoc


class _Empty implements ShiftListState {
  const _Empty({required this.filter});
  

 final  ShiftFilterParamEntity filter;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmptyCopyWith<_Empty> get copyWith => __$EmptyCopyWithImpl<_Empty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Empty&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'ShiftListState.empty(filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$EmptyCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$EmptyCopyWith(_Empty value, $Res Function(_Empty) _then) = __$EmptyCopyWithImpl;
@useResult
$Res call({
 ShiftFilterParamEntity filter
});




}
/// @nodoc
class __$EmptyCopyWithImpl<$Res>
    implements _$EmptyCopyWith<$Res> {
  __$EmptyCopyWithImpl(this._self, this._then);

  final _Empty _self;
  final $Res Function(_Empty) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(_Empty(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ShiftFilterParamEntity,
  ));
}


}

/// @nodoc


class _LoadingMore implements ShiftListState {
  const _LoadingMore({required final  List<ShiftEntity> items, required this.totalCount, required this.filter}): _items = items;
  

 final  List<ShiftEntity> _items;
 List<ShiftEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int totalCount;
 final  ShiftFilterParamEntity filter;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingMoreCopyWith<_LoadingMore> get copyWith => __$LoadingMoreCopyWithImpl<_LoadingMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingMore&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,filter);

@override
String toString() {
  return 'ShiftListState.loadingMore(items: $items, totalCount: $totalCount, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$LoadingMoreCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$LoadingMoreCopyWith(_LoadingMore value, $Res Function(_LoadingMore) _then) = __$LoadingMoreCopyWithImpl;
@useResult
$Res call({
 List<ShiftEntity> items, int totalCount, ShiftFilterParamEntity filter
});




}
/// @nodoc
class __$LoadingMoreCopyWithImpl<$Res>
    implements _$LoadingMoreCopyWith<$Res> {
  __$LoadingMoreCopyWithImpl(this._self, this._then);

  final _LoadingMore _self;
  final $Res Function(_LoadingMore) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? filter = null,}) {
  return _then(_LoadingMore(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ShiftEntity>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ShiftFilterParamEntity,
  ));
}


}

/// @nodoc


class _Deleting implements ShiftListState {
  const _Deleting({required final  List<ShiftEntity> items, required this.deletingItemId}): _items = items;
  

 final  List<ShiftEntity> _items;
 List<ShiftEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int deletingItemId;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeletingCopyWith<_Deleting> get copyWith => __$DeletingCopyWithImpl<_Deleting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Deleting&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.deletingItemId, deletingItemId) || other.deletingItemId == deletingItemId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),deletingItemId);

@override
String toString() {
  return 'ShiftListState.deleting(items: $items, deletingItemId: $deletingItemId)';
}


}

/// @nodoc
abstract mixin class _$DeletingCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$DeletingCopyWith(_Deleting value, $Res Function(_Deleting) _then) = __$DeletingCopyWithImpl;
@useResult
$Res call({
 List<ShiftEntity> items, int deletingItemId
});




}
/// @nodoc
class __$DeletingCopyWithImpl<$Res>
    implements _$DeletingCopyWith<$Res> {
  __$DeletingCopyWithImpl(this._self, this._then);

  final _Deleting _self;
  final $Res Function(_Deleting) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? deletingItemId = null,}) {
  return _then(_Deleting(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ShiftEntity>,deletingItemId: null == deletingItemId ? _self.deletingItemId : deletingItemId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Success implements ShiftListState {
  const _Success({required this.action, required this.message});
  

 final  ShiftListAction action;
 final  String message;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.action, action) || other.action == action)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,action,message);

@override
String toString() {
  return 'ShiftListState.success(action: $action, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 ShiftListAction action, String message
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,Object? message = null,}) {
  return _then(_Success(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ShiftListAction,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Failure implements ShiftListState {
  const _Failure({required this.message, final  List<ShiftEntity> items = const []}): _items = items;
  

 final  String message;
 final  List<ShiftEntity> _items;
@JsonKey() List<ShiftEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ShiftListState.failure(message: $message, items: $items)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message, List<ShiftEntity> items
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? items = null,}) {
  return _then(_Failure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ShiftEntity>,
  ));
}


}

/// @nodoc


class _ConnectionError implements ShiftListState {
  const _ConnectionError({required this.filter, final  List<ShiftEntity> items = const []}): _items = items;
  

 final  ShiftFilterParamEntity filter;
 final  List<ShiftEntity> _items;
@JsonKey() List<ShiftEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionErrorCopyWith<_ConnectionError> get copyWith => __$ConnectionErrorCopyWithImpl<_ConnectionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,filter,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ShiftListState.connectionError(filter: $filter, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@useResult
$Res call({
 ShiftFilterParamEntity filter, List<ShiftEntity> items
});




}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,Object? items = null,}) {
  return _then(_ConnectionError(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ShiftFilterParamEntity,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ShiftEntity>,
  ));
}


}

/// @nodoc


class _Exporting implements ShiftListState {
  const _Exporting({required final  List<ShiftEntity> items, required this.filter}): _items = items;
  

 final  List<ShiftEntity> _items;
 List<ShiftEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  ShiftFilterParamEntity filter;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportingCopyWith<_Exporting> get copyWith => __$ExportingCopyWithImpl<_Exporting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Exporting&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),filter);

@override
String toString() {
  return 'ShiftListState.exporting(items: $items, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$ExportingCopyWith<$Res> implements $ShiftListStateCopyWith<$Res> {
  factory _$ExportingCopyWith(_Exporting value, $Res Function(_Exporting) _then) = __$ExportingCopyWithImpl;
@useResult
$Res call({
 List<ShiftEntity> items, ShiftFilterParamEntity filter
});




}
/// @nodoc
class __$ExportingCopyWithImpl<$Res>
    implements _$ExportingCopyWith<$Res> {
  __$ExportingCopyWithImpl(this._self, this._then);

  final _Exporting _self;
  final $Res Function(_Exporting) _then;

/// Create a copy of ShiftListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? filter = null,}) {
  return _then(_Exporting(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ShiftEntity>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ShiftFilterParamEntity,
  ));
}


}

// dart format on
