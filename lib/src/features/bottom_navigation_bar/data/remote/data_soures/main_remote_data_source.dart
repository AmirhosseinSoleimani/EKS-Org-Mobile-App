import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

import '../../models/urgent_request_model.dart';

abstract class MainRemoteDataSource {
  Future<BaseSingleResponse<UrgentRequestModel>> sendUrgentRequest();
}
