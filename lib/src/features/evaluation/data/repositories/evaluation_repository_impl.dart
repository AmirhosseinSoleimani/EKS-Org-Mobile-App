import 'package:eks_sana_plus_org/src/features/evaluation/data/remote/data_sources/evaluation_remote_data_source.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/accept_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/post_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EvaluationRepository)
class EvaluationRepositoryImpl extends EvaluationRepository {
  final EvaluationRemoteDataSource _remoteDataSource;

  EvaluationRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<DefectEntity>>> getDefectsList(
    int? serviceRequestId,
  ) async {
    try {
      final result = await _remoteDataSource.getDefectsList(
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
      final result = await _remoteDataSource
          .getServiceCategoryList(param.toModel());
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ServiceResponseEntity>> getAidServices(
      ServicesParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .getAidServices(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PostEvaluationResponseEntity>> postEvaluation(ServiceEvaluationParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .postEvaluation(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<AcceptEvaluationResponseEntity>> acceptEvaluation(AcceptEvaluationParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .acceptEvaluation(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadgarServiceDetailEntity>> getServiceDetailAndCheckSubscriptionForEmdagar(ServiceDetailForEvaluationParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .getServiceDetailAndCheckSubscriptionForEmdagar(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
