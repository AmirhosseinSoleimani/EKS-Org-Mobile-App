import 'package:eks_sana_plus_org/src/features/services/data/data_source/request_history_data_source.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/chassis_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
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
  Future<ApiResult<ReliefRequestListEntity>> getReliefRequestList(RequestFilterParamEntity param) async {
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
  Future<ApiResult<HomeServiceRequestListEntity>> getHomeServiceRequestList(RequestFilterParamEntity param) async {
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
  Future<ApiResult<List<CartableCycleItemEntity>>> getCartableCycleList(RequestOperationParamEntity param) async {
    try {
      final result = await _dataSource.getCartableCycleList(param.toModel());
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

  @override
  Future<ApiResult<FollowupEntity>> getRequestFollowupHistory(RequestOperationParamEntity param) async {
    try {
      final result = await _dataSource.getRequestFollowUp(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<ChassisRequestHistoryEntity>>> getChassisRequestHistoryList(ChassisParamEntity param) async {
    try {
      final result = await _dataSource.getChassisRequestHistoryList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ControlInfoEntity>> getControlInfo(
      ServiceRequestParamEntity param) async {
    try {
      final result = await _dataSource.getControlInfo(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
