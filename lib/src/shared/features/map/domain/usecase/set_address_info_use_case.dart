import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_share_data_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetAddressInfoUseCase extends BaseUseCase<void, AddressInfoEntity?> {
  SetAddressInfoUseCase(this._repository);

  final MapShareDataRepository _repository;

  @override
  Future<void> call(arg) async {
    final result = _repository.setLocationInfoInfo(arg);
    return result;
  }
}
