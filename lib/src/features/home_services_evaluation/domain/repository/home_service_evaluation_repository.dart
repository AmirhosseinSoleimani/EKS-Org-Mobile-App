import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/emdadgar_evaluation_accept_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_post_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/kilometer_from_image_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/kilometer_from_image_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/ocr_configuration_kilometer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/ocr_configuration_kilometer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_price_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_price_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_price_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class HomeServiceEvaluationRepository {
  Future<ApiResult<EvaluationResponseEntity?>> getLastEvaluationHomeServices(
    LastEvaluationRequestEntity? entity,
  );

  Future<ApiResult<DistanceToCustomerResponseEntity?>>
  getDistanceToCustomerHomeServices(DistanceToCustomerRequestEntity? entity);

  Future<ApiResult<List<PartMarkResponseEntity?>>> getPartMarks(
    PartMarkRequestEntity? entity,
  );

  Future<ApiResult<ServiceResponseEntity?>> getServices(
    ServiceRequestEntity? entity,
  );

  Future<ApiResult<List<LaborResponseEntity?>>> getLabors(
    LaborRequestEntity? entity,
  );

  Future<ApiResult<List<PartResponseEntity?>>> getParts(
    PartRequestEntity? entity,
  );

  Future<ApiResult<ActiveServiceRequestResponseEntity?>>
  getActiveServiceRequest();

  Future<ApiResult<String?>> setActiveServiceRequest(
    ActiveServiceRequestResponseEntity? entity,
  );

  Future<ApiResult<LastEvaluationEntity?>> getLastEvaluation();

  Future<ApiResult<String?>> setLastEvaluation(LastEvaluationEntity? entity);

  Future<ApiResult<PartPriceResponseEntity?>> getPartPrice(
    PartPriceRequestEntity? entity,
  );

  Future<ApiResult<ReusablePriceResponseEntity?>> getReusablePrice(
    PartPriceRequestEntity? entity,
  );

  Future<ApiResult<EvaluationPostResponseEntity?>> postEvaluation(
    LastEvaluationEntity? entity,
  );

  Future<ApiResult<EmdadgarEvaluationAcceptResponseEntity?>>
  emdadgarEvaluationAccept(int emdadgarEvaluationResultId);

  Future<ApiResult<KilometerFromImageResponseEntity?>> fetchKilometerImage(
    KilometerFromImageRequestEntity? entity,
  );

  Future<ApiResult<OcrConfigurationKilometerResponseEntity?>>
  fetchOcrConfiguration(OcrConfigurationKilometerRequestEntity? entity);

  void dispose();
}
