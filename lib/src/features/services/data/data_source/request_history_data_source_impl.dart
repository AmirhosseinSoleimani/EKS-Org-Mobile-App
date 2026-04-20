import 'package:eks_sana_plus_org/src/features/services/data/models/cartable_cycle_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/evaluation_history_item_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_list_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/evaluation_history_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_operation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/service/request_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

import 'request_history_data_source.dart';

@LazySingleton(as: RequestDataSource)
class RequestDataSourceImpl extends RequestDataSource {
  final RequestService _service;
  RequestDataSourceImpl(this._service);

  @override
  Future<BaseListResponse<ReliefRequestModel>> getReliefRequestList(RequestFilterParamModel param) async =>
      await _service.getReliefRequestList(param.toJson());

  @override
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
          int id) async =>
      await _service.getReliefRequestById({"id": id});

  @override
  Future<BaseListResponse<HomeServiceRequestModel>> getHomeServiceRequestList(RequestFilterParamModel param) async =>
      await _service.getHomeServiceRequestList(param.toJson());

  @override
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
          int id) async => await _service.getHomeServiceRequestById({"id": id});

  @override
  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
          RequestOperationParamModel param) async =>
      await _service.getNonCooperationList(param.toJson());

  @override
  Future<BaseSingleResponse<CartableCycleListModel>> getCartableCycleList(RequestOperationParamModel param)async =>
      await _service.getCartableCycleList(param.toJson());

  @override
  Future<BaseListResponse<EvaluationHistoryItemModel>> getEvaluationHistory(EvaluationHistoryParamModel param) async =>
    await _service.getEvaluationHistory(param.toJson());

}
