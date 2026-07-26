import 'package:eks_sana_plus_org/src/common/event_bus/app_event_bus.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/features/shift/data/data_sources/shift_data_source.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/params/shift_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/shift/domain/repositories/shift_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
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
      return ApiResult.success(data: result, resultCode: 0);
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
      return _mapBaseResponse(result);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  ApiResult<void> _mapBaseResponse(BaseResponse response) {
    switch (response.resultCode) {
      case 0:
        return const ApiResult.success(data: null, resultCode: 0);
      case 3:
        AppEventBus.emit(AppEvent.tokenExpired);
        return const ApiResult.expireToken();
      case 1:
      case 2:
      case 4:
      default:
        return ApiResult.failure(
          failures: response.failures?.listToString() ??
              'خطای غیرمنتظره، لطفا با شماره 096550 تماس بگیرید',
        );
    }
  }
}
