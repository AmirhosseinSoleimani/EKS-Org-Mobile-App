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
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class EvaluationRepository {
  Future<ApiResult<List<DefectEntity>>> getDefectsList(int? serviceRequestId);

  Future<ApiResult<List<ServiceCategoryEntity>>> getServiceCategoryList(
    CategoryParamEntity param,
  );

  Future<ApiResult<ServiceResponseEntity>> getAidServices(
      ServicesParamEntity param);

  Future<ApiResult<PostEvaluationResponseEntity>> postEvaluation(
      ServiceEvaluationParamEntity param);

  Future<ApiResult<AcceptEvaluationResponseEntity>> acceptEvaluation(
      AcceptEvaluationParamEntity param);

  Future<ApiResult<
      EmdadgarServiceDetailEntity>> getServiceDetailAndCheckSubscriptionForEmdagar(
      ServiceDetailForEvaluationParamEntity param);
}
