
import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/distance_to_customer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/emdadgar_evaluation_accept_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_post_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/kilometer_from_image_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/labor_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/ocr_configuration_kilometer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_mark_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_price_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/reusable_price_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_service_evaluation_service.g.dart';

@RestApi()
@lazySingleton
abstract class HomeServiceEvaluationService {
  @factoryMethod
  factory HomeServiceEvaluationService(Dio dio) = _HomeServiceEvaluationService;

  @POST('/api/HomeServiceEvaluation/Post')
  Future<BaseSingleResponse<EvaluationPostResponseModel?>> postEvaluation(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/HomeServiceEvaluation/EvaluationAccept')
  Future<BaseSingleResponse<EmdadgarEvaluationAcceptResponseModel>>
  emdadgarEvaluationAccept(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceEvaluation/GetLastEvaluation')
  Future<BaseSingleResponse<EvaluationResponseModel?>>
  getLastEvaluationHomeServices(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceEvaluation/GetEmdadgarFollowupsDataAndDistances')
  Future<BaseSingleResponse<DistanceToCustomerResponseModel?>>
  getDistanceToCustomerHomeServices(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceEvaluation/GetPartMarks')
  Future<BaseListResponse<PartMarkResponseModel?>> getPartMarks(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/HomeServiceEvaluation/GetPartPrice')
  Future<BaseSingleResponse<PartPriceResponseModel?>> getPartPrice(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/HomeServiceEvaluation/GetServices')
  Future<BaseSingleResponse<ServiceResponseModel?>> getServices(@Queries() Map<String, dynamic> query);

  @POST('/api/HomeServiceEvaluation/GetLabors')
  Future<BaseListResponse<LaborResponseModel?>> getLabors(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/HomeServiceEvaluation/GetParts')
  Future<BaseListResponse<PartResponseModel?>> getPats(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/HomeServiceEvaluation/GetReusablePrice')
  Future<BaseSingleResponse<ReusablePriceResponseModel?>> getReusablePrice(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/HomeServiceEvaluation/GetKilometerFromImage')
  Future<BaseSingleResponse<KilometerFromImageResponseModel?>>
  fetchKilometerImage(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceEvaluation/GetOCRConfigurationForKilometer')
  Future<BaseSingleResponse<OcrConfigurationKilometerResponseModel?>>
  fetchOcrConfiguration(@Body() Map<String, dynamic> body);
}
