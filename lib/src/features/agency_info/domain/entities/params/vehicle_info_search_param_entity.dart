import 'package:eks_sana_plus_org/src/features/agency_info/data/models/vehicle_info_search_request_model.dart';

class VehicleInfoSearchParamEntity {
  const VehicleInfoSearchParamEntity({this.searchValue});

  final String? searchValue;

  VehicleInfoSearchRequestModel toModel() {
    return VehicleInfoSearchRequestModel(searchValue: searchValue);
  }

  VehicleInfoSearchParamEntity copyWith({String? searchValue}) {
    return VehicleInfoSearchParamEntity(
      searchValue: searchValue ?? this.searchValue,
    );
  }
}
