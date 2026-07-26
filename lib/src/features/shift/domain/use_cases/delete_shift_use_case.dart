import 'package:eks_sana_plus_org/src/features/shift/domain/repositories/shift_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteShiftUseCase extends BaseUseCase<ApiResult<void>, int> {
  DeleteShiftUseCase(this._repository);

  final ShiftRepository _repository;

  @override
  Future<ApiResult<void>> call(int arg) {
    return _repository.deleteById(arg);
  }
}
