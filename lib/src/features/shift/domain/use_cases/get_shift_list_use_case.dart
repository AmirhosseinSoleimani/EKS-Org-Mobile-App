import 'package:eks_sana_plus_org/src/features/shift/domain/entities/params/shift_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/repositories/shift_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetShiftListUseCase
    extends BaseUseCase<ApiResult<ShiftPageEntity>, ShiftFilterParamEntity> {
  GetShiftListUseCase(this._repository);

  final ShiftRepository _repository;

  @override
  Future<ApiResult<ShiftPageEntity>> call(ShiftFilterParamEntity arg) {
    return _repository.getByFilter(arg);
  }
}
