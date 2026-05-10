import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/Followup_Model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/cancel_request_reason_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/car_covers_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/cartable_cycle_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/chassis_request_history_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/complete_urgent_request_data_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/distance_kilometer_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_followups_data_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar_info_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/evaluation_history_item_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_list_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/cancel_reason_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/cancel_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/chassis_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/complete_urgent_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/distance_kilometer_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/get_emdadgar_followups_data_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/get_reference_car_param_data.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_operation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/update_service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/reference_car_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/request_status_history_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/update_service_response_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/service/request_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

import 'request_history_data_source.dart';

@LazySingleton(as: RequestDataSource)
class RequestDataSourceImpl extends RequestDataSource {
  final RequestService _service;
  RequestDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<ReliefRequestListModel>> getReliefRequestList(RequestFilterParamModel param) async =>
      await _service.getReliefRequestList(param.toJson());

  @override
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
      int id) async =>
      await _service.getReliefRequestById({"id": id});

  @override
  Future<BaseSingleResponse<HomeServiceRequestListModel>> getHomeServiceRequestList(RequestFilterParamModel param) async =>
      await _service.getHomeServiceRequestList(param.toJson());

  @override
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
      int id) async => await _service.getHomeServiceRequestById({"id": id});

  @override
  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
      RequestOperationParamModel param) async =>
      await _service.getNonCooperationList(param.toJson());

  @override
  Future<BaseListResponse<CartableCycleItemModel>> getCartableCycleList(RequestOperationParamModel param)async =>
      await _service.getCartableCycleList(param.toJson());

  @override
  Future<BaseListResponse<EvaluationHistoryItemModel>> getEvaluationHistory(
      ServiceRequestParamModel param) async =>
      param.serviceType == ServiceType.reliefService.value
          ? await _service.getAidServiceEvaluationHistory(param.toJson())
          : await _service.getHomeServiceServiceEvaluationHistory(
          param.toJson());

  @override
  Future<BaseSingleResponse<RequestStatusHistoryListModel>>
  getRequestStatusHistory(RequestOperationParamModel param) async =>
      await _service.getRequestStatusHistory(param.toJson());

  @override
  Future<BaseSingleResponse<EmdadgarInfoModel>> getEmdadgarInfo(
      ServiceRequestParamModel param) async =>
      await _service.getEmdadgarInfo(param.toJson());



  @override
  Future<BaseListResponse<ChassisRequestHistoryModel>> getChassisRequestHistoryList(ChassisParamModel param)  async =>
      await _service.getChassisRequestHistoryList(param.toJson());


  @override
  Future<BaseSingleResponse<ControlInfoModel>> getControlInfo(
          ServiceRequestParamModel param) async =>
      await _service.getControlInfo(param.toJson());


  @override
  Future<BaseSingleResponse<FollowupModel>> getRequestFollowUp(RequestOperationParamModel param) async =>
      await _service.getRequestFollowUp(param.toJson());

  @override
  Future<BaseSingleResponse<UpdateServiceResponseModel>> updateServiceRequest(UpdateServiceRequestParamModel param) async =>
      await _service.updateServiceRequest(param.toJson());

  @override
  Future<BaseListResponse<CancelRequestReasonModel>> getCancelReasons(
      CancelReasonParamModel param) async =>
      await _service.getCancelReasons(param.toJson());

  @override
  Future<BaseSingleResponse<DistanceKilometerModel>> getDistanceKilometer(
      DistanceKilometerParamModel param) async =>
      param.serviceType == ServiceType.reliefService
          ? await _service.getAidDistanceKilometer(param.toJson())
          : await _service.getHomeServiceDistanceKilometer(param.toJson());

  @override
  Future<BaseSingleResponse<void>> cancelServiceRequest(
      CancelRequestParamModel param) async =>
      param.serviceType == ServiceType.reliefService
          ? await _service.cancelAidRequestService(param.toJson())
          : await _service.cancelHomeServiceRequest(param.toJson());

  @override
  Future<BaseSingleResponse<EmdadgarFollowupsDataModel>> getEmdadgarFollowupsData(GetEmdadgarFollowupsDataParamModel param) async =>
     await _service.getAidEmdadgarFollowupsData(param.toJson());

  @override
  Future<BaseSingleResponse<CompleteUrgentRequestDataModel>> completeAidUrgentRequest(CompleteUrgentParamModel param) async =>
      await _service.completeAidUrgentRequest(param.toJson());

  @override
  Future<BaseSingleResponse<CarCoversDataModel>> getBasicData() async =>
      await _service.getBasicData({});

  @override
  Future<BaseSingleResponse<ReferenceCarModel>> getReferenceCar(GetReferenceCarParamModel param) async =>
      await _service.getReferenceCar(param.toJson());
}
