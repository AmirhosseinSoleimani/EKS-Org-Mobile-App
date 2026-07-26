import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';

enum AddAgencyVehicleStatus {
  initial,
  searching,
  searchLoaded,
  searchEmpty,
  submitting,
  submitSuccess,
  failure,
  connectionError,
}

class AddAgencyVehicleState {
  const AddAgencyVehicleState({
    this.status = AddAgencyVehicleStatus.initial,
    this.vehicles = const [],
    this.selectedVehicle,
    this.createdId,
    this.errorMessage,
    this.searchCount = 0,
    this.contractTypeItems = const [],
    this.contractType,
    this.isActive = true,
  });

  final AddAgencyVehicleStatus status;
  final List<VehicleInfoSearchEntity> vehicles;
  final VehicleInfoSearchEntity? selectedVehicle;
  final String? createdId;
  final String? errorMessage;
  final int searchCount;
  final List<CurrentSessionEnumItemEntity> contractTypeItems;
  final int? contractType;
  final bool isActive;

  bool get isSearching => status == AddAgencyVehicleStatus.searching;
  bool get isSubmitting => status == AddAgencyVehicleStatus.submitting;

  AddAgencyVehicleState copyWith({
    AddAgencyVehicleStatus? status,
    List<VehicleInfoSearchEntity>? vehicles,
    VehicleInfoSearchEntity? selectedVehicle,
    bool clearSelectedVehicle = false,
    String? createdId,
    String? errorMessage,
    bool clearErrorMessage = false,
    int? searchCount,
    List<CurrentSessionEnumItemEntity>? contractTypeItems,
    int? contractType,
    bool? isActive,
  }) {
    return AddAgencyVehicleState(
      status: status ?? this.status,
      vehicles: vehicles ?? this.vehicles,
      selectedVehicle: clearSelectedVehicle
          ? null
          : selectedVehicle ?? this.selectedVehicle,
      createdId: createdId ?? this.createdId,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      searchCount: searchCount ?? this.searchCount,
      contractTypeItems: contractTypeItems ?? this.contractTypeItems,
      contractType: contractType ?? this.contractType,
      isActive: isActive ?? this.isActive,
    );
  }
}
