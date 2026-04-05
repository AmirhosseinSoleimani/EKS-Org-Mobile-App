import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/car_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/color_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/cover_car_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/degree_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/job_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<ApiResult<UserEntity?>> fetchProfile();

  Future<ApiResult<UserEntity?>> updateProfile(UserEntity? entity);

  Future<ApiResult<List<JobResponseEntity>?>> fetchUserJobs();

  Future<ApiResult> logout();

  void setProfile(UserEntity? userEntity);

  void setCarSelected(CarInfoEntity? carInfoEntity);

  CarInfoEntity? get fetchCarSelected;

  BaseUserInfoEntity? get fetchBaseUserInfo;

  Stream<UserEntity?> get fetchBaseEntityStream;

  Stream<List<CarInfoEntity?>> get fetchCarInfoListStream;

  List<CoverCarEntity?> get fetchCoverCarList;

  List<ColorEntity?> get fetchColorList;

  List<DegreeEntity?> get fetchDegreeList;

  List<DefectEntity?> get fetchDefectsList;

  void dispose();
}
