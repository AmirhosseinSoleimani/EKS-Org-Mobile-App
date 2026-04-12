
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_share_data_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: MapShareDataRepository)
class MapShareDataRepositoryImpl extends MapShareDataRepository {

  MapShareDataRepositoryImpl();

  final BehaviorSubject<AddressInfoEntity?> _mapSharedDataSubject = BehaviorSubject.seeded(const AddressInfoEntity());

  @override
  void dispose() {
    _mapSharedDataSubject.close();
  }

  @override
  AddressInfoEntity? get fetchLocationInfo => _mapSharedDataSubject.valueOrNull;

  @override
  void setLocationInfoInfo(AddressInfoEntity? entity) {
    _mapSharedDataSubject.add(entity);
  }

}