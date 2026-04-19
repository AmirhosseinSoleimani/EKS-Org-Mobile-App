import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class AuthRemoteDataSource {
  Future<BaseSingleResponse<LoginResponseModel?>> login (LoginRequestModel model);
}
