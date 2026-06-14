import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/data_source/home_service_evaluation_data_source.dart';
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
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/service/home_service_evaluation_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeServiceEvaluationDataSource)
class HomeServiceEvaluationDataSourceImpl
    extends HomeServiceEvaluationDataSource {
  final HomeServiceEvaluationService _service;

  HomeServiceEvaluationDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<EvaluationResponseModel?>>
  getLastEvaluationHomeServices(LastEvaluationRequestModel? model) async {
    final result = await _service.getLastEvaluationHomeServices(
      model?.toJson() ?? {},
    );
    return result;
  }

  @override
  Future<BaseSingleResponse<DistanceToCustomerResponseModel?>>
  getDistanceToCustomerHomeServices(
    DistanceToCustomerRequestModel? model,
  ) async {
    final result = await _service.getDistanceToCustomerHomeServices(
      model?.toJson() ?? {},
    );
    return result;
  }

  @override
  Future<BaseListResponse<LaborResponseModel?>> getLabors(
    LaborRequestModel? model,
  ) async {
    final result = await _service.getLabors(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseListResponse<PartResponseModel?>> getParts(
    PartRequestModel? model,
  ) async {
    final result = await _service.getPats(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseListResponse<PartMarkResponseModel?>> getPartMarks(
    PartMarkRequestModel? model,
  ) async {
    final result = await _service.getPartMarks(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<PartPriceResponseModel?>> getPartPrice(
    PartPriceRequestModel? model,
  ) async {
    final result = await _service.getPartPrice(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<ReusablePriceResponseModel?>> getReusablePrice(
    PartPriceRequestModel? model,
  ) async {
    final result = await _service.getReusablePrice(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<EvaluationPostResponseModel?>> postEvaluation(
    LastEvaluationModel? model,
  ) async {
    final result = await _service.postEvaluation(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<EmdadgarEvaluationAcceptResponseModel?>>
  emdadgarEvaluationAccept(int? emdadgarEvaluationResultId) async {
    final result = await _service.emdadgarEvaluationAccept({
      'EmdadgarEvaluationId': emdadgarEvaluationResultId,
    });
    return result;
  }

  @override
  Future<BaseSingleResponse<KilometerFromImageResponseModel?>>
  fetchKilometerImage(KilometerFromImageRequestModel? model) async {
    final result = await _service.fetchKilometerImage(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<OcrConfigurationKilometerResponseModel?>>
  fetchOcrConfiguration(OcrConfigurationKilometerRequestModel? model) async {
    final result = await _service.fetchOcrConfiguration(model?.toJson() ?? {});
    return result;
  }

  @override
  Future<BaseSingleResponse<ServiceResponseModel?>> getServices(
    ServiceRequestModel? model,
  ) async {
    final result = await _service.getServices(model?.toJson() ?? {});
    return result;
  }
}
