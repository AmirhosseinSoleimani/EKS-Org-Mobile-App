// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skills_certificates_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SkillsCertificatesStateData {

 List<SkillCertificateEntity> get items; int get totalCount; bool get hasMore; bool? get activeFilter; SkillCertificateEntity? get selectedSkill; List<SkillServiceEntity> get services; Set<int> get selectedServiceIds; String get serviceSearchText; bool get isInitialLoading; bool get isSubmitting; bool get isServicesLoading; bool get isServicesSubmitting; bool get isReportLoading; int? get deletingSkillId; String? get message; String? get reportFilePath;
/// Create a copy of SkillsCertificatesStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillsCertificatesStateDataCopyWith<SkillsCertificatesStateData> get copyWith => _$SkillsCertificatesStateDataCopyWithImpl<SkillsCertificatesStateData>(this as SkillsCertificatesStateData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillsCertificatesStateData&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.activeFilter, activeFilter) || other.activeFilter == activeFilter)&&(identical(other.selectedSkill, selectedSkill) || other.selectedSkill == selectedSkill)&&const DeepCollectionEquality().equals(other.services, services)&&const DeepCollectionEquality().equals(other.selectedServiceIds, selectedServiceIds)&&(identical(other.serviceSearchText, serviceSearchText) || other.serviceSearchText == serviceSearchText)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isServicesLoading, isServicesLoading) || other.isServicesLoading == isServicesLoading)&&(identical(other.isServicesSubmitting, isServicesSubmitting) || other.isServicesSubmitting == isServicesSubmitting)&&(identical(other.isReportLoading, isReportLoading) || other.isReportLoading == isReportLoading)&&(identical(other.deletingSkillId, deletingSkillId) || other.deletingSkillId == deletingSkillId)&&(identical(other.message, message) || other.message == message)&&(identical(other.reportFilePath, reportFilePath) || other.reportFilePath == reportFilePath));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalCount,hasMore,activeFilter,selectedSkill,const DeepCollectionEquality().hash(services),const DeepCollectionEquality().hash(selectedServiceIds),serviceSearchText,isInitialLoading,isSubmitting,isServicesLoading,isServicesSubmitting,isReportLoading,deletingSkillId,message,reportFilePath);

@override
String toString() {
  return 'SkillsCertificatesStateData(items: $items, totalCount: $totalCount, hasMore: $hasMore, activeFilter: $activeFilter, selectedSkill: $selectedSkill, services: $services, selectedServiceIds: $selectedServiceIds, serviceSearchText: $serviceSearchText, isInitialLoading: $isInitialLoading, isSubmitting: $isSubmitting, isServicesLoading: $isServicesLoading, isServicesSubmitting: $isServicesSubmitting, isReportLoading: $isReportLoading, deletingSkillId: $deletingSkillId, message: $message, reportFilePath: $reportFilePath)';
}


}

