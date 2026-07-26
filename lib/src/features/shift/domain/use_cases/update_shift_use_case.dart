import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/repositories/shift_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateShiftUseCase
    extends BaseUseCase<ApiResult<ShiftEntity>, ShiftEntity> {
  UpdateShiftUseCase(this._repository);

  final ShiftRepository _repository;

  @override
  Future<ApiResult<ShiftEntity>> call(ShiftEntity arg) {
    return _repository.update(arg);
  }
}
