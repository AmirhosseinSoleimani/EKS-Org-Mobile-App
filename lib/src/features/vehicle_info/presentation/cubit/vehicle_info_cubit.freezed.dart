// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_info_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VehicleInfoStateData implements DiagnosticableTreeMixin {

 List<VehicleInfoEntity> get items; List<VehicleModelEntity> get vehicleModels; List<VehicleToolEntity> get tools; List<VehicleToolEntity> get filteredTools; List<EmdadServiceCategoryGroupEntity> get serviceCategoryGroups; List<VehicleDefectLimitationEntity> get defects; List<VehicleHistoryEntity> get histories; VehicleInfoEntity? get selectedItem; VehicleInfoFilterParamEntity get filter; int get totalCount; bool get hasMore; bool get isInitialLoading; bool get isRefreshing; bool get isPaginationLoading; bool get isLookupsLoading; bool get isSubmitting; bool get isReportLoading; int? get loadingDetailId; int? get deletingVehicleId; int? get loadingToolsVehicleId; int? get loadingServicesVehicleId; int? get loadingDefectsServiceCategoryId; int? get loadingHistoryRefId; int? get selectedServiceCategoryId; String get toolsSearchText; String? get reportFilePath; String? get successMessage; String? get errorMessage;
/// Create a copy of VehicleInfoStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleInfoStateDataCopyWith<VehicleInfoStateData> get copyWith => _$VehicleInfoStateDataCopyWithImpl<VehicleInfoStateData>(this as VehicleInfoStateData, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoStateData'))
    ..add(DiagnosticsProperty('items', items))..add(DiagnosticsProperty('vehicleModels', vehicleModels))..add(DiagnosticsProperty('tools', tools))..add(DiagnosticsProperty('filteredTools', filteredTools))..add(DiagnosticsProperty('serviceCategoryGroups', serviceCategoryGroups))..add(DiagnosticsProperty('defects', defects))..add(DiagnosticsProperty('histories', histories))..add(DiagnosticsProperty('selectedItem', selectedItem))..add(DiagnosticsProperty('filter', filter))..add(DiagnosticsProperty('totalCount', totalCount))..add(DiagnosticsProperty('hasMore', hasMore))..add(DiagnosticsProperty('isInitialLoading', isInitialLoading))..add(DiagnosticsProperty('isRefreshing', isRefreshing))..add(DiagnosticsProperty('isPaginationLoading', isPaginationLoading))..add(DiagnosticsProperty('isLookupsLoading', isLookupsLoading))..add(DiagnosticsProperty('isSubmitting', isSubmitting))..add(DiagnosticsProperty('isReportLoading', isReportLoading))..add(DiagnosticsProperty('loadingDetailId', loadingDetailId))..add(DiagnosticsProperty('deletingVehicleId', deletingVehicleId))..add(DiagnosticsProperty('loadingToolsVehicleId', loadingToolsVehicleId))..add(DiagnosticsProperty('loadingServicesVehicleId', loadingServicesVehicleId))..add(DiagnosticsProperty('loadingDefectsServiceCategoryId', loadingDefectsServiceCategoryId))..add(DiagnosticsProperty('loadingHistoryRefId', loadingHistoryRefId))..add(DiagnosticsProperty('selectedServiceCategoryId', selectedServiceCategoryId))..add(DiagnosticsProperty('toolsSearchText', toolsSearchText))..add(DiagnosticsProperty('reportFilePath', reportFilePath))..add(DiagnosticsProperty('successMessage', successMessage))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleInfoStateData&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.vehicleModels, vehicleModels)&&const DeepCollectionEquality().equals(other.tools, tools)&&const DeepCollectionEquality().equals(other.filteredTools, filteredTools)&&const DeepCollectionEquality().equals(other.serviceCategoryGroups, serviceCategoryGroups)&&const DeepCollectionEquality().equals(other.defects, defects)&&const DeepCollectionEquality().equals(other.histories, histories)&&(identical(other.selectedItem, selectedItem) || other.selectedItem == selectedItem)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isPaginationLoading, isPaginationLoading) || other.isPaginationLoading == isPaginationLoading)&&(identical(other.isLookupsLoading, isLookupsLoading) || other.isLookupsLoading == isLookupsLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isReportLoading, isReportLoading) || other.isReportLoading == isReportLoading)&&(identical(other.loadingDetailId, loadingDetailId) || other.loadingDetailId == loadingDetailId)&&(identical(other.deletingVehicleId, deletingVehicleId) || other.deletingVehicleId == deletingVehicleId)&&(identical(other.loadingToolsVehicleId, loadingToolsVehicleId) || other.loadingToolsVehicleId == loadingToolsVehicleId)&&(identical(other.loadingServicesVehicleId, loadingServicesVehicleId) || other.loadingServicesVehicleId == loadingServicesVehicleId)&&(identical(other.loadingDefectsServiceCategoryId, loadingDefectsServiceCategoryId) || other.loadingDefectsServiceCategoryId == loadingDefectsServiceCategoryId)&&(identical(other.loadingHistoryRefId, loadingHistoryRefId) || other.loadingHistoryRefId == loadingHistoryRefId)&&(identical(other.selectedServiceCategoryId, selectedServiceCategoryId) || other.selectedServiceCategoryId == selectedServiceCategoryId)&&(identical(other.toolsSearchText, toolsSearchText) || other.toolsSearchText == toolsSearchText)&&(identical(other.reportFilePath, reportFilePath) || other.reportFilePath == reportFilePath)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(vehicleModels),const DeepCollectionEquality().hash(tools),const DeepCollectionEquality().hash(filteredTools),const DeepCollectionEquality().hash(serviceCategoryGroups),const DeepCollectionEquality().hash(defects),const DeepCollectionEquality().hash(histories),selectedItem,filter,totalCount,hasMore,isInitialLoading,isRefreshing,isPaginationLoading,isLookupsLoading,isSubmitting,isReportLoading,loadingDetailId,deletingVehicleId,loadingToolsVehicleId,loadingServicesVehicleId,loadingDefectsServiceCategoryId,loadingHistoryRefId,selectedServiceCategoryId,toolsSearchText,reportFilePath,successMessage,errorMessage]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoStateData(items: $items, vehicleModels: $vehicleModels, tools: $tools, filteredTools: $filteredTools, serviceCategoryGroups: $serviceCategoryGroups, defects: $defects, histories: $histories, selectedItem: $selectedItem, filter: $filter, totalCount: $totalCount, hasMore: $hasMore, isInitialLoading: $isInitialLoading, isRefreshing: $isRefreshing, isPaginationLoading: $isPaginationLoading, isLookupsLoading: $isLookupsLoading, isSubmitting: $isSubmitting, isReportLoading: $isReportLoading, loadingDetailId: $loadingDetailId, deletingVehicleId: $deletingVehicleId, loadingToolsVehicleId: $loadingToolsVehicleId, loadingServicesVehicleId: $loadingServicesVehicleId, loadingDefectsServiceCategoryId: $loadingDefectsServiceCategoryId, loadingHistoryRefId: $loadingHistoryRefId, selectedServiceCategoryId: $selectedServiceCategoryId, toolsSearchText: $toolsSearchText, reportFilePath: $reportFilePath, successMessage: $successMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $VehicleInfoStateDataCopyWith<$Res>  {
  factory $VehicleInfoStateDataCopyWith(VehicleInfoStateData value, $Res Function(VehicleInfoStateData) _then) = _$VehicleInfoStateDataCopyWithImpl;
@useResult
$Res call({
 List<VehicleInfoEntity> items, List<VehicleModelEntity> vehicleModels, List<VehicleToolEntity> tools, List<VehicleToolEntity> filteredTools, List<EmdadServiceCategoryGroupEntity> serviceCategoryGroups, List<VehicleDefectLimitationEntity> defects, List<VehicleHistoryEntity> histories, VehicleInfoEntity? selectedItem, VehicleInfoFilterParamEntity filter, int totalCount, bool hasMore, bool isInitialLoading, bool isRefreshing, bool isPaginationLoading, bool isLookupsLoading, bool isSubmitting, bool isReportLoading, int? loadingDetailId, int? deletingVehicleId, int? loadingToolsVehicleId, int? loadingServicesVehicleId, int? loadingDefectsServiceCategoryId, int? loadingHistoryRefId, int? selectedServiceCategoryId, String toolsSearchText, String? reportFilePath, String? successMessage, String? errorMessage
});




}
/// @nodoc
class _$VehicleInfoStateDataCopyWithImpl<$Res>
    implements $VehicleInfoStateDataCopyWith<$Res> {
  _$VehicleInfoStateDataCopyWithImpl(this._self, this._then);

  final VehicleInfoStateData _self;
  final $Res Function(VehicleInfoStateData) _then;

/// Create a copy of VehicleInfoStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? vehicleModels = null,Object? tools = null,Object? filteredTools = null,Object? serviceCategoryGroups = null,Object? defects = null,Object? histories = null,Object? selectedItem = freezed,Object? filter = null,Object? totalCount = null,Object? hasMore = null,Object? isInitialLoading = null,Object? isRefreshing = null,Object? isPaginationLoading = null,Object? isLookupsLoading = null,Object? isSubmitting = null,Object? isReportLoading = null,Object? loadingDetailId = freezed,Object? deletingVehicleId = freezed,Object? loadingToolsVehicleId = freezed,Object? loadingServicesVehicleId = freezed,Object? loadingDefectsServiceCategoryId = freezed,Object? loadingHistoryRefId = freezed,Object? selectedServiceCategoryId = freezed,Object? toolsSearchText = null,Object? reportFilePath = freezed,Object? successMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<VehicleInfoEntity>,vehicleModels: null == vehicleModels ? _self.vehicleModels : vehicleModels // ignore: cast_nullable_to_non_nullable
as List<VehicleModelEntity>,tools: null == tools ? _self.tools : tools // ignore: cast_nullable_to_non_nullable
as List<VehicleToolEntity>,filteredTools: null == filteredTools ? _self.filteredTools : filteredTools // ignore: cast_nullable_to_non_nullable
as List<VehicleToolEntity>,serviceCategoryGroups: null == serviceCategoryGroups ? _self.serviceCategoryGroups : serviceCategoryGroups // ignore: cast_nullable_to_non_nullable
as List<EmdadServiceCategoryGroupEntity>,defects: null == defects ? _self.defects : defects // ignore: cast_nullable_to_non_nullable
as List<VehicleDefectLimitationEntity>,histories: null == histories ? _self.histories : histories // ignore: cast_nullable_to_non_nullable
as List<VehicleHistoryEntity>,selectedItem: freezed == selectedItem ? _self.selectedItem : selectedItem // ignore: cast_nullable_to_non_nullable
as VehicleInfoEntity?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as VehicleInfoFilterParamEntity,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isPaginationLoading: null == isPaginationLoading ? _self.isPaginationLoading : isPaginationLoading // ignore: cast_nullable_to_non_nullable
as bool,isLookupsLoading: null == isLookupsLoading ? _self.isLookupsLoading : isLookupsLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isReportLoading: null == isReportLoading ? _self.isReportLoading : isReportLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingDetailId: freezed == loadingDetailId ? _self.loadingDetailId : loadingDetailId // ignore: cast_nullable_to_non_nullable
as int?,deletingVehicleId: freezed == deletingVehicleId ? _self.deletingVehicleId : deletingVehicleId // ignore: cast_nullable_to_non_nullable
as int?,loadingToolsVehicleId: freezed == loadingToolsVehicleId ? _self.loadingToolsVehicleId : loadingToolsVehicleId // ignore: cast_nullable_to_non_nullable
as int?,loadingServicesVehicleId: freezed == loadingServicesVehicleId ? _self.loadingServicesVehicleId : loadingServicesVehicleId // ignore: cast_nullable_to_non_nullable
as int?,loadingDefectsServiceCategoryId: freezed == loadingDefectsServiceCategoryId ? _self.loadingDefectsServiceCategoryId : loadingDefectsServiceCategoryId // ignore: cast_nullable_to_non_nullable
as int?,loadingHistoryRefId: freezed == loadingHistoryRefId ? _self.loadingHistoryRefId : loadingHistoryRefId // ignore: cast_nullable_to_non_nullable
as int?,selectedServiceCategoryId: freezed == selectedServiceCategoryId ? _self.selectedServiceCategoryId : selectedServiceCategoryId // ignore: cast_nullable_to_non_nullable
as int?,toolsSearchText: null == toolsSearchText ? _self.toolsSearchText : toolsSearchText // ignore: cast_nullable_to_non_nullable
as String,reportFilePath: freezed == reportFilePath ? _self.reportFilePath : reportFilePath // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleInfoStateData].
extension VehicleInfoStateDataPatterns on VehicleInfoStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleInfoStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleInfoStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleInfoStateData value)  $default,){
final _that = this;
switch (_that) {
case _VehicleInfoStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleInfoStateData value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleInfoStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VehicleInfoEntity> items,  List<VehicleModelEntity> vehicleModels,  List<VehicleToolEntity> tools,  List<VehicleToolEntity> filteredTools,  List<EmdadServiceCategoryGroupEntity> serviceCategoryGroups,  List<VehicleDefectLimitationEntity> defects,  List<VehicleHistoryEntity> histories,  VehicleInfoEntity? selectedItem,  VehicleInfoFilterParamEntity filter,  int totalCount,  bool hasMore,  bool isInitialLoading,  bool isRefreshing,  bool isPaginationLoading,  bool isLookupsLoading,  bool isSubmitting,  bool isReportLoading,  int? loadingDetailId,  int? deletingVehicleId,  int? loadingToolsVehicleId,  int? loadingServicesVehicleId,  int? loadingDefectsServiceCategoryId,  int? loadingHistoryRefId,  int? selectedServiceCategoryId,  String toolsSearchText,  String? reportFilePath,  String? successMessage,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleInfoStateData() when $default != null:
return $default(_that.items,_that.vehicleModels,_that.tools,_that.filteredTools,_that.serviceCategoryGroups,_that.defects,_that.histories,_that.selectedItem,_that.filter,_that.totalCount,_that.hasMore,_that.isInitialLoading,_that.isRefreshing,_that.isPaginationLoading,_that.isLookupsLoading,_that.isSubmitting,_that.isReportLoading,_that.loadingDetailId,_that.deletingVehicleId,_that.loadingToolsVehicleId,_that.loadingServicesVehicleId,_that.loadingDefectsServiceCategoryId,_that.loadingHistoryRefId,_that.selectedServiceCategoryId,_that.toolsSearchText,_that.reportFilePath,_that.successMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VehicleInfoEntity> items,  List<VehicleModelEntity> vehicleModels,  List<VehicleToolEntity> tools,  List<VehicleToolEntity> filteredTools,  List<EmdadServiceCategoryGroupEntity> serviceCategoryGroups,  List<VehicleDefectLimitationEntity> defects,  List<VehicleHistoryEntity> histories,  VehicleInfoEntity? selectedItem,  VehicleInfoFilterParamEntity filter,  int totalCount,  bool hasMore,  bool isInitialLoading,  bool isRefreshing,  bool isPaginationLoading,  bool isLookupsLoading,  bool isSubmitting,  bool isReportLoading,  int? loadingDetailId,  int? deletingVehicleId,  int? loadingToolsVehicleId,  int? loadingServicesVehicleId,  int? loadingDefectsServiceCategoryId,  int? loadingHistoryRefId,  int? selectedServiceCategoryId,  String toolsSearchText,  String? reportFilePath,  String? successMessage,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _VehicleInfoStateData():
return $default(_that.items,_that.vehicleModels,_that.tools,_that.filteredTools,_that.serviceCategoryGroups,_that.defects,_that.histories,_that.selectedItem,_that.filter,_that.totalCount,_that.hasMore,_that.isInitialLoading,_that.isRefreshing,_that.isPaginationLoading,_that.isLookupsLoading,_that.isSubmitting,_that.isReportLoading,_that.loadingDetailId,_that.deletingVehicleId,_that.loadingToolsVehicleId,_that.loadingServicesVehicleId,_that.loadingDefectsServiceCategoryId,_that.loadingHistoryRefId,_that.selectedServiceCategoryId,_that.toolsSearchText,_that.reportFilePath,_that.successMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VehicleInfoEntity> items,  List<VehicleModelEntity> vehicleModels,  List<VehicleToolEntity> tools,  List<VehicleToolEntity> filteredTools,  List<EmdadServiceCategoryGroupEntity> serviceCategoryGroups,  List<VehicleDefectLimitationEntity> defects,  List<VehicleHistoryEntity> histories,  VehicleInfoEntity? selectedItem,  VehicleInfoFilterParamEntity filter,  int totalCount,  bool hasMore,  bool isInitialLoading,  bool isRefreshing,  bool isPaginationLoading,  bool isLookupsLoading,  bool isSubmitting,  bool isReportLoading,  int? loadingDetailId,  int? deletingVehicleId,  int? loadingToolsVehicleId,  int? loadingServicesVehicleId,  int? loadingDefectsServiceCategoryId,  int? loadingHistoryRefId,  int? selectedServiceCategoryId,  String toolsSearchText,  String? reportFilePath,  String? successMessage,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _VehicleInfoStateData() when $default != null:
return $default(_that.items,_that.vehicleModels,_that.tools,_that.filteredTools,_that.serviceCategoryGroups,_that.defects,_that.histories,_that.selectedItem,_that.filter,_that.totalCount,_that.hasMore,_that.isInitialLoading,_that.isRefreshing,_that.isPaginationLoading,_that.isLookupsLoading,_that.isSubmitting,_that.isReportLoading,_that.loadingDetailId,_that.deletingVehicleId,_that.loadingToolsVehicleId,_that.loadingServicesVehicleId,_that.loadingDefectsServiceCategoryId,_that.loadingHistoryRefId,_that.selectedServiceCategoryId,_that.toolsSearchText,_that.reportFilePath,_that.successMessage,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _VehicleInfoStateData with DiagnosticableTreeMixin implements VehicleInfoStateData {
  const _VehicleInfoStateData({final  List<VehicleInfoEntity> items = const [], final  List<VehicleModelEntity> vehicleModels = const [], final  List<VehicleToolEntity> tools = const [], final  List<VehicleToolEntity> filteredTools = const [], final  List<EmdadServiceCategoryGroupEntity> serviceCategoryGroups = const [], final  List<VehicleDefectLimitationEntity> defects = const [], final  List<VehicleHistoryEntity> histories = const [], this.selectedItem, this.filter = const VehicleInfoFilterParamEntity(), this.totalCount = 0, this.hasMore = true, this.isInitialLoading = false, this.isRefreshing = false, this.isPaginationLoading = false, this.isLookupsLoading = false, this.isSubmitting = false, this.isReportLoading = false, this.loadingDetailId, this.deletingVehicleId, this.loadingToolsVehicleId, this.loadingServicesVehicleId, this.loadingDefectsServiceCategoryId, this.loadingHistoryRefId, this.selectedServiceCategoryId, this.toolsSearchText = '', this.reportFilePath, this.successMessage, this.errorMessage}): _items = items,_vehicleModels = vehicleModels,_tools = tools,_filteredTools = filteredTools,_serviceCategoryGroups = serviceCategoryGroups,_defects = defects,_histories = histories;
  

 final  List<VehicleInfoEntity> _items;
@override@JsonKey() List<VehicleInfoEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<VehicleModelEntity> _vehicleModels;
@override@JsonKey() List<VehicleModelEntity> get vehicleModels {
  if (_vehicleModels is EqualUnmodifiableListView) return _vehicleModels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicleModels);
}

 final  List<VehicleToolEntity> _tools;
@override@JsonKey() List<VehicleToolEntity> get tools {
  if (_tools is EqualUnmodifiableListView) return _tools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tools);
}

 final  List<VehicleToolEntity> _filteredTools;
@override@JsonKey() List<VehicleToolEntity> get filteredTools {
  if (_filteredTools is EqualUnmodifiableListView) return _filteredTools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredTools);
}

 final  List<EmdadServiceCategoryGroupEntity> _serviceCategoryGroups;
@override@JsonKey() List<EmdadServiceCategoryGroupEntity> get serviceCategoryGroups {
  if (_serviceCategoryGroups is EqualUnmodifiableListView) return _serviceCategoryGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceCategoryGroups);
}

 final  List<VehicleDefectLimitationEntity> _defects;
@override@JsonKey() List<VehicleDefectLimitationEntity> get defects {
  if (_defects is EqualUnmodifiableListView) return _defects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_defects);
}

