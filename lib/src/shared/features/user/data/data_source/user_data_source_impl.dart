import 'dart:async';

import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/job_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/user_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/service/user_service.dart';
import 'package:injectable/injectable.dart';

import 'user_data_source.dart';

@LazySingleton(as: UserDataSource)
class UserDataSourceImpl extends UserDataSource {
  final UserService _service;

  UserDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<UserModel?>> fetchProfile() async {
    return await _service.fetchProfile({});
  }

  @override
  Future<BaseSingleResponse<UserModel?>> updateProfile(UserModel? model) async {
    final result = await _service.updateProfile(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseListResponse<JobResponseModel?>> fetchUserJobs() async {
    final result = await _service.fetchUserJobs({});
    return result;
  }

  @override
  Future<BaseSingleResponse> logout() async {
    final result = await _service.logout({});
    return result;
  }
}
