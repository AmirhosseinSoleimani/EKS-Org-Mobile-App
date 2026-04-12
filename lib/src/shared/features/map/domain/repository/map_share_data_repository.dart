import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';

abstract class MapShareDataRepository {
  void setLocationInfoInfo(AddressInfoEntity? entity);
  AddressInfoEntity? get fetchLocationInfo;
  void dispose();
}
