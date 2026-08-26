import 'package:eks_sana_plus_org/src/features/shift/data/data_sources/shift_data_source.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/params/shift_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/repositories/shift_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ShiftRepository)
class ShiftRepositoryImpl extends ShiftRepository {
  ShiftRepositoryImpl(this._dataSource);

  final ShiftDataSource _dataSource;

  @override
  Future<ApiResult<ShiftPageEntity>> getByFilter(
    ShiftFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getByFilter(param.toModel());
      return result.toApiResult<ShiftPageEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ShiftEntity>> getById(int id) async {
    try {
      final result = await _dataSource.getById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ShiftEntity>> create(ShiftEntity param) async {
    try {
      final result = await _dataSource.create(param.toModel().toMutationJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ShiftEntity>> update(ShiftEntity param) async {
    try {
      final result = await _dataSource.update(param.toModel().toMutationJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> deleteById(int id) async {
    try {
      final result = await _dataSource.deleteById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
