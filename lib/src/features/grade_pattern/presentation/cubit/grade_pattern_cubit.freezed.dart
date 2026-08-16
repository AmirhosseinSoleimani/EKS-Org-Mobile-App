// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade_pattern_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GradePatternState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradePatternState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState()';
}


}

/// @nodoc
class $GradePatternStateCopyWith<$Res>  {
$GradePatternStateCopyWith(GradePatternState _, $Res Function(GradePatternState) __);
}


/// Adds pattern-matching-related methods to [GradePatternState].
extension GradePatternStatePatterns on GradePatternState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Empty value)?  empty,TResult Function( _LoadingMore value)?  loadingMore,TResult Function( _DetailLoading value)?  detailLoading,TResult Function( _DetailLoaded value)?  detailLoaded,TResult Function( _FormReady value)?  formReady,TResult Function( _ReferencesLoaded value)?  referencesLoaded,TResult Function( _Submitting value)?  submitting,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,TResult Function( _ConnectionError value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Empty() when empty != null:
return empty(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _DetailLoading() when detailLoading != null:
return detailLoading(_that);case _DetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case _FormReady() when formReady != null:
return formReady(_that);case _ReferencesLoaded() when referencesLoaded != null:
return referencesLoaded(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Empty value)  empty,required TResult Function( _LoadingMore value)  loadingMore,required TResult Function( _DetailLoading value)  detailLoading,required TResult Function( _DetailLoaded value)  detailLoaded,required TResult Function( _FormReady value)  formReady,required TResult Function( _ReferencesLoaded value)  referencesLoaded,required TResult Function( _Submitting value)  submitting,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,required TResult Function( _ConnectionError value)  connectionError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Empty():
return empty(_that);case _LoadingMore():
return loadingMore(_that);case _DetailLoading():
return detailLoading(_that);case _DetailLoaded():
return detailLoaded(_that);case _FormReady():
return formReady(_that);case _ReferencesLoaded():
return referencesLoaded(_that);case _Submitting():
return submitting(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _ConnectionError():
return connectionError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Empty value)?  empty,TResult? Function( _LoadingMore value)?  loadingMore,TResult? Function( _DetailLoading value)?  detailLoading,TResult? Function( _DetailLoaded value)?  detailLoaded,TResult? Function( _FormReady value)?  formReady,TResult? Function( _ReferencesLoaded value)?  referencesLoaded,TResult? Function( _Submitting value)?  submitting,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,TResult? Function( _ConnectionError value)?  connectionError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Empty() when empty != null:
return empty(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _DetailLoading() when detailLoading != null:
return detailLoading(_that);case _DetailLoaded() when detailLoaded != null:
return detailLoaded(_that);case _FormReady() when formReady != null:
return formReady(_that);case _ReferencesLoaded() when referencesLoaded != null:
return referencesLoaded(_that);case _Submitting() when submitting != null:
return submitting(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( GradePatternFilterParamEntity filter)?  loading,TResult Function( List<GradePatternEntity> items,  int totalCount,  bool hasMore,  GradePatternFilterParamEntity filter)?  loaded,TResult Function( GradePatternFilterParamEntity filter)?  empty,TResult Function( List<GradePatternEntity> items,  int totalCount,  GradePatternFilterParamEntity filter)?  loadingMore,TResult Function( List<GradePatternEntity> items)?  detailLoading,TResult Function( GradePatternEntity item)?  detailLoaded,TResult Function( GradePatternEntity item)?  formReady,TResult Function( List<GradePatternEntity> patterns,  List<GradePatternReferenceEntity> references)?  referencesLoaded,TResult Function( GradePatternEntity? item,  List<GradePatternEntity> items)?  submitting,TResult Function( GradePatternAction action,  String message,  List<GradePatternEntity> items)?  success,TResult Function( String message,  List<GradePatternEntity> items)?  failure,TResult Function( GradePatternFilterParamEntity filter,  List<GradePatternEntity> items)?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.filter);case _Loaded() when loaded != null:
return loaded(_that.items,_that.totalCount,_that.hasMore,_that.filter);case _Empty() when empty != null:
return empty(_that.filter);case _LoadingMore() when loadingMore != null:
return loadingMore(_that.items,_that.totalCount,_that.filter);case _DetailLoading() when detailLoading != null:
return detailLoading(_that.items);case _DetailLoaded() when detailLoaded != null:
return detailLoaded(_that.item);case _FormReady() when formReady != null:
return formReady(_that.item);case _ReferencesLoaded() when referencesLoaded != null:
return referencesLoaded(_that.patterns,_that.references);case _Submitting() when submitting != null:
return submitting(_that.item,_that.items);case _Success() when success != null:
return success(_that.action,_that.message,_that.items);case _Failure() when failure != null:
return failure(_that.message,_that.items);case _ConnectionError() when connectionError != null:
return connectionError(_that.filter,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( GradePatternFilterParamEntity filter)  loading,required TResult Function( List<GradePatternEntity> items,  int totalCount,  bool hasMore,  GradePatternFilterParamEntity filter)  loaded,required TResult Function( GradePatternFilterParamEntity filter)  empty,required TResult Function( List<GradePatternEntity> items,  int totalCount,  GradePatternFilterParamEntity filter)  loadingMore,required TResult Function( List<GradePatternEntity> items)  detailLoading,required TResult Function( GradePatternEntity item)  detailLoaded,required TResult Function( GradePatternEntity item)  formReady,required TResult Function( List<GradePatternEntity> patterns,  List<GradePatternReferenceEntity> references)  referencesLoaded,required TResult Function( GradePatternEntity? item,  List<GradePatternEntity> items)  submitting,required TResult Function( GradePatternAction action,  String message,  List<GradePatternEntity> items)  success,required TResult Function( String message,  List<GradePatternEntity> items)  failure,required TResult Function( GradePatternFilterParamEntity filter,  List<GradePatternEntity> items)  connectionError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading(_that.filter);case _Loaded():
return loaded(_that.items,_that.totalCount,_that.hasMore,_that.filter);case _Empty():
return empty(_that.filter);case _LoadingMore():
return loadingMore(_that.items,_that.totalCount,_that.filter);case _DetailLoading():
return detailLoading(_that.items);case _DetailLoaded():
return detailLoaded(_that.item);case _FormReady():
return formReady(_that.item);case _ReferencesLoaded():
return referencesLoaded(_that.patterns,_that.references);case _Submitting():
return submitting(_that.item,_that.items);case _Success():
return success(_that.action,_that.message,_that.items);case _Failure():
return failure(_that.message,_that.items);case _ConnectionError():
return connectionError(_that.filter,_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( GradePatternFilterParamEntity filter)?  loading,TResult? Function( List<GradePatternEntity> items,  int totalCount,  bool hasMore,  GradePatternFilterParamEntity filter)?  loaded,TResult? Function( GradePatternFilterParamEntity filter)?  empty,TResult? Function( List<GradePatternEntity> items,  int totalCount,  GradePatternFilterParamEntity filter)?  loadingMore,TResult? Function( List<GradePatternEntity> items)?  detailLoading,TResult? Function( GradePatternEntity item)?  detailLoaded,TResult? Function( GradePatternEntity item)?  formReady,TResult? Function( List<GradePatternEntity> patterns,  List<GradePatternReferenceEntity> references)?  referencesLoaded,TResult? Function( GradePatternEntity? item,  List<GradePatternEntity> items)?  submitting,TResult? Function( GradePatternAction action,  String message,  List<GradePatternEntity> items)?  success,TResult? Function( String message,  List<GradePatternEntity> items)?  failure,TResult? Function( GradePatternFilterParamEntity filter,  List<GradePatternEntity> items)?  connectionError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.filter);case _Loaded() when loaded != null:
return loaded(_that.items,_that.totalCount,_that.hasMore,_that.filter);case _Empty() when empty != null:
return empty(_that.filter);case _LoadingMore() when loadingMore != null:
return loadingMore(_that.items,_that.totalCount,_that.filter);case _DetailLoading() when detailLoading != null:
return detailLoading(_that.items);case _DetailLoaded() when detailLoaded != null:
return detailLoaded(_that.item);case _FormReady() when formReady != null:
return formReady(_that.item);case _ReferencesLoaded() when referencesLoaded != null:
return referencesLoaded(_that.patterns,_that.references);case _Submitting() when submitting != null:
return submitting(_that.item,_that.items);case _Success() when success != null:
return success(_that.action,_that.message,_that.items);case _Failure() when failure != null:
return failure(_that.message,_that.items);case _ConnectionError() when connectionError != null:
return connectionError(_that.filter,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _Initial with DiagnosticableTreeMixin implements GradePatternState {
  const _Initial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.initial()';
}


}




/// @nodoc


class _Loading with DiagnosticableTreeMixin implements GradePatternState {
  const _Loading({required this.filter});
  

 final  GradePatternFilterParamEntity filter;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.loading'))
    ..add(DiagnosticsProperty('filter', filter));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.loading(filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@useResult
$Res call({
 GradePatternFilterParamEntity filter
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(_Loading(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as GradePatternFilterParamEntity,
  ));
}


}

/// @nodoc


class _Loaded with DiagnosticableTreeMixin implements GradePatternState {
  const _Loaded({required final  List<GradePatternEntity> items, required this.totalCount, required this.hasMore, required this.filter}): _items = items;
  

 final  List<GradePatternEntity> _items;
 List<GradePatternEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int totalCount;
 final  bool hasMore;
 final  GradePatternFilterParamEntity filter;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.loaded'))
    ..add(DiagnosticsProperty('items', items))..add(DiagnosticsProperty('totalCount', totalCount))..add(DiagnosticsProperty('hasMore', hasMore))..add(DiagnosticsProperty('filter', filter));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,hasMore,filter);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.loaded(items: $items, totalCount: $totalCount, hasMore: $hasMore, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<GradePatternEntity> items, int totalCount, bool hasMore, GradePatternFilterParamEntity filter
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? hasMore = null,Object? filter = null,}) {
  return _then(_Loaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GradePatternEntity>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as GradePatternFilterParamEntity,
  ));
}


}

/// @nodoc


class _Empty with DiagnosticableTreeMixin implements GradePatternState {
  const _Empty({required this.filter});
  

 final  GradePatternFilterParamEntity filter;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmptyCopyWith<_Empty> get copyWith => __$EmptyCopyWithImpl<_Empty>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.empty'))
    ..add(DiagnosticsProperty('filter', filter));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Empty&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.empty(filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$EmptyCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$EmptyCopyWith(_Empty value, $Res Function(_Empty) _then) = __$EmptyCopyWithImpl;
@useResult
$Res call({
 GradePatternFilterParamEntity filter
});




}
/// @nodoc
class __$EmptyCopyWithImpl<$Res>
    implements _$EmptyCopyWith<$Res> {
  __$EmptyCopyWithImpl(this._self, this._then);

  final _Empty _self;
  final $Res Function(_Empty) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(_Empty(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as GradePatternFilterParamEntity,
  ));
}


}

/// @nodoc


class _LoadingMore with DiagnosticableTreeMixin implements GradePatternState {
  const _LoadingMore({required final  List<GradePatternEntity> items, required this.totalCount, required this.filter}): _items = items;
  

 final  List<GradePatternEntity> _items;
 List<GradePatternEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  int totalCount;
 final  GradePatternFilterParamEntity filter;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingMoreCopyWith<_LoadingMore> get copyWith => __$LoadingMoreCopyWithImpl<_LoadingMore>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.loadingMore'))
    ..add(DiagnosticsProperty('items', items))..add(DiagnosticsProperty('totalCount', totalCount))..add(DiagnosticsProperty('filter', filter));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingMore&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,filter);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.loadingMore(items: $items, totalCount: $totalCount, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$LoadingMoreCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$LoadingMoreCopyWith(_LoadingMore value, $Res Function(_LoadingMore) _then) = __$LoadingMoreCopyWithImpl;
@useResult
$Res call({
 List<GradePatternEntity> items, int totalCount, GradePatternFilterParamEntity filter
});




}
/// @nodoc
class __$LoadingMoreCopyWithImpl<$Res>
    implements _$LoadingMoreCopyWith<$Res> {
  __$LoadingMoreCopyWithImpl(this._self, this._then);

  final _LoadingMore _self;
  final $Res Function(_LoadingMore) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? filter = null,}) {
  return _then(_LoadingMore(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GradePatternEntity>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as GradePatternFilterParamEntity,
  ));
}


}

/// @nodoc


class _DetailLoading with DiagnosticableTreeMixin implements GradePatternState {
  const _DetailLoading({final  List<GradePatternEntity> items = const []}): _items = items;
  

 final  List<GradePatternEntity> _items;
@JsonKey() List<GradePatternEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailLoadingCopyWith<_DetailLoading> get copyWith => __$DetailLoadingCopyWithImpl<_DetailLoading>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.detailLoading'))
    ..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailLoading&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.detailLoading(items: $items)';
}


}

