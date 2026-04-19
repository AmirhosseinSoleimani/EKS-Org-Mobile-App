import 'package:eks_sana_plus_org/src/features/services/data/models/cartable_cycle_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/non_cooperation_list_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_operation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';


abstract class RequestDataSource {
  Future<BaseListResponse<ReliefRequestModel>> getReliefRequestList();

  Future<BaseSingleResponse<ReliefRequestModel>> getReliefRequestById(int id);

  Future<BaseListResponse<HomeServiceRequestModel>> getHomeServiceRequestList();

  Future<BaseSingleResponse<HomeServiceRequestModel>> getHomeServiceRequestById(
      int id);

  Future<BaseSingleResponse<NonCooperationListModel>> getNonCooperationList(
      RequestOperationParamModel param);

  Future<BaseSingleResponse<CartableCycleListModel>> getCartableCycleList(
      RequestOperationParamModel param);
}
