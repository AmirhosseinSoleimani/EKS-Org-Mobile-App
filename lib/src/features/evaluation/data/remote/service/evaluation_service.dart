import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_category_model.dart';
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
    @Body() Map<String, dynamic> body,
  );
}
