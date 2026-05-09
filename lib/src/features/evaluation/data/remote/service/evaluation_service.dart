import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/accept_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdadgar_service_detail_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/post_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/defect_model.dart';

part 'evaluation_service.g.dart';

@RestApi()
@lazySingleton
abstract class EvaluationService {
  @factoryMethod
  factory EvaluationService(Dio dio) = _EvaluationService;

  @POST('/api/DefectOrg/GetListOfDefects')
  Future<BaseListResponse<DefectModel?>> getDefectsList(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/AidServiceEvaluationOrg/GetServiceCategories')
  Future<BaseListResponse<ServiceCategoryModel>> getAidServiceCategories(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/HomeServiceEvaluationOrg/GetServiceCategories')
  Future<BaseListResponse<ServiceCategoryModel>> getHomeServiceCategories(
    @Queries() Map<String, dynamic> body,
  );

  @GET('/api/AidServiceEvaluationOrg/GetServices')
  Future<BaseSingleResponse<ServiceResponseModel>> getAidServices(
    @Queries() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluationOrg/post')
  Future<BaseSingleResponse<PostEvaluationResponseModel>>
  aidServiceEvaluationPost(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceEvaluationOrg/post')
  Future<BaseSingleResponse<PostEvaluationResponseModel>>
  homeServiceEvaluationPost(@Body() Map<String, dynamic> body);

  @POST('/api/AidServiceEvaluationOrg/EvaluationAccept')
  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>> aidEvaluationAccept(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceEvaluationOrg/EvaluationAccept')
  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>> homeServiceEvaluationAccept(@Body() Map<String, dynamic> body);


  @POST(
      '/api/AidServiceEvaluationOrg/GetServiceDetailAndCheckSubscriptionForEmdagarEvaluation')
  Future<BaseSingleResponse<
      EmdadgarServiceDetailModel>> getAidServiceDetailAndCheckSubscriptionForEmdagarEvaluation(
      @Body() Map<String, dynamic> body);

  @POST(
      '/api/HomeServiceEvaluationOrg/GetServiceDetailAndCheckSubscriptionForEmdagarEvaluation')
  Future<BaseSingleResponse<
      EmdadgarServiceDetailModel>> getHomeServiceDetailAndCheckSubscriptionForEmdagarEvaluation(
      @Body() Map<String, dynamic> body);
}
