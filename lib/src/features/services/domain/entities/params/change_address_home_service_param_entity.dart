

import 'package:eks_sana_plus_org/src/features/services/data/models/params/change_address_home_service_param_model.dart';

class ChangeAddressHomeServiceParamEntity {
  final String? address;
  final int? cityId;
  final int? homeServiceRequestId;
  final double? latitude;
  final double? longitude;

  const ChangeAddressHomeServiceParamEntity({
    this.address,
    this.cityId,
    this.homeServiceRequestId,
    this.latitude,
    this.longitude,
  });

  ChangeAddressHomeServiceParamModel toModel() {
    return ChangeAddressHomeServiceParamModel(
      address: address,
      cityId: cityId,
      homeServiceRequestId: homeServiceRequestId,
      latitude: latitude,
      longitude: longitude,
    );
  }

  ChangeAddressHomeServiceParamEntity copyWith({
    String? address,
    int? cityId,
    int? homeServiceRequestId,
    double? latitude,
    double? longitude,
  }) {
    return ChangeAddressHomeServiceParamEntity(
      address: address ?? this.address,
      cityId: cityId ?? this.cityId,
      homeServiceRequestId:
      homeServiceRequestId ?? this.homeServiceRequestId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
