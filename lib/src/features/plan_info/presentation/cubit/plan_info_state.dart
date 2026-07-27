import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_cancelation_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';

enum PlanInfoStatus {
  idle,
  loading,
  loaded,
  loadingMore,
  submitting,
  error,
  connectionError,
}

class PlanInfoState {
  final bool? activeFilter;
  final PlanInfoStatus status;
  final List<PlanInfoEntity> items;
  final int totalCount;
  final bool hasMore;
  final String? message;
  final PlanInfoEntity? selectedPlan;
  final PlanCancelationEntity? cancelation;
  final List<PlanLookupEntity> emdadUnits;
  final List<PlanLookupEntity> shifts;
  final List<PlanLookupEntity> specialPlans;
  final List<PlanLookupEntity> locations;
  final List<PlanLookupEntity> seatTypes;
  final List<PlanLookupEntity> statusReasons;
  final List<PlanInfoEntity> reportItems;
  final String? reportFilePath;
  final List<PlanHistoryEntity> histories;
  final int? loadingHistoryRefId;

  const PlanInfoState({
    this.status = PlanInfoStatus.idle,
    this.activeFilter,
    this.items = const [],
    this.totalCount = 0,
    this.hasMore = false,
    this.message,
    this.selectedPlan,
    this.cancelation,
    this.emdadUnits = const [],
    this.shifts = const [],
    this.specialPlans = const [],
    this.locations = const [],
    this.seatTypes = const [],
    this.statusReasons = const [],
    this.reportItems = const [],
    this.reportFilePath,
    this.histories = const [],
    this.loadingHistoryRefId,
  });

  bool get isFirstLoading =>
      status == PlanInfoStatus.loading && items.isEmpty;

  bool get isSubmitting => status == PlanInfoStatus.submitting;

  PlanInfoState copyWith({
    bool? activeFilter,
    bool clearActiveFilter = false,
    PlanInfoStatus? status,
    List<PlanInfoEntity>? items,
    int? totalCount,
    bool? hasMore,
    String? message,
    bool clearMessage = false,
    PlanInfoEntity? selectedPlan,
    bool clearSelectedPlan = false,
    PlanCancelationEntity? cancelation,
    bool clearCancelation = false,
    List<PlanLookupEntity>? emdadUnits,
    List<PlanLookupEntity>? shifts,
    List<PlanLookupEntity>? specialPlans,
    List<PlanLookupEntity>? locations,
    List<PlanLookupEntity>? seatTypes,
    List<PlanLookupEntity>? statusReasons,
    List<PlanInfoEntity>? reportItems,
    String? reportFilePath,
    bool clearReportFilePath = false,
    List<PlanHistoryEntity>? histories,
    int? loadingHistoryRefId,
    bool clearLoadingHistoryRefId = false,
  }) {
    return PlanInfoState(
      activeFilter: clearActiveFilter
          ? null
          : activeFilter ?? this.activeFilter,
      status: status ?? this.status,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      message: clearMessage ? null : message ?? this.message,
      selectedPlan: clearSelectedPlan ? null : selectedPlan ?? this.selectedPlan,
      cancelation: clearCancelation ? null : cancelation ?? this.cancelation,
      emdadUnits: emdadUnits ?? this.emdadUnits,
      shifts: shifts ?? this.shifts,
      specialPlans: specialPlans ?? this.specialPlans,
      locations: locations ?? this.locations,
      seatTypes: seatTypes ?? this.seatTypes,
      statusReasons: statusReasons ?? this.statusReasons,
      reportItems: reportItems ?? this.reportItems,
      reportFilePath:
          clearReportFilePath ? null : reportFilePath ?? this.reportFilePath,
      histories: histories ?? this.histories,
      loadingHistoryRefId: clearLoadingHistoryRefId
          ? null
          : loadingHistoryRefId ?? this.loadingHistoryRefId,
    );
  }
}