/// @nodoc
abstract mixin class $SkillsCertificatesStateDataCopyWith<$Res>  {
  factory $SkillsCertificatesStateDataCopyWith(SkillsCertificatesStateData value, $Res Function(SkillsCertificatesStateData) _then) = _$SkillsCertificatesStateDataCopyWithImpl;
@useResult
$Res call({
 List<SkillCertificateEntity> items, int totalCount, bool hasMore, bool? activeFilter, SkillCertificateEntity? selectedSkill, List<SkillServiceEntity> services, Set<int> selectedServiceIds, String serviceSearchText, bool isInitialLoading, bool isSubmitting, bool isServicesLoading, bool isServicesSubmitting, bool isReportLoading, int? deletingSkillId, String? message, String? reportFilePath
});




}
/// @nodoc
class _$SkillsCertificatesStateDataCopyWithImpl<$Res>
    implements $SkillsCertificatesStateDataCopyWith<$Res> {
  _$SkillsCertificatesStateDataCopyWithImpl(this._self, this._then);

  final SkillsCertificatesStateData _self;
  final $Res Function(SkillsCertificatesStateData) _then;

/// Create a copy of SkillsCertificatesStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? hasMore = null,Object? activeFilter = freezed,Object? selectedSkill = freezed,Object? services = null,Object? selectedServiceIds = null,Object? serviceSearchText = null,Object? isInitialLoading = null,Object? isSubmitting = null,Object? isServicesLoading = null,Object? isServicesSubmitting = null,Object? isReportLoading = null,Object? deletingSkillId = freezed,Object? message = freezed,Object? reportFilePath = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SkillCertificateEntity>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as bool?,selectedSkill: freezed == selectedSkill ? _self.selectedSkill : selectedSkill // ignore: cast_nullable_to_non_nullable
as SkillCertificateEntity?,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<SkillServiceEntity>,selectedServiceIds: null == selectedServiceIds ? _self.selectedServiceIds : selectedServiceIds // ignore: cast_nullable_to_non_nullable
as Set<int>,serviceSearchText: null == serviceSearchText ? _self.serviceSearchText : serviceSearchText // ignore: cast_nullable_to_non_nullable
as String,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isServicesLoading: null == isServicesLoading ? _self.isServicesLoading : isServicesLoading // ignore: cast_nullable_to_non_nullable
as bool,isServicesSubmitting: null == isServicesSubmitting ? _self.isServicesSubmitting : isServicesSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isReportLoading: null == isReportLoading ? _self.isReportLoading : isReportLoading // ignore: cast_nullable_to_non_nullable
as bool,deletingSkillId: freezed == deletingSkillId ? _self.deletingSkillId : deletingSkillId // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,reportFilePath: freezed == reportFilePath ? _self.reportFilePath : reportFilePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillsCertificatesStateData].
extension SkillsCertificatesStateDataPatterns on SkillsCertificatesStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillsCertificatesStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillsCertificatesStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillsCertificatesStateData value)  $default,){
final _that = this;
switch (_that) {
case _SkillsCertificatesStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillsCertificatesStateData value)?  $default,){
final _that = this;
switch (_that) {
case _SkillsCertificatesStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SkillCertificateEntity> items,  int totalCount,  bool hasMore,  bool? activeFilter,  SkillCertificateEntity? selectedSkill,  List<SkillServiceEntity> services,  Set<int> selectedServiceIds,  String serviceSearchText,  bool isInitialLoading,  bool isSubmitting,  bool isServicesLoading,  bool isServicesSubmitting,  bool isReportLoading,  int? deletingSkillId,  String? message,  String? reportFilePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillsCertificatesStateData() when $default != null:
return $default(_that.items,_that.totalCount,_that.hasMore,_that.activeFilter,_that.selectedSkill,_that.services,_that.selectedServiceIds,_that.serviceSearchText,_that.isInitialLoading,_that.isSubmitting,_that.isServicesLoading,_that.isServicesSubmitting,_that.isReportLoading,_that.deletingSkillId,_that.message,_that.reportFilePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SkillCertificateEntity> items,  int totalCount,  bool hasMore,  bool? activeFilter,  SkillCertificateEntity? selectedSkill,  List<SkillServiceEntity> services,  Set<int> selectedServiceIds,  String serviceSearchText,  bool isInitialLoading,  bool isSubmitting,  bool isServicesLoading,  bool isServicesSubmitting,  bool isReportLoading,  int? deletingSkillId,  String? message,  String? reportFilePath)  $default,) {final _that = this;
switch (_that) {
case _SkillsCertificatesStateData():
return $default(_that.items,_that.totalCount,_that.hasMore,_that.activeFilter,_that.selectedSkill,_that.services,_that.selectedServiceIds,_that.serviceSearchText,_that.isInitialLoading,_that.isSubmitting,_that.isServicesLoading,_that.isServicesSubmitting,_that.isReportLoading,_that.deletingSkillId,_that.message,_that.reportFilePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SkillCertificateEntity> items,  int totalCount,  bool hasMore,  bool? activeFilter,  SkillCertificateEntity? selectedSkill,  List<SkillServiceEntity> services,  Set<int> selectedServiceIds,  String serviceSearchText,  bool isInitialLoading,  bool isSubmitting,  bool isServicesLoading,  bool isServicesSubmitting,  bool isReportLoading,  int? deletingSkillId,  String? message,  String? reportFilePath)?  $default,) {final _that = this;
switch (_that) {
case _SkillsCertificatesStateData() when $default != null:
return $default(_that.items,_that.totalCount,_that.hasMore,_that.activeFilter,_that.selectedSkill,_that.services,_that.selectedServiceIds,_that.serviceSearchText,_that.isInitialLoading,_that.isSubmitting,_that.isServicesLoading,_that.isServicesSubmitting,_that.isReportLoading,_that.deletingSkillId,_that.message,_that.reportFilePath);case _:
  return null;

}
}

}

/// @nodoc


class _SkillsCertificatesStateData implements SkillsCertificatesStateData {
  const _SkillsCertificatesStateData({final  List<SkillCertificateEntity> items = const [], this.totalCount = 0, this.hasMore = false, this.activeFilter, this.selectedSkill, final  List<SkillServiceEntity> services = const [], final  Set<int> selectedServiceIds = const <int>{}, this.serviceSearchText = '', this.isInitialLoading = false, this.isSubmitting = false, this.isServicesLoading = false, this.isServicesSubmitting = false, this.isReportLoading = false, this.deletingSkillId, this.message, this.reportFilePath}): _items = items,_services = services,_selectedServiceIds = selectedServiceIds;
  

 final  List<SkillCertificateEntity> _items;
@override@JsonKey() List<SkillCertificateEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool hasMore;
@override final  bool? activeFilter;
@override final  SkillCertificateEntity? selectedSkill;
 final  List<SkillServiceEntity> _services;
@override@JsonKey() List<SkillServiceEntity> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

 final  Set<int> _selectedServiceIds;
@override@JsonKey() Set<int> get selectedServiceIds {
  if (_selectedServiceIds is EqualUnmodifiableSetView) return _selectedServiceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedServiceIds);
}

@override@JsonKey() final  String serviceSearchText;
@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isServicesLoading;
@override@JsonKey() final  bool isServicesSubmitting;
@override@JsonKey() final  bool isReportLoading;
@override final  int? deletingSkillId;
@override final  String? message;
@override final  String? reportFilePath;

/// Create a copy of SkillsCertificatesStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillsCertificatesStateDataCopyWith<_SkillsCertificatesStateData> get copyWith => __$SkillsCertificatesStateDataCopyWithImpl<_SkillsCertificatesStateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillsCertificatesStateData&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.activeFilter, activeFilter) || other.activeFilter == activeFilter)&&(identical(other.selectedSkill, selectedSkill) || other.selectedSkill == selectedSkill)&&const DeepCollectionEquality().equals(other._services, _services)&&const DeepCollectionEquality().equals(other._selectedServiceIds, _selectedServiceIds)&&(identical(other.serviceSearchText, serviceSearchText) || other.serviceSearchText == serviceSearchText)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isServicesLoading, isServicesLoading) || other.isServicesLoading == isServicesLoading)&&(identical(other.isServicesSubmitting, isServicesSubmitting) || other.isServicesSubmitting == isServicesSubmitting)&&(identical(other.isReportLoading, isReportLoading) || other.isReportLoading == isReportLoading)&&(identical(other.deletingSkillId, deletingSkillId) || other.deletingSkillId == deletingSkillId)&&(identical(other.message, message) || other.message == message)&&(identical(other.reportFilePath, reportFilePath) || other.reportFilePath == reportFilePath));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,hasMore,activeFilter,selectedSkill,const DeepCollectionEquality().hash(_services),const DeepCollectionEquality().hash(_selectedServiceIds),serviceSearchText,isInitialLoading,isSubmitting,isServicesLoading,isServicesSubmitting,isReportLoading,deletingSkillId,message,reportFilePath);

@override
String toString() {
  return 'SkillsCertificatesStateData(items: $items, totalCount: $totalCount, hasMore: $hasMore, activeFilter: $activeFilter, selectedSkill: $selectedSkill, services: $services, selectedServiceIds: $selectedServiceIds, serviceSearchText: $serviceSearchText, isInitialLoading: $isInitialLoading, isSubmitting: $isSubmitting, isServicesLoading: $isServicesLoading, isServicesSubmitting: $isServicesSubmitting, isReportLoading: $isReportLoading, deletingSkillId: $deletingSkillId, message: $message, reportFilePath: $reportFilePath)';
}


}

