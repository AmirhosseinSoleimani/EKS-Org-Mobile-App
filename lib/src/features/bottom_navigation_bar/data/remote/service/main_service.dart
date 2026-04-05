import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

import '../../models/urgent_request_model.dart';
part 'main_service.g.dart';

@RestApi()
@lazySingleton
abstract class MainService {
  @factoryMethod
  factory MainService(Dio dio) = _MainService;

  @POST('/api/Emdad/SendUrgentRequest')
  Future<BaseSingleResponse<UrgentRequestModel>> sendUrgentRequest(
      @Body() Map<String, dynamic> body);
}
