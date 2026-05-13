import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/change_address_home_service_param_entity.dart';

class ChangeAddressHomeServiceParamModel
    extends ChangeAddressHomeServiceParamEntity {
  const ChangeAddressHomeServiceParamModel({
    super.address,
    super.cityId,
    super.homeServiceRequestId,
    super.latitude,
    super.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'cityId': cityId,
      'homeServiceRequestId': homeServiceRequestId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
