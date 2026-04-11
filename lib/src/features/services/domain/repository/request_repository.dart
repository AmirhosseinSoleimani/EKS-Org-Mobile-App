import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class RequestRepository {
  Future<ApiResult<List<ReliefRequestEntity>>> getReliefRequestList();

  Future<ApiResult<List<HomeServiceRequestEntity>>> fetchHomeServiceRequestList();
}
