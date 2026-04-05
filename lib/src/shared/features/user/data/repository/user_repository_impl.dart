import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/data/data_source/user_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/car_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/color_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/cover_car_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/degree_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/job_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  final _userEntitySubject = BehaviorSubject<UserEntity?>.seeded(null);

  final _carInfoSelectedSubject = BehaviorSubject<CarInfoEntity?>.seeded(null);

  @override
  Future<ApiResult<UserEntity?>> fetchProfile() async {
    try {
      final result = await _dataSource.fetchProfile();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<UserEntity?>> updateProfile(UserEntity? entity) async {
    try {
      final result = await _dataSource.updateProfile(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<JobResponseEntity>?>> fetchUserJobs() async {
    try {
      final result = await _dataSource.fetchUserJobs();
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  void setProfile(UserEntity? userEntity) {
    _userEntitySubject.add(userEntity);
  }

  @override
  void setCarSelected(CarInfoEntity? carInfoEntity) {
    _carInfoSelectedSubject.add(carInfoEntity);
  }

  @override
  CarInfoEntity? get fetchCarSelected => _carInfoSelectedSubject.valueOrNull;

  @override
  BaseUserInfoEntity? get fetchBaseUserInfo =>
      _userEntitySubject.valueOrNull?.baseInfo;

  @override
  Stream<UserEntity?> get fetchBaseEntityStream => _userEntitySubject;

  @override
  Stream<List<CarInfoEntity?>> get fetchCarInfoListStream => _userEntitySubject
      .map((u) => u?.carList ?? const <CarInfoEntity?>[])
      .distinct(_listEquals);

  @override
  List<ColorEntity?> get fetchColorList =>
      _userEntitySubject.valueOrNull?.colorList ?? [];

  @override
  List<CoverCarEntity?> get fetchCoverCarList =>
      _userEntitySubject.valueOrNull?.coverCarList ?? [];

  @override
  List<DefectEntity?> get fetchDefectsList =>
      _userEntitySubject.valueOrNull?.defectsList ?? [];

  @override
  List<DegreeEntity?> get fetchDegreeList =>
      _userEntitySubject.valueOrNull?.degreeList ?? [];

  @override
  void dispose() {
    _userEntitySubject.close();
    _carInfoSelectedSubject.close();
  }

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  Future<ApiResult> logout() async {
    try {
      final result = await _dataSource.logout();
      _userEntitySubject.add(null);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