 final  List<VehicleHistoryEntity> _histories;
@override@JsonKey() List<VehicleHistoryEntity> get histories {
  if (_histories is EqualUnmodifiableListView) return _histories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_histories);
}

@override final  VehicleInfoEntity? selectedItem;
@override@JsonKey() final  VehicleInfoFilterParamEntity filter;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isPaginationLoading;
@override@JsonKey() final  bool isLookupsLoading;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isReportLoading;
@override final  int? loadingDetailId;
@override final  int? deletingVehicleId;
@override final  int? loadingToolsVehicleId;
@override final  int? loadingServicesVehicleId;
@override final  int? loadingDefectsServiceCategoryId;
@override final  int? loadingHistoryRefId;
@override final  int? selectedServiceCategoryId;
@override@JsonKey() final  String toolsSearchText;
@override final  String? reportFilePath;
@override final  String? successMessage;
@override final  String? errorMessage;

/// Create a copy of VehicleInfoStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleInfoStateDataCopyWith<_VehicleInfoStateData> get copyWith => __$VehicleInfoStateDataCopyWithImpl<_VehicleInfoStateData>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoStateData'))
    ..add(DiagnosticsProperty('items', items))..add(DiagnosticsProperty('vehicleModels', vehicleModels))..add(DiagnosticsProperty('tools', tools))..add(DiagnosticsProperty('filteredTools', filteredTools))..add(DiagnosticsProperty('serviceCategoryGroups', serviceCategoryGroups))..add(DiagnosticsProperty('defects', defects))..add(DiagnosticsProperty('histories', histories))..add(DiagnosticsProperty('selectedItem', selectedItem))..add(DiagnosticsProperty('filter', filter))..add(DiagnosticsProperty('totalCount', totalCount))..add(DiagnosticsProperty('hasMore', hasMore))..add(DiagnosticsProperty('isInitialLoading', isInitialLoading))..add(DiagnosticsProperty('isRefreshing', isRefreshing))..add(DiagnosticsProperty('isPaginationLoading', isPaginationLoading))..add(DiagnosticsProperty('isLookupsLoading', isLookupsLoading))..add(DiagnosticsProperty('isSubmitting', isSubmitting))..add(DiagnosticsProperty('isReportLoading', isReportLoading))..add(DiagnosticsProperty('loadingDetailId', loadingDetailId))..add(DiagnosticsProperty('deletingVehicleId', deletingVehicleId))..add(DiagnosticsProperty('loadingToolsVehicleId', loadingToolsVehicleId))..add(DiagnosticsProperty('loadingServicesVehicleId', loadingServicesVehicleId))..add(DiagnosticsProperty('loadingDefectsServiceCategoryId', loadingDefectsServiceCategoryId))..add(DiagnosticsProperty('loadingHistoryRefId', loadingHistoryRefId))..add(DiagnosticsProperty('selectedServiceCategoryId', selectedServiceCategoryId))..add(DiagnosticsProperty('toolsSearchText', toolsSearchText))..add(DiagnosticsProperty('reportFilePath', reportFilePath))..add(DiagnosticsProperty('successMessage', successMessage))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleInfoStateData&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._vehicleModels, _vehicleModels)&&const DeepCollectionEquality().equals(other._tools, _tools)&&const DeepCollectionEquality().equals(other._filteredTools, _filteredTools)&&const DeepCollectionEquality().equals(other._serviceCategoryGroups, _serviceCategoryGroups)&&const DeepCollectionEquality().equals(other._defects, _defects)&&const DeepCollectionEquality().equals(other._histories, _histories)&&(identical(other.selectedItem, selectedItem) || other.selectedItem == selectedItem)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isPaginationLoading, isPaginationLoading) || other.isPaginationLoading == isPaginationLoading)&&(identical(other.isLookupsLoading, isLookupsLoading) || other.isLookupsLoading == isLookupsLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isReportLoading, isReportLoading) || other.isReportLoading == isReportLoading)&&(identical(other.loadingDetailId, loadingDetailId) || other.loadingDetailId == loadingDetailId)&&(identical(other.deletingVehicleId, deletingVehicleId) || other.deletingVehicleId == deletingVehicleId)&&(identical(other.loadingToolsVehicleId, loadingToolsVehicleId) || other.loadingToolsVehicleId == loadingToolsVehicleId)&&(identical(other.loadingServicesVehicleId, loadingServicesVehicleId) || other.loadingServicesVehicleId == loadingServicesVehicleId)&&(identical(other.loadingDefectsServiceCategoryId, loadingDefectsServiceCategoryId) || other.loadingDefectsServiceCategoryId == loadingDefectsServiceCategoryId)&&(identical(other.loadingHistoryRefId, loadingHistoryRefId) || other.loadingHistoryRefId == loadingHistoryRefId)&&(identical(other.selectedServiceCategoryId, selectedServiceCategoryId) || other.selectedServiceCategoryId == selectedServiceCategoryId)&&(identical(other.toolsSearchText, toolsSearchText) || other.toolsSearchText == toolsSearchText)&&(identical(other.reportFilePath, reportFilePath) || other.reportFilePath == reportFilePath)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_vehicleModels),const DeepCollectionEquality().hash(_tools),const DeepCollectionEquality().hash(_filteredTools),const DeepCollectionEquality().hash(_serviceCategoryGroups),const DeepCollectionEquality().hash(_defects),const DeepCollectionEquality().hash(_histories),selectedItem,filter,totalCount,hasMore,isInitialLoading,isRefreshing,isPaginationLoading,isLookupsLoading,isSubmitting,isReportLoading,loadingDetailId,deletingVehicleId,loadingToolsVehicleId,loadingServicesVehicleId,loadingDefectsServiceCategoryId,loadingHistoryRefId,selectedServiceCategoryId,toolsSearchText,reportFilePath,successMessage,errorMessage]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoStateData(items: $items, vehicleModels: $vehicleModels, tools: $tools, filteredTools: $filteredTools, serviceCategoryGroups: $serviceCategoryGroups, defects: $defects, histories: $histories, selectedItem: $selectedItem, filter: $filter, totalCount: $totalCount, hasMore: $hasMore, isInitialLoading: $isInitialLoading, isRefreshing: $isRefreshing, isPaginationLoading: $isPaginationLoading, isLookupsLoading: $isLookupsLoading, isSubmitting: $isSubmitting, isReportLoading: $isReportLoading, loadingDetailId: $loadingDetailId, deletingVehicleId: $deletingVehicleId, loadingToolsVehicleId: $loadingToolsVehicleId, loadingServicesVehicleId: $loadingServicesVehicleId, loadingDefectsServiceCategoryId: $loadingDefectsServiceCategoryId, loadingHistoryRefId: $loadingHistoryRefId, selectedServiceCategoryId: $selectedServiceCategoryId, toolsSearchText: $toolsSearchText, reportFilePath: $reportFilePath, successMessage: $successMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$VehicleInfoStateDataCopyWith<$Res> implements $VehicleInfoStateDataCopyWith<$Res> {
  factory _$VehicleInfoStateDataCopyWith(_VehicleInfoStateData value, $Res Function(_VehicleInfoStateData) _then) = __$VehicleInfoStateDataCopyWithImpl;
@override @useResult
$Res call({
 List<VehicleInfoEntity> items, List<VehicleModelEntity> vehicleModels, List<VehicleToolEntity> tools, List<VehicleToolEntity> filteredTools, List<EmdadServiceCategoryGroupEntity> serviceCategoryGroups, List<VehicleDefectLimitationEntity> defects, List<VehicleHistoryEntity> histories, VehicleInfoEntity? selectedItem, VehicleInfoFilterParamEntity filter, int totalCount, bool hasMore, bool isInitialLoading, bool isRefreshing, bool isPaginationLoading, bool isLookupsLoading, bool isSubmitting, bool isReportLoading, int? loadingDetailId, int? deletingVehicleId, int? loadingToolsVehicleId, int? loadingServicesVehicleId, int? loadingDefectsServiceCategoryId, int? loadingHistoryRefId, int? selectedServiceCategoryId, String toolsSearchText, String? reportFilePath, String? successMessage, String? errorMessage
});




}
/// @nodoc
class __$VehicleInfoStateDataCopyWithImpl<$Res>
    implements _$VehicleInfoStateDataCopyWith<$Res> {
  __$VehicleInfoStateDataCopyWithImpl(this._self, this._then);

  final _VehicleInfoStateData _self;
  final $Res Function(_VehicleInfoStateData) _then;

/// Create a copy of VehicleInfoStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? vehicleModels = null,Object? tools = null,Object? filteredTools = null,Object? serviceCategoryGroups = null,Object? defects = null,Object? histories = null,Object? selectedItem = freezed,Object? filter = null,Object? totalCount = null,Object? hasMore = null,Object? isInitialLoading = null,Object? isRefreshing = null,Object? isPaginationLoading = null,Object? isLookupsLoading = null,Object? isSubmitting = null,Object? isReportLoading = null,Object? loadingDetailId = freezed,Object? deletingVehicleId = freezed,Object? loadingToolsVehicleId = freezed,Object? loadingServicesVehicleId = freezed,Object? loadingDefectsServiceCategoryId = freezed,Object? loadingHistoryRefId = freezed,Object? selectedServiceCategoryId = freezed,Object? toolsSearchText = null,Object? reportFilePath = freezed,Object? successMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(_VehicleInfoStateData(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<VehicleInfoEntity>,vehicleModels: null == vehicleModels ? _self._vehicleModels : vehicleModels // ignore: cast_nullable_to_non_nullable
as List<VehicleModelEntity>,tools: null == tools ? _self._tools : tools // ignore: cast_nullable_to_non_nullable
as List<VehicleToolEntity>,filteredTools: null == filteredTools ? _self._filteredTools : filteredTools // ignore: cast_nullable_to_non_nullable
as List<VehicleToolEntity>,serviceCategoryGroups: null == serviceCategoryGroups ? _self._serviceCategoryGroups : serviceCategoryGroups // ignore: cast_nullable_to_non_nullable
as List<EmdadServiceCategoryGroupEntity>,defects: null == defects ? _self._defects : defects // ignore: cast_nullable_to_non_nullable
as List<VehicleDefectLimitationEntity>,histories: null == histories ? _self._histories : histories // ignore: cast_nullable_to_non_nullable
as List<VehicleHistoryEntity>,selectedItem: freezed == selectedItem ? _self.selectedItem : selectedItem // ignore: cast_nullable_to_non_nullable
as VehicleInfoEntity?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as VehicleInfoFilterParamEntity,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isPaginationLoading: null == isPaginationLoading ? _self.isPaginationLoading : isPaginationLoading // ignore: cast_nullable_to_non_nullable
as bool,isLookupsLoading: null == isLookupsLoading ? _self.isLookupsLoading : isLookupsLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isReportLoading: null == isReportLoading ? _self.isReportLoading : isReportLoading // ignore: cast_nullable_to_non_nullable
as bool,loadingDetailId: freezed == loadingDetailId ? _self.loadingDetailId : loadingDetailId // ignore: cast_nullable_to_non_nullable
as int?,deletingVehicleId: freezed == deletingVehicleId ? _self.deletingVehicleId : deletingVehicleId // ignore: cast_nullable_to_non_nullable
as int?,loadingToolsVehicleId: freezed == loadingToolsVehicleId ? _self.loadingToolsVehicleId : loadingToolsVehicleId // ignore: cast_nullable_to_non_nullable
as int?,loadingServicesVehicleId: freezed == loadingServicesVehicleId ? _self.loadingServicesVehicleId : loadingServicesVehicleId // ignore: cast_nullable_to_non_nullable
as int?,loadingDefectsServiceCategoryId: freezed == loadingDefectsServiceCategoryId ? _self.loadingDefectsServiceCategoryId : loadingDefectsServiceCategoryId // ignore: cast_nullable_to_non_nullable
as int?,loadingHistoryRefId: freezed == loadingHistoryRefId ? _self.loadingHistoryRefId : loadingHistoryRefId // ignore: cast_nullable_to_non_nullable
as int?,selectedServiceCategoryId: freezed == selectedServiceCategoryId ? _self.selectedServiceCategoryId : selectedServiceCategoryId // ignore: cast_nullable_to_non_nullable
as int?,toolsSearchText: null == toolsSearchText ? _self.toolsSearchText : toolsSearchText // ignore: cast_nullable_to_non_nullable
as String,reportFilePath: freezed == reportFilePath ? _self.reportFilePath : reportFilePath // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$VehicleInfoState implements DiagnosticableTreeMixin {

 VehicleInfoStateData get data;
/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleInfoStateCopyWith<VehicleInfoState> get copyWith => _$VehicleInfoStateCopyWithImpl<VehicleInfoState>(this as VehicleInfoState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoState'))
    ..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleInfoState&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoState(data: $data)';
}


}

/// @nodoc
abstract mixin class $VehicleInfoStateCopyWith<$Res>  {
  factory $VehicleInfoStateCopyWith(VehicleInfoState value, $Res Function(VehicleInfoState) _then) = _$VehicleInfoStateCopyWithImpl;
@useResult
$Res call({
 VehicleInfoStateData data
});


$VehicleInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class _$VehicleInfoStateCopyWithImpl<$Res>
    implements $VehicleInfoStateCopyWith<$Res> {
  _$VehicleInfoStateCopyWithImpl(this._self, this._then);

  final VehicleInfoState _self;
  final $Res Function(VehicleInfoState) _then;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VehicleInfoStateData,
  ));
}
/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleInfoStateDataCopyWith<$Res> get data {
  
  return $VehicleInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [VehicleInfoState].
extension VehicleInfoStatePatterns on VehicleInfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,TResult Function( _ConnectionError value)?  connectionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Success() when success != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,required TResult Function( _ConnectionError value)  connectionError,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Success():
return success(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,TResult? Function( _ConnectionError value)?  connectionError,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Success() when success != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( VehicleInfoStateData data)?  idle,TResult Function( VehicleInfoStateData data)?  loading,TResult Function( VehicleInfoStateData data)?  loaded,TResult Function( VehicleInfoStateData data)?  success,TResult Function( VehicleInfoStateData data)?  failure,TResult Function( VehicleInfoStateData data)?  connectionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Success() when success != null:
return success(_that.data);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( VehicleInfoStateData data)  idle,required TResult Function( VehicleInfoStateData data)  loading,required TResult Function( VehicleInfoStateData data)  loaded,required TResult Function( VehicleInfoStateData data)  success,required TResult Function( VehicleInfoStateData data)  failure,required TResult Function( VehicleInfoStateData data)  connectionError,}) {final _that = this;
switch (_that) {
case _Idle():
return idle(_that.data);case _Loading():
return loading(_that.data);case _Loaded():
return loaded(_that.data);case _Success():
return success(_that.data);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( VehicleInfoStateData data)?  idle,TResult? Function( VehicleInfoStateData data)?  loading,TResult? Function( VehicleInfoStateData data)?  loaded,TResult? Function( VehicleInfoStateData data)?  success,TResult? Function( VehicleInfoStateData data)?  failure,TResult? Function( VehicleInfoStateData data)?  connectionError,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that.data);case _Loading() when loading != null:
return loading(_that.data);case _Loaded() when loaded != null:
return loaded(_that.data);case _Success() when success != null:
return success(_that.data);case _Failure() when failure != null:
return failure(_that.data);case _ConnectionError() when connectionError != null:
return connectionError(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Idle with DiagnosticableTreeMixin implements VehicleInfoState {
  const _Idle({this.data = const VehicleInfoStateData()});
  

@override@JsonKey() final  VehicleInfoStateData data;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IdleCopyWith<_Idle> get copyWith => __$IdleCopyWithImpl<_Idle>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoState.idle'))
    ..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoState.idle(data: $data)';
}


}

/// @nodoc
abstract mixin class _$IdleCopyWith<$Res> implements $VehicleInfoStateCopyWith<$Res> {
  factory _$IdleCopyWith(_Idle value, $Res Function(_Idle) _then) = __$IdleCopyWithImpl;
@override @useResult
$Res call({
 VehicleInfoStateData data
});


@override $VehicleInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$IdleCopyWithImpl<$Res>
    implements _$IdleCopyWith<$Res> {
  __$IdleCopyWithImpl(this._self, this._then);

  final _Idle _self;
  final $Res Function(_Idle) _then;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Idle(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VehicleInfoStateData,
  ));
}

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleInfoStateDataCopyWith<$Res> get data {
  
  return $VehicleInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loading with DiagnosticableTreeMixin implements VehicleInfoState {
  const _Loading({required this.data});
  

@override final  VehicleInfoStateData data;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoState.loading'))
    ..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoState.loading(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $VehicleInfoStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 VehicleInfoStateData data
});


@override $VehicleInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loading(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VehicleInfoStateData,
  ));
}

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleInfoStateDataCopyWith<$Res> get data {
  
  return $VehicleInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Loaded with DiagnosticableTreeMixin implements VehicleInfoState {
  const _Loaded({required this.data});
  

@override final  VehicleInfoStateData data;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoState.loaded'))
    ..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $VehicleInfoStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@override @useResult
$Res call({
 VehicleInfoStateData data
});


@override $VehicleInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Loaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VehicleInfoStateData,
  ));
}

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleInfoStateDataCopyWith<$Res> get data {
  
  return $VehicleInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Success with DiagnosticableTreeMixin implements VehicleInfoState {
  const _Success({required this.data});
  

@override final  VehicleInfoStateData data;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoState.success'))
    ..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $VehicleInfoStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@override @useResult
$Res call({
 VehicleInfoStateData data
});


@override $VehicleInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Success(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VehicleInfoStateData,
  ));
}

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleInfoStateDataCopyWith<$Res> get data {
  
  return $VehicleInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Failure with DiagnosticableTreeMixin implements VehicleInfoState {
  const _Failure({required this.data});
  

@override final  VehicleInfoStateData data;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoState.failure'))
    ..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoState.failure(data: $data)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $VehicleInfoStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@override @useResult
$Res call({
 VehicleInfoStateData data
});


@override $VehicleInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_Failure(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VehicleInfoStateData,
  ));
}

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleInfoStateDataCopyWith<$Res> get data {
  
  return $VehicleInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _ConnectionError with DiagnosticableTreeMixin implements VehicleInfoState {
  const _ConnectionError({required this.data});
  

@override final  VehicleInfoStateData data;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionErrorCopyWith<_ConnectionError> get copyWith => __$ConnectionErrorCopyWithImpl<_ConnectionError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'VehicleInfoState.connectionError'))
    ..add(DiagnosticsProperty('data', data));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionError&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'VehicleInfoState.connectionError(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ConnectionErrorCopyWith<$Res> implements $VehicleInfoStateCopyWith<$Res> {
  factory _$ConnectionErrorCopyWith(_ConnectionError value, $Res Function(_ConnectionError) _then) = __$ConnectionErrorCopyWithImpl;
@override @useResult
$Res call({
 VehicleInfoStateData data
});


@override $VehicleInfoStateDataCopyWith<$Res> get data;

}
/// @nodoc
class __$ConnectionErrorCopyWithImpl<$Res>
    implements _$ConnectionErrorCopyWith<$Res> {
  __$ConnectionErrorCopyWithImpl(this._self, this._then);

  final _ConnectionError _self;
  final $Res Function(_ConnectionError) _then;

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ConnectionError(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as VehicleInfoStateData,
  ));
}

/// Create a copy of VehicleInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VehicleInfoStateDataCopyWith<$Res> get data {
  
  return $VehicleInfoStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
