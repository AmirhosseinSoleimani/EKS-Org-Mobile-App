import 'package:eks_sana_plus_org/src/shared/features/session/data/models/current_session_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_response_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/service/auth_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthService _service;

  AuthRemoteDataSourceImpl(this._service);

  @override
  Future<HttpResponse<BaseSingleResponse<LoginResponseModel?>>> login(LoginRequestModel model) async {
    return await _service.login(model.toJson());
  }

  @override
  Future<BaseSingleResponse<CurrentSessionModel?>> getCurrentSession() async {
    return await _service.getCurrentSession({});
  }
}
