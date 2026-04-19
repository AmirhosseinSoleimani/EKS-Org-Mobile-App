import 'package:eks_sana_plus_org/src/features/services/data/data_source/request_history_data_source.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/non_cooperation_list_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RequestRepository)
class RequestRepositoryImpl extends RequestRepository {
  final RequestDataSource _dataSource;

  RequestRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<ApiResult<List<ReliefRequestEntity>>> getReliefRequestList() async {
    try {
      final result = await _dataSource.getReliefRequestList();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ReliefRequestEntity?>> getReliefRequestById(int id) async {
    try {
      final result = await _dataSource.getReliefRequestById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<HomeServiceRequestEntity>>> getHomeServiceRequestList() async {
    try {
      final result = await _dataSource.getHomeServiceRequestList();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<HomeServiceRequestEntity?>> getHomeServiceRequestById(
      int id) async {
    try {
      final result = await _dataSource.getHomeServiceRequestById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<NonCooperationListEntity?>> getNonCooperationList() async {
    try {
      final result = await _dataSource.getNonCooperationList();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
