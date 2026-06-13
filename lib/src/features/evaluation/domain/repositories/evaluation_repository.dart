import 'package:eks_sana_plus_org/src/features/evaluation/data/models/post_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/accept_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/RepresentationParamEntity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/aid_service_evaluation_submit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/home_service_package_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/labor_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/last_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_marks_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_price_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_price_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/post_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/representation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_package_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class EvaluationRepository {
  Future<ApiResult<List<DefectEntity>>> getDefectsList(int? serviceRequestId);

  Future<ApiResult<List<ServicePackageEntity>>> getHomeServicePackage(
      HomeServicePackageParamEntity param);


  Future<ApiResult<List<LaborEntity>>> getLaborList(LaborListParamEntity param);

  Future<ApiResult<List<PartEntity>>> getPartList(PartListParamEntity param);

  Future<ApiResult<PartPriceEntity>> getPartPrice(
      PartPriceParamEntity param);

  Future<ApiResult<List<PartMarkEntity>>> getPartMarks(
      PartMarksParamEntity param);

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

  Future<ApiResult<ResponseLastEvaluationEntity>>  getLastEvaluation(
      LastEvaluationParamEntity param);

  Future<
      ApiResult<PostEvaluationResponseEntity>> submitEvaluationForAidService(
      AidServiceEvaluationSubmitParamEntity param);

  Future<ApiResult<List<RepresentationEntity>>> getRepresentationList(RepresentationParamEntity param);
}
