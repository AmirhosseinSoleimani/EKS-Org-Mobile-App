import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/job_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_service.g.dart';

@RestApi()
@lazySingleton
abstract class UserService {
  @factoryMethod
  factory UserService(Dio dio) = _UserService;

  @POST('/api/User/GetProfile')
  Future<BaseSingleResponse<UserModel?>> fetchProfile(
      @Body() Map<String, dynamic> body);

  @POST('/api/User/EditProfile')
  Future<BaseSingleResponse<UserModel?>> updateProfile(
      @Body() Map<String, dynamic> body);

  @GET('/api/User/GetJobs')
  Future<BaseListResponse<JobResponseModel?>> fetchUserJobs(
      @Body() Map<String, dynamic> body);

  @POST('/api/User/logout')
  Future<BaseSingleResponse> logout(@Body() Map<String, dynamic> body);
}
