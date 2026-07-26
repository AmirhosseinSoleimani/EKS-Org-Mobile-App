import 'package:eks_sana_plus_org/src/features/shift/domain/entities/params/shift_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_page_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class ShiftRepository {
  Future<ApiResult<ShiftPageEntity>> getByFilter(ShiftFilterParamEntity param);

  Future<ApiResult<ShiftEntity>> getById(int id);

  Future<ApiResult<ShiftEntity>> create(ShiftEntity param);

  Future<ApiResult<ShiftEntity>> update(ShiftEntity param);

  Future<ApiResult<void>> deleteById(int id);
}
