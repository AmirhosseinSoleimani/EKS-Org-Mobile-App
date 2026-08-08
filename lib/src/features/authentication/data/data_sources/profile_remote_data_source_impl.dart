import 'package:eks_sana_plus_org/src/features/authentication/data/data_sources/profile_remote_data_source.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/models/change_password_request_model.dart';
import 'package:eks_sana_plus_org/src/features/authentication/data/service/profile_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this._service);

  final ProfileService _service;

  @override
  Future<BaseSingleResponse<String>> changePassword(
    ChangePasswordRequestModel model,
  ) {
    return _service.changePassword(model);
  }

  @override
  Future<BaseSingleResponse<String>> logOff() {
    return _service.logOff();
  }
}
