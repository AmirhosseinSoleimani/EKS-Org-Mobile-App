
import 'package:eks_sana_plus_org/src/features/representation/data/data_sources/representation_data_source.dart';
import 'package:eks_sana_plus_org/src/features/representation/domain/repositories/representation_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: RepresentationRepository)
class RepresentationRepositoryImpl extends RepresentationRepository {
  final RepresentationDataSource _dataSource;

  RepresentationRepositoryImpl(this._dataSource);

/*  @override
  Future<ApiResult<DashboardEntity?>> getDashboardData(
    DashboardParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getDashboardData(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }*/
}