/// @nodoc
abstract mixin class _$SkillsCertificatesStateDataCopyWith<$Res> implements $SkillsCertificatesStateDataCopyWith<$Res> {
  factory _$SkillsCertificatesStateDataCopyWith(_SkillsCertificatesStateData value, $Res Function(_SkillsCertificatesStateData) _then) = __$SkillsCertificatesStateDataCopyWithImpl;
@override @useResult
$Res call({
 List<SkillCertificateEntity> items, int totalCount, bool hasMore, bool? activeFilter, SkillCertificateEntity? selectedSkill, List<SkillServiceEntity> services, Set<int> selectedServiceIds, String serviceSearchText, bool isInitialLoading, bool isSubmitting, bool isServicesLoading, bool isServicesSubmitting, bool isReportLoading, int? deletingSkillId, String? message, String? reportFilePath
});




}
/// @nodoc
class __$SkillsCertificatesStateDataCopyWithImpl<$Res>
    implements _$SkillsCertificatesStateDataCopyWith<$Res> {
  __$SkillsCertificatesStateDataCopyWithImpl(this._self, this._then);

  final _SkillsCertificatesStateData _self;
  final $Res Function(_SkillsCertificatesStateData) _then;

/// Create a copy of SkillsCertificatesStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? hasMore = null,Object? activeFilter = freezed,Object? selectedSkill = freezed,Object? services = null,Object? selectedServiceIds = null,Object? serviceSearchText = null,Object? isInitialLoading = null,Object? isSubmitting = null,Object? isServicesLoading = null,Object? isServicesSubmitting = null,Object? isReportLoading = null,Object? deletingSkillId = freezed,Object? message = freezed,Object? reportFilePath = freezed,}) {
  return _then(_SkillsCertificatesStateData(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SkillCertificateEntity>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as bool?,selectedSkill: freezed == selectedSkill ? _self.selectedSkill : selectedSkill // ignore: cast_nullable_to_non_nullable
as SkillCertificateEntity?,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<SkillServiceEntity>,selectedServiceIds: null == selectedServiceIds ? _self._selectedServiceIds : selectedServiceIds // ignore: cast_nullable_to_non_nullable
as Set<int>,serviceSearchText: null == serviceSearchText ? _self.serviceSearchText : serviceSearchText // ignore: cast_nullable_to_non_nullable
as String,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isServicesLoading: null == isServicesLoading ? _self.isServicesLoading : isServicesLoading // ignore: cast_nullable_to_non_nullable
as bool,isServicesSubmitting: null == isServicesSubmitting ? _self.isServicesSubmitting : isServicesSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isReportLoading: null == isReportLoading ? _self.isReportLoading : isReportLoading // ignore: cast_nullable_to_non_nullable
as bool,deletingSkillId: freezed == deletingSkillId ? _self.deletingSkillId : deletingSkillId // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,reportFilePath: freezed == reportFilePath ? _self.reportFilePath : reportFilePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SkillsCertificatesState {

 SkillsCertificatesStateData get data;
/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillsCertificatesStateCopyWith<SkillsCertificatesState> get copyWith => _$SkillsCertificatesStateCopyWithImpl<SkillsCertificatesState>(this as SkillsCertificatesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillsCertificatesState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'SkillsCertificatesState(data: $data)';
}


}

/// @nodoc
abstract mixin class $SkillsCertificatesStateCopyWith<$Res>  {
  factory $SkillsCertificatesStateCopyWith(SkillsCertificatesState value, $Res Function(SkillsCertificatesState) _then) = _$SkillsCertificatesStateCopyWithImpl;
@useResult
$Res call({
 SkillsCertificatesStateData data
});


$SkillsCertificatesStateDataCopyWith<$Res> get data;

}
/// @nodoc
class _$SkillsCertificatesStateCopyWithImpl<$Res>
    implements $SkillsCertificatesStateCopyWith<$Res> {
  _$SkillsCertificatesStateCopyWithImpl(this._self, this._then);

  final SkillsCertificatesState _self;
  final $Res Function(SkillsCertificatesState) _then;

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SkillsCertificatesStateData,
  ));
}
/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkillsCertificatesStateDataCopyWith<$Res> get data {
  
  return $SkillsCertificatesStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SkillsCertificatesState].
