import 'package:eks_sana_plus_org/src/features/services/data/data_source/request_history_data_source.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RequestRepository)
class RequestRepositoryImpl extends RequestRepository {
  final RequestDataSource _dataSource;

  RequestRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<ApiResult<List<ReliefRequestEntity>>> getReliefRequestList(RequestFilterParamEntity param) async {
    try {
      final result = await _dataSource.getReliefRequestList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ReliefRequestEntity?>> getReliefRequestById(int id) async {
    try {
      final result = await _dataSource.getReliefRequestById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<HomeServiceRequestEntity>>> getHomeServiceRequestList(RequestFilterParamEntity param) async {
    try {
      final result = await _dataSource.getHomeServiceRequestList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<HomeServiceRequestEntity?>> getHomeServiceRequestById(
      int id) async {
    try {
      final result = await _dataSource.getHomeServiceRequestById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<NonCooperationListEntity?>> getNonCooperationList(RequestOperationParamEntity param) async {
    try {
      final result = await _dataSource.getNonCooperationList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<CartableCycleListEntity?>> getCartableCycleList(RequestOperationParamEntity param) async {
    try {
      final result = await _dataSource.getNonCooperationList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<EvaluationHistoryItemEntity>>> getEvaluationHistory(
      ServiceRequestParamEntity param) async {
    try {
      final result = await _dataSource.getEvaluationHistory(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<RequestStatusHistoryListEntity>> getRequestStatusHistory(RequestOperationParamEntity param) async {
    try {
      final result = await _dataSource.getRequestStatusHistory(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadgarInfoEntity?>> getEmdadgarInfo(ServiceRequestParamEntity param) async {
    try {
      final result = await _dataSource.getEmdadgarInfo(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
