import 'package:eks_sana_plus_org/src/features/services/data/data_source/request_history_data_source.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/car_covers_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/check_depot_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/complete_urgent_request_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/control_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/day_schedule_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/distance_kilometer_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_followups_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/service_assign_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/follow_up_status_type_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/message_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/minimal_customer_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/change_address_home_service_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/change_time_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/chassis_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/check_depot_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/complete_urgent_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/create_follow_up_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/distance_kilometer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/emdadgar_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_emdadgar_followups_data_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_reference_car_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_times_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/minimal_customer_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_assign_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/update_service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/post_follow_up_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/reference_car_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/update_service_response_entity.dart';
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

  @override
  Future<ApiResult<UpdateServiceResponseEntity>> updateServiceRequest(UpdateServiceRequestParamEntity param) async {
    try {
      final result = await _dataSource.updateServiceRequest(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<CancelRequestReasonEntity>>> getCancelReasons(
      CancelReasonParamEntity param) async {
    try {
      final result = await _dataSource.getCancelReasons(param.toModel());
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<DistanceKilometerEntity>> getDistanceKilometer(DistanceKilometerParamEntity param) async {
    try {
      final result = await _dataSource.getDistanceKilometer(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> cancelServiceRequest(CancelRequestParamEntity param) async {
    try {
      final result = await _dataSource.cancelServiceRequest(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadgarFollowupsDataEntity>> getEmdadgarFollowupsData(GetEmdadgarFollowupsDataParamEntity param) async {
    try {
      final result = await _dataSource.getEmdadgarFollowupsData(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<CompleteUrgentRequestDataEntity>> completeAidUrgentRequest(
      CompleteUrgentParamEntity param) async {
    try {
      final result = await _dataSource.completeAidUrgentRequest(
          param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<CarCoversDataEntity>> getBasicData() async {
    try {
      final result = await _dataSource.getBasicData();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ReferenceCarEntity>> getReferenceCar(
      GetReferenceCarParamEntity param) async {
    try {
      final result = await _dataSource.getReferenceCar(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<MinimalCustomerInfoEntity>> getMinimalCustomerInfo(MinimalCustomerInfoParamEntity param) async {
    try {
      final result = await _dataSource.getMinimalCustomerInfo(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PostFollowUpResponseEntity>> createFollowUp(CreateFollowUpParamEntity param) async{
    try {
      final result = await _dataSource.createFollowUp(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<FollowUpStatusTypeEntity>>> getFollowUpStatusTypes()async {
    try {
      final result = await _dataSource.getFollowUpStatusTypes();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<MessageEntity>> changeTime(
      ChangeTimeParamEntity param) async {
    try {
      final result = await _dataSource.changeTime(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<DayScheduleEntity>>> getTimes(
      GetTimesParamEntity param) async {
    try {
      final result = await _dataSource.getTimes(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<MessageEntity>> changeAddressHomeServiceRequest(
      ChangeAddressHomeServiceParamEntity param) async {
    try {
      final result = await _dataSource.changeAddressHomeServiceRequest(
          param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<CheckDepotEntity>> getCheckDepot(
      CheckDepotParamEntity param) async {
    try {
      final result = await _dataSource.getCheckDepot(
          param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<EmdadgarEntity>>> getEmdadgarList(
      EmdadgarListParamEntity param) async {
    try {
      final result = await _dataSource.getEmdadgarList(
          param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ServiceAssignResponseEntity>> serviceAssign(
      ServiceAssignParamEntity param) async {
    try {
      final result = await _dataSource.serviceAssign(
          param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
