import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

import '../entiteis/urgent_request_entity.dart';

abstract class MainRepository {
  Future<ApiResult<UrgentRequestEntity>> sendUrgentRequest();
}