/// @nodoc
abstract mixin class _$DetailLoadingCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$DetailLoadingCopyWith(_DetailLoading value, $Res Function(_DetailLoading) _then) = __$DetailLoadingCopyWithImpl;
@useResult
$Res call({
 List<GradePatternEntity> items
});




}
/// @nodoc
class __$DetailLoadingCopyWithImpl<$Res>
    implements _$DetailLoadingCopyWith<$Res> {
  __$DetailLoadingCopyWithImpl(this._self, this._then);

  final _DetailLoading _self;
  final $Res Function(_DetailLoading) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_DetailLoading(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GradePatternEntity>,
  ));
}


}

/// @nodoc


class _DetailLoaded with DiagnosticableTreeMixin implements GradePatternState {
  const _DetailLoaded({required this.item});
  

 final  GradePatternEntity item;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailLoadedCopyWith<_DetailLoaded> get copyWith => __$DetailLoadedCopyWithImpl<_DetailLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.detailLoaded'))
    ..add(DiagnosticsProperty('item', item));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailLoaded&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.detailLoaded(item: $item)';
}


}

/// @nodoc
abstract mixin class _$DetailLoadedCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$DetailLoadedCopyWith(_DetailLoaded value, $Res Function(_DetailLoaded) _then) = __$DetailLoadedCopyWithImpl;
@useResult
$Res call({
 GradePatternEntity item
});




}
/// @nodoc
class __$DetailLoadedCopyWithImpl<$Res>
    implements _$DetailLoadedCopyWith<$Res> {
  __$DetailLoadedCopyWithImpl(this._self, this._then);

  final _DetailLoaded _self;
  final $Res Function(_DetailLoaded) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_DetailLoaded(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as GradePatternEntity,
  ));
}


}

