import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/person_info_search_entity.dart';

enum AddAgencyPersonStatus {
  initial,
  searching,
  searchLoaded,
  searchEmpty,
  submitting,
  submitSuccess,
  failure,
  connectionError,
}

class AddAgencyPersonState {
  const AddAgencyPersonState({
    this.status = AddAgencyPersonStatus.initial,
    this.persons = const [],
    this.selectedPerson,
    this.createdId,
    this.errorMessage,
    this.searchCount = 0,
    this.issuanceOnIdCard = false,
    this.isActive = true,
    this.activityType = '1',
  });

  final AddAgencyPersonStatus status;
  final List<PersonInfoSearchEntity> persons;
  final PersonInfoSearchEntity? selectedPerson;
  final String? createdId;
  final String? errorMessage;
  final int searchCount;
  final bool issuanceOnIdCard;
  final bool isActive;
  final String activityType;

  bool get isSearching => status == AddAgencyPersonStatus.searching;
  bool get isSubmitting => status == AddAgencyPersonStatus.submitting;
  bool get hasSearched {
    return status == AddAgencyPersonStatus.searchLoaded ||
        status == AddAgencyPersonStatus.searchEmpty;
  }

  AddAgencyPersonState copyWith({
    AddAgencyPersonStatus? status,
    List<PersonInfoSearchEntity>? persons,
    PersonInfoSearchEntity? selectedPerson,
    bool clearSelectedPerson = false,
    String? createdId,
    String? errorMessage,
    bool clearErrorMessage = false,
    int? searchCount,
    bool? issuanceOnIdCard,
    bool? isActive,
    String? activityType,
  }) {
    return AddAgencyPersonState(
      status: status ?? this.status,
      persons: persons ?? this.persons,
      selectedPerson:
          clearSelectedPerson ? null : selectedPerson ?? this.selectedPerson,
      createdId: createdId ?? this.createdId,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      searchCount: searchCount ?? this.searchCount,
      issuanceOnIdCard: issuanceOnIdCard ?? this.issuanceOnIdCard,
      isActive: isActive ?? this.isActive,
      activityType: activityType ?? this.activityType,
    );
  }
}