extension SkillsCertificatesStatePatterns on SkillsCertificatesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _LoadingMore value)?  loadingMore,TResult Function( _ConnectionError value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _LoadingMore value)  loadingMore,required TResult Function( _ConnectionError value)  connectionError,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _LoadingMore():
return loadingMore(_that);case _ConnectionError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _LoadingMore value)?  loadingMore,TResult? Function( _ConnectionError value)?  connectionError,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _LoadingMore() when loadingMore != null:
return loadingMore(_that);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SkillsCertificatesStateData data)?  idle,TResult Function( SkillsCertificatesStateData data)?  loading,TResult Function( SkillsCertificatesStateData data)?  loaded,TResult Function( SkillsCertificatesStateData data,  BottomSheetMessageModel message)?  error,TResult Function( SkillsCertificatesStateData data)?  loadingMore,TResult Function( SkillsCertificatesStateData data)?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Error() when error != null:
return error(_that.data,_that.message);case _LoadingMore() when loadingMore != null:
return loadingMore(_that.data);case _ConnectionError() when connectionError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SkillsCertificatesStateData data)  idle,required TResult Function( SkillsCertificatesStateData data)  loading,required TResult Function( SkillsCertificatesStateData data)  loaded,required TResult Function( SkillsCertificatesStateData data,  BottomSheetMessageModel message)  error,required TResult Function( SkillsCertificatesStateData data)  loadingMore,required TResult Function( SkillsCertificatesStateData data)  connectionError,}) {final _that = this;
switch (_that) {
case _Idle():
return idle(_that.data);case _Loading():
return loading(_that.data);case _Loaded():
return loaded(_that.data);case _Error():
return error(_that.data,_that.message);case _LoadingMore():
return loadingMore(_that.data);case _ConnectionError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SkillsCertificatesStateData data)?  idle,TResult? Function( SkillsCertificatesStateData data)?  loading,TResult? Function( SkillsCertificatesStateData data)?  loaded,TResult? Function( SkillsCertificatesStateData data,  BottomSheetMessageModel message)?  error,TResult? Function( SkillsCertificatesStateData data)?  loadingMore,TResult? Function( SkillsCertificatesStateData data)?  connectionError,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Error() when error != null:
return error(_that.data,_that.message);case _LoadingMore() when loadingMore != null:
return loadingMore(_that.data);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements SkillsCertificatesState {
  const _Idle({this.data = const SkillsCertificatesStateData()});
  

@override@JsonKey() final  SkillsCertificatesStateData data;

/// Create a copy of SkillsCertificatesState
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
  return 'SkillsCertificatesState.idle(data: $data)';
}


}

