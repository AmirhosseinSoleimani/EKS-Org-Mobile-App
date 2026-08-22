import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/data/models/current_session_model.dart';
import 'package:retrofit/dio.dart';

abstract class AuthRemoteDataSource {
  Future<HttpResponse<BaseSingleResponse<LoginResponseModel?>>> login(
      LoginRequestModel model);
  Future<BaseSingleResponse<CurrentSessionModel?>> getCurrentSession ();
}