/// @nodoc


class _FormReady with DiagnosticableTreeMixin implements GradePatternState {
  const _FormReady({required this.item});
  

 final  GradePatternEntity item;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormReadyCopyWith<_FormReady> get copyWith => __$FormReadyCopyWithImpl<_FormReady>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.formReady'))
    ..add(DiagnosticsProperty('item', item));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormReady&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.formReady(item: $item)';
}


}

/// @nodoc
abstract mixin class _$FormReadyCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$FormReadyCopyWith(_FormReady value, $Res Function(_FormReady) _then) = __$FormReadyCopyWithImpl;
@useResult
$Res call({
 GradePatternEntity item
});




}
/// @nodoc
class __$FormReadyCopyWithImpl<$Res>
    implements _$FormReadyCopyWith<$Res> {
  __$FormReadyCopyWithImpl(this._self, this._then);

  final _FormReady _self;
  final $Res Function(_FormReady) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_FormReady(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as GradePatternEntity,
  ));
}


}

/// @nodoc


class _ReferencesLoaded with DiagnosticableTreeMixin implements GradePatternState {
  const _ReferencesLoaded({required final  List<GradePatternEntity> patterns, required final  List<GradePatternReferenceEntity> references}): _patterns = patterns,_references = references;
  

 final  List<GradePatternEntity> _patterns;
 List<GradePatternEntity> get patterns {
  if (_patterns is EqualUnmodifiableListView) return _patterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_patterns);
}

 final  List<GradePatternReferenceEntity> _references;
 List<GradePatternReferenceEntity> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}


/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReferencesLoadedCopyWith<_ReferencesLoaded> get copyWith => __$ReferencesLoadedCopyWithImpl<_ReferencesLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.referencesLoaded'))
    ..add(DiagnosticsProperty('patterns', patterns))..add(DiagnosticsProperty('references', references));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReferencesLoaded&&const DeepCollectionEquality().equals(other._patterns, _patterns)&&const DeepCollectionEquality().equals(other._references, _references));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_patterns),const DeepCollectionEquality().hash(_references));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.referencesLoaded(patterns: $patterns, references: $references)';
}


}

/// @nodoc
abstract mixin class _$ReferencesLoadedCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$ReferencesLoadedCopyWith(_ReferencesLoaded value, $Res Function(_ReferencesLoaded) _then) = __$ReferencesLoadedCopyWithImpl;
@useResult
$Res call({
 List<GradePatternEntity> patterns, List<GradePatternReferenceEntity> references
});




}
/// @nodoc
class __$ReferencesLoadedCopyWithImpl<$Res>
    implements _$ReferencesLoadedCopyWith<$Res> {
  __$ReferencesLoadedCopyWithImpl(this._self, this._then);

  final _ReferencesLoaded _self;
  final $Res Function(_ReferencesLoaded) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? patterns = null,Object? references = null,}) {
  return _then(_ReferencesLoaded(
patterns: null == patterns ? _self._patterns : patterns // ignore: cast_nullable_to_non_nullable
as List<GradePatternEntity>,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<GradePatternReferenceEntity>,
  ));
}


}

