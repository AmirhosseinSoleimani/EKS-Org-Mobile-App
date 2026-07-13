part of 'emdad_unit_cubit.dart';

enum EmdadUnitViewStatus {
  initial,
  loading,
  loaded,
  empty,
  loadingMore,
  submitting,
  success,
  failure,
  connectionError,
}

class EmdadUnitState {
  const EmdadUnitState({
    this.status = EmdadUnitViewStatus.initial,
    this.items = const [],
    this.persons = const [],
    this.agencies = const [],
    this.agencyPersons = const [],
    this.agencyVehicles = const [],
    this.locations = const [],
    this.selectedItem,
    this.filter = const EmdadUnitFilterParamEntity(),
    this.totalCount = 0,
    this.hasMore = true,
    this.isLookupsLoading = false,
    this.message,
  });

  final EmdadUnitViewStatus status;
  final List<EmdadUnitEntity> items;
  final List<EmdadUnitPersonEntity> persons;
  final List<LookupEntity> agencies;
  final List<LookupEntity> agencyPersons;
  final List<LookupEntity> agencyVehicles;
  final List<LookupEntity> locations;
  final EmdadUnitEntity? selectedItem;
  final EmdadUnitFilterParamEntity filter;
  final int totalCount;
  final bool hasMore;
  final bool isLookupsLoading;
  final String? message;

  bool get isBusy {
    return status == EmdadUnitViewStatus.loading ||
        status == EmdadUnitViewStatus.loadingMore ||
        status == EmdadUnitViewStatus.submitting;
  }

  EmdadUnitState copyWith({
    EmdadUnitViewStatus? status,
    List<EmdadUnitEntity>? items,
    List<EmdadUnitPersonEntity>? persons,
    List<LookupEntity>? agencies,
    List<LookupEntity>? agencyPersons,
    List<LookupEntity>? agencyVehicles,
    List<LookupEntity>? locations,
    EmdadUnitEntity? selectedItem,
    bool clearSelectedItem = false,
    EmdadUnitFilterParamEntity? filter,
    int? totalCount,
    bool? hasMore,
    bool? isLookupsLoading,
    String? message,
    bool clearMessage = false,
  }) {
    return EmdadUnitState(
      status: status ?? this.status,
      items: items ?? this.items,
      persons: persons ?? this.persons,
      agencies: agencies ?? this.agencies,
      agencyPersons: agencyPersons ?? this.agencyPersons,
      agencyVehicles: agencyVehicles ?? this.agencyVehicles,
      locations: locations ?? this.locations,
      selectedItem: clearSelectedItem ? null : selectedItem ?? this.selectedItem,
      filter: filter ?? this.filter,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      isLookupsLoading: isLookupsLoading ?? this.isLookupsLoading,
      message: clearMessage ? null : message ?? this.message,
    );
  }
}
