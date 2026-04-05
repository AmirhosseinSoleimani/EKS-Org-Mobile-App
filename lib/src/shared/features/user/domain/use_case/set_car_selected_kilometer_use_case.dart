import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/car_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

import 'fetch_car_selected_use_case.dart';

@lazySingleton
class SetCarSelectedKilometerUseCase extends BaseUseCase<void, int> {
  SetCarSelectedKilometerUseCase(this._repository, this._fetchCarSelectedUseCase);

  final UserRepository _repository;
  final FetchCarSelectedUseCase _fetchCarSelectedUseCase;

  @override
  Future<void> call(arg) async {
    final current = await _fetchCarSelectedUseCase.call();
    if (current == null) {
      final newCar = const CarInfoEntity().copyWith(kilometer: arg);
      return _repository.setCarSelected(newCar);
    }
    final updated = current.copyWith(kilometer: arg);
    return _repository.setCarSelected(updated);
  }
}
