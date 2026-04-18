import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';


abstract class RequestDataSource {
  Future<BaseListResponse<ReliefRequestModel>> getReliefRequestList();

  Future<BaseListResponse<HomeServiceRequestModel>> getHomeServiceRequestList();
}
