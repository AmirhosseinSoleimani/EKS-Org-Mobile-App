import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/home_service_package_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/home_service_package_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/distance_to_customer_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/distance_to_customer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/emdadgar_evaluation_accept_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_post_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/kilometer_from_image_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/kilometer_from_image_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/labor_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/labor_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/last_evaluation_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/ocr_configuration_kilometer_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/ocr_configuration_kilometer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_mark_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_mark_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_price_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_price_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/reusable_price_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_category_request_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_category_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';


abstract class HomeServiceEvaluationDataSource {
  Future<BaseSingleResponse<EvaluationResponseModel?>> getLastEvaluationHomeServices(LastEvaluationRequestModel? model);
  Future<BaseSingleResponse<DistanceToCustomerResponseModel?>> getDistanceToCustomerHomeServices(DistanceToCustomerRequestModel? model);
  Future<BaseListResponse<PartMarkResponseModel?>> getPartMarks(PartMarkRequestModel? model);
  Future<BaseSingleResponse<ServiceResponseModel?>> getServices(ServiceRequestModel? model);
  Future<BaseListResponse<LaborResponseModel?>> getLabors(LaborRequestModel? model);
  Future<BaseListResponse<PartResponseModel?>> getParts(PartRequestModel? model);
  Future<BaseSingleResponse<PartPriceResponseModel?>> getPartPrice(PartPriceRequestModel? model);
  Future<BaseSingleResponse<ReusablePriceResponseModel?>> getReusablePrice(PartPriceRequestModel? model);
  Future<BaseSingleResponse<EvaluationPostResponseModel?>> postEvaluation(LastEvaluationModel? model);
  Future<BaseSingleResponse<EmdadgarEvaluationAcceptResponseModel?>> emdadgarEvaluationAccept(int? emdadgarEvaluationResultId);

  Future<BaseSingleResponse<KilometerFromImageResponseModel?>> fetchKilometerImage(KilometerFromImageRequestModel? model);
  Future<BaseSingleResponse<OcrConfigurationKilometerResponseModel?>> fetchOcrConfiguration(OcrConfigurationKilometerRequestModel? model);
  Future<BaseListResponse<ServiceCategoryResponseModel>> getServiceCategories(ServiceCategoryRequestModel model);
  Future<BaseListResponse<HomeServicePackageResponseModel?>> getHomeServicePackage(HomeServicePackageRequestModel? model);
}