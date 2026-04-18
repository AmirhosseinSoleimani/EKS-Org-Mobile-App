import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
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
  Future<BaseListResponse<ReliefRequestModel>> getReliefRequestList() async =>
      await _service.getReliefRequestList({"Filter":{"Logic":"and","Filters":[{"Field":"requestStatus","Operator":"eq","Value":-100}]},"Sort":[],"Skip":0,"PageSize":50});

  @override
  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(
          int id) async =>
      await _service.getReliefRequestById({"id": id});

  @override
  Future<BaseListResponse<HomeServiceRequestModel>> getHomeServiceRequestList() async =>
      await _service.getHomeServiceRequestList({"Filter":{"Logic":"and","Filters":[{"Field":"requestStatus","Operator":"eq","Value":-100}]},"Sort":[],"Skip":0,"PageSize":50});

  @override
  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
          int id) async =>
      await _service.getHomeServiceRequestById({"id": id});
}
