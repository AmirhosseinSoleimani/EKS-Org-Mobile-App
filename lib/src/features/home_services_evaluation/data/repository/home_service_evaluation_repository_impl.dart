
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/data_source/home_service_evaluation_data_source.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/emdadgar_evaluation_accept_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_post_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_package_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_response_entity.dart';
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
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_category_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: HomeServiceEvaluationRepository)
class HomeServiceEvaluationRepositoryImpl extends HomeServiceEvaluationRepository {
  final HomeServiceEvaluationDataSource _dataSource;

  HomeServiceEvaluationRepositoryImpl(this._dataSource);

  final _activeRequestSubject = BehaviorSubject<ActiveServiceRequestResponseEntity?>();
  final _lastEvaluationSubject = BehaviorSubject<LastEvaluationEntity?>();

  @override
  void dispose() {
    _activeRequestSubject.close();
    _lastEvaluationSubject.close();
  }


  @override
  Future<ApiResult<EvaluationResponseEntity?>> getLastEvaluationHomeServices(LastEvaluationRequestEntity? entity) async {
    try {
      final result = await _dataSource.getLastEvaluationHomeServices(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<DistanceToCustomerResponseEntity?>> getDistanceToCustomerHomeServices(DistanceToCustomerRequestEntity? entity) async {
    try {
      final result = await _dataSource.getDistanceToCustomerHomeServices(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PartMarkResponseEntity?>>> getPartMarks(PartMarkRequestEntity? entity) async {
    try {
      final result = await _dataSource.getPartMarks(entity?.toModel());
      return ApiResult.success(
          data: result.data ?? [],
          failures: result.failures,
          resultCode: result.resultCode);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ServiceResponseEntity?>> getServices(ServiceRequestEntity? entity) async {
    try {
      final result = await _dataSource.getServices(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<LaborResponseEntity?>>> getLabors(LaborRequestEntity? entity) async {
    try {
      final result = await _dataSource.getLabors(entity?.toModel());
      return ApiResult.success(
          data: result.data ?? <LaborResponseEntity>[],
          failures: result.failures,
          resultCode: result.resultCode);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PartResponseEntity?>>> getParts(PartRequestEntity? entity) async {
    try {
      final result = await _dataSource.getParts(entity?.toModel());
      return ApiResult.success(
          data: result.data ?? <PartResponseEntity?>[],
          failures: result.failures,
          resultCode: result.resultCode);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ActiveServiceRequestResponseEntity?>> getActiveServiceRequest() async{
    try {
      return ApiResult.success(
        data: _activeRequestSubject.value ?? const ActiveServiceRequestResponseEntity(),
        failures: [],
        resultCode: 0,
      );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String?>> setActiveServiceRequest(ActiveServiceRequestResponseEntity? entity) async{
    try {
      _activeRequestSubject.add(entity ?? const ActiveServiceRequestResponseEntity());
      return const ApiResult.success(
        data: 'ثبت با موفقیت انجام شد',
        failures: [],
        resultCode: 0,
      );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }


  @override
  Future<ApiResult<LastEvaluationEntity?>> getLastEvaluation() async{
    try {
      return ApiResult.success(
        data: _lastEvaluationSubject.value ?? LastEvaluationEntity(),
        failures: [],
        resultCode: 0,
      );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String?>> setLastEvaluation(LastEvaluationEntity? entity) async{
    try {
      _lastEvaluationSubject.add(entity ?? LastEvaluationEntity());
      return const ApiResult.success(
        data: 'ثبت با موفقیت انجام شد',
        failures: [],
        resultCode: 0,
      );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PartPriceResponseEntity?>> getPartPrice(PartPriceRequestEntity? entity) async{
    try {
      final result = await _dataSource.getPartPrice(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ReusablePriceResponseEntity?>> getReusablePrice(PartPriceRequestEntity? entity) async{
    try {
      final result = await _dataSource.getReusablePrice(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EvaluationPostResponseEntity?>> postEvaluation(LastEvaluationEntity? entity) async{
    try {
      final result = await _dataSource.postEvaluation(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadgarEvaluationAcceptResponseEntity?>> emdadgarEvaluationAccept(int emdadgarEvaluationResultId) async{
    try {
      final result = await _dataSource.emdadgarEvaluationAccept(emdadgarEvaluationResultId);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<KilometerFromImageResponseEntity?>> fetchKilometerImage(KilometerFromImageRequestEntity? entity) async{
    try {
      final result = await _dataSource.fetchKilometerImage(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<OcrConfigurationKilometerResponseEntity?>> fetchOcrConfiguration(OcrConfigurationKilometerRequestEntity? entity) async{
    try {
      final result = await _dataSource.fetchOcrConfiguration(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<ServiceCategoryResponseEntity?>>> getServiceCategories(
      ServiceCategoryRequestEntity entity,) async {
    final result = await _dataSource.getServiceCategories(
      entity.toModel(),
    );
    
    return result.toApiResult();
  }

  @override
  Future<ApiResult<List<HomeServicePackageResponseEntity?>>> getHomeServicePackage(HomeServicePackageRequestEntity? entity) async {
    try {
      final result = await _dataSource.getHomeServicePackage(entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<
      InsertHomeServiceCategoryResponseEntity>?>> fetchHomeServiceCategories() async {
    try {
      final result = await _dataSource.fetchHomeServiceCategories();
      return ApiResult.success(
        data: result?.data ?? <InsertHomeServiceCategoryResponseEntity>[],
        failures: result?.failures,
        resultCode: result?.resultCode,
      );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<
      List<InsertHomeServicePackageResponseEntity?>>> fetchHomeServicePackage(
      InsertHomeServicePackageRequestEntity? entity) async {
    try {
      final result = await _dataSource.fetchHomeServicePackage(
          entity?.toModel());
      return ApiResult.success(
          data: result.data ?? <InsertHomeServicePackageResponseEntity>[],
          failures: result.failures,
          resultCode: result.resultCode);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<
      InsertHomeServiceServiceResponseEntity?>> fetchHomeServiceServices(
      InsertHomeServiceServiceRequestEntity? entity) async {
    try {
      final result = await _dataSource.fetchHomeServiceService(
          entity?.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