/// @nodoc
abstract mixin class _$IdleCopyWith<$Res> implements $SkillsCertificatesStateCopyWith<$Res> {
  factory _$IdleCopyWith(_Idle value, $Res Function(_Idle) _then) = __$IdleCopyWithImpl;
@override @useResult
$Res call({
 SkillsCertificatesStateData data
});


@override $SkillsCertificatesStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$IdleCopyWithImpl<$Res>
    implements _$IdleCopyWith<$Res> {
  __$IdleCopyWithImpl(this._self, this._then);

  final _Idle _self;
  final $Res Function(_Idle) _then;

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Idle(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SkillsCertificatesStateData,
  ));
}

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkillsCertificatesStateDataCopyWith<$Res> get data {
  
  return $SkillsCertificatesStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loading implements SkillsCertificatesState {
  const _Loading({required this.data});
  

@override final  SkillsCertificatesStateData data;

/// Create a copy of SkillsCertificatesState
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
  return 'SkillsCertificatesState.loading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $SkillsCertificatesStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 SkillsCertificatesStateData data
});


@override $SkillsCertificatesStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SkillsCertificatesStateData,
  ));
}

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkillsCertificatesStateDataCopyWith<$Res> get data {
  
  return $SkillsCertificatesStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loaded implements SkillsCertificatesState {
  const _Loaded({required this.data});
  

@override final  SkillsCertificatesStateData data;

/// Create a copy of SkillsCertificatesState
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
  return 'SkillsCertificatesState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SkillsCertificatesStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
 SkillsCertificatesStateData data
});


@override $SkillsCertificatesStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SkillsCertificatesStateData,
  ));
}

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkillsCertificatesStateDataCopyWith<$Res> get data {
  
  return $SkillsCertificatesStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Error implements SkillsCertificatesState {
  const _Error({required this.data, required this.message});
  

@override final  SkillsCertificatesStateData data;
 final  BottomSheetMessageModel message;

/// Create a copy of SkillsCertificatesState
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
  return 'SkillsCertificatesState.error(data: $data, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SkillsCertificatesStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@override @useResult
$Res call({
 SkillsCertificatesStateData data, BottomSheetMessageModel message
});


@override $SkillsCertificatesStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? message = null,}) {
  return _then(_Error(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SkillsCertificatesStateData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as BottomSheetMessageModel,
  ));
}

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkillsCertificatesStateDataCopyWith<$Res> get data {
  
  return $SkillsCertificatesStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _LoadingMore implements SkillsCertificatesState {
  const _LoadingMore({required this.data});
  

@override final  SkillsCertificatesStateData data;

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingMoreCopyWith<_LoadingMore> get copyWith => __$LoadingMoreCopyWithImpl<_LoadingMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingMore&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'SkillsCertificatesState.loadingMore(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingMoreCopyWith<$Res> implements $SkillsCertificatesStateCopyWith<$Res> {
  factory _$LoadingMoreCopyWith(_LoadingMore value, $Res Function(_LoadingMore) _then) = __$LoadingMoreCopyWithImpl;
@override @useResult
$Res call({
 SkillsCertificatesStateData data
});


@override $SkillsCertificatesStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadingMoreCopyWithImpl<$Res>
    implements _$LoadingMoreCopyWith<$Res> {
  __$LoadingMoreCopyWithImpl(this._self, this._then);

  final _LoadingMore _self;
  final $Res Function(_LoadingMore) _then;

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_LoadingMore(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SkillsCertificatesStateData,
  ));
}

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkillsCertificatesStateDataCopyWith<$Res> get data {
  
  return $SkillsCertificatesStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _ConnectionError implements SkillsCertificatesState {
  const _ConnectionError({required this.data});
  

@override final  SkillsCertificatesStateData data;

/// Create a copy of SkillsCertificatesState
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
  return 'SkillsCertificatesState.connectionError(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $SkillsCertificatesStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@override @useResult
$Res call({
 SkillsCertificatesStateData data
});


@override $SkillsCertificatesStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ConnectionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SkillsCertificatesStateData,
  ));
}

/// Create a copy of SkillsCertificatesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SkillsCertificatesStateDataCopyWith<$Res> get data {
  
  return $SkillsCertificatesStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
