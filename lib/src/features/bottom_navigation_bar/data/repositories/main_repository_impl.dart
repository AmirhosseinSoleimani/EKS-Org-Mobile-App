
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entiteis/urgent_request_entity.dart';
import '../../domain/repositories/main_repository.dart';
import '../remote/data_soures/main_remote_data_source.dart';

@LazySingleton(as: MainRepository)
class MainRepositoryImpl extends MainRepository {
  final MainRemoteDataSource _mainRemoteDataSource;

  MainRepositoryImpl(this._mainRemoteDataSource);

  @override
  Future<ApiResult<UrgentRequestEntity>> sendUrgentRequest() async {
    try {
      final result = await _mainRemoteDataSource.sendUrgentRequest();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
