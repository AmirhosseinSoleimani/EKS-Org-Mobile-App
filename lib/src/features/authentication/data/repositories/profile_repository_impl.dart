import 'package:eks_sana_plus_org/src/features/authentication/data/data_sources/profile_remote_data_source.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/change_password_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/repositories/profile_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);

  final ProfileRemoteDataSource _dataSource;

  @override
  Future<ApiResult<String>> changePassword(
    ChangePasswordRequestEntity entity,
  ) async {
    try {
      final result = await _dataSource.changePassword(entity.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> logOff() async {
    try {
      final result = await _dataSource.logOff();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
