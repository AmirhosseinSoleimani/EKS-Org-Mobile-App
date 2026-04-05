import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/user_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/job_response_model.dart';

abstract class UserDataSource {
  Future<BaseSingleResponse<UserModel?>> fetchProfile();

  Future<BaseSingleResponse<UserModel?>> updateProfile(UserModel? model);

  Future<BaseListResponse<JobResponseModel?>> fetchUserJobs();

  Future<BaseSingleResponse> logout();

}
