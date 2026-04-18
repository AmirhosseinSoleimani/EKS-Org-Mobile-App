import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/login_response_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/service/auth_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthService _service;

  AuthRemoteDataSourceImpl(this._service);


  @override
  Future<BaseSingleResponse<LoginResponseModel?>> login(LoginRequestModel model) async {
    return await _service.login(model.toJson());
  }
}