/// @nodoc


class _Submitting with DiagnosticableTreeMixin implements GradePatternState {
  const _Submitting({this.item, final  List<GradePatternEntity> items = const []}): _items = items;
  

 final  GradePatternEntity? item;
 final  List<GradePatternEntity> _items;
@JsonKey() List<GradePatternEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittingCopyWith<_Submitting> get copyWith => __$SubmittingCopyWithImpl<_Submitting>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.submitting'))
    ..add(DiagnosticsProperty('item', item))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitting&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,item,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.submitting(item: $item, items: $items)';
}


}

/// @nodoc
abstract mixin class _$SubmittingCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$SubmittingCopyWith(_Submitting value, $Res Function(_Submitting) _then) = __$SubmittingCopyWithImpl;
@useResult
$Res call({
 GradePatternEntity? item, List<GradePatternEntity> items
});




}
/// @nodoc
class __$SubmittingCopyWithImpl<$Res>
    implements _$SubmittingCopyWith<$Res> {
  __$SubmittingCopyWithImpl(this._self, this._then);

  final _Submitting _self;
  final $Res Function(_Submitting) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = freezed,Object? items = null,}) {
  return _then(_Submitting(
item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as GradePatternEntity?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GradePatternEntity>,
  ));
}


}

/// @nodoc


class _Success with DiagnosticableTreeMixin implements GradePatternState {
  const _Success({required this.action, required this.message, final  List<GradePatternEntity> items = const []}): _items = items;
  

 final  GradePatternAction action;
 final  String message;
 final  List<GradePatternEntity> _items;
@JsonKey() List<GradePatternEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.success'))
    ..add(DiagnosticsProperty('action', action))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.action, action) || other.action == action)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,action,message,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.success(action: $action, message: $message, items: $items)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 GradePatternAction action, String message, List<GradePatternEntity> items
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,Object? message = null,Object? items = null,}) {
  return _then(_Success(
action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as GradePatternAction,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GradePatternEntity>,
  ));
}


}

/// @nodoc


class _Failure with DiagnosticableTreeMixin implements GradePatternState {
  const _Failure({required this.message, final  List<GradePatternEntity> items = const []}): _items = items;
  

 final  String message;
 final  List<GradePatternEntity> _items;
@JsonKey() List<GradePatternEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.failure'))
    ..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.failure(message: $message, items: $items)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message, List<GradePatternEntity> items
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? items = null,}) {
  return _then(_Failure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GradePatternEntity>,
  ));
}


}

/// @nodoc


class _ConnectionError with DiagnosticableTreeMixin implements GradePatternState {
  const _ConnectionError({required this.filter, final  List<GradePatternEntity> items = const []}): _items = items;
  

 final  GradePatternFilterParamEntity filter;
 final  List<GradePatternEntity> _items;
@JsonKey() List<GradePatternEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionErrorCopyWith<_ConnectionError> get copyWith => __$ConnectionErrorCopyWithImpl<_ConnectionError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GradePatternState.connectionError'))
    ..add(DiagnosticsProperty('filter', filter))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,filter,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GradePatternState.connectionError(filter: $filter, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $GradePatternStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@useResult
$Res call({
 GradePatternFilterParamEntity filter, List<GradePatternEntity> items
});




}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of GradePatternState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,Object? items = null,}) {
  return _then(_ConnectionError(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as GradePatternFilterParamEntity,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GradePatternEntity>,
  ));
}


}

// dart format on
