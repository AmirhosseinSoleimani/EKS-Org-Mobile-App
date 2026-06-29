

import 'package:eks_sana_plus_org/src/features/cartable/data/data_sources/cartable_data_source.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/repositories/cartable_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartableRepository)
class CartableRepositoryImpl extends CartableRepository {
  final CartableDataSource _dataSource;

  CartableRepositoryImpl(this._dataSource);

/*  @override
  Future<ApiResult<DashboardEntity?>> getDashboardData(
    DashboardParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getDashboardData(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }*/
}
