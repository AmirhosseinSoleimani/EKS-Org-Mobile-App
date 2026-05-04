import 'package:eks_sana_plus_org/src/features/evaluation/data/remote/data_sources/evaluation_remote_data_source.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EvaluationRepository)
class EvaluationRepositoryImpl extends EvaluationRepository {
  final EvaluationRemoteDataSource _finalizeInvoiceRemoteDataSource;

  EvaluationRepositoryImpl(this._finalizeInvoiceRemoteDataSource);

  @override
  Future<ApiResult<List<DefectEntity>>> getDefectsList(
    int? serviceRequestId,
  ) async {
    try {
      final result = await _finalizeInvoiceRemoteDataSource.getDefectsList(
        serviceRequestId,
      );
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<ServiceCategoryEntity>>> getServiceCategoryList(
    CategoryParamEntity param,
  ) async {
    try {
      final result = await _finalizeInvoiceRemoteDataSource
          .getServiceCategoryList(param.toModel());
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
