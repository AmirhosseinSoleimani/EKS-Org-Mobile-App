import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/accept_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdadgar_service_detail_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/labor_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/last_evaluation_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_mark_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_price_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/representation_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_package_model.dart';
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

  @POST('/api/Defect/GetListOfDefects')
  Future<BaseListResponse<DefectModel?>> getDefectsList(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/GetLabors')
  Future<BaseListResponse<LaborModel>> getAidServiceLaborList(
      @Body() Map<String, dynamic> body);

  @POST('/api/Defect/GetListOfDefects')
  Future<BaseListResponse<LaborModel>> getHomeServiceLaborList(
      @Body() Map<String, dynamic> body);

  @GET('/api/Defect/GetListOfDefects')
  Future<BaseListResponse<ServicePackageModel>> getHomeServicePackage(
      @Queries() Map<String, dynamic> body);

  @POST('/api/AidServiceEvaluation/GetPartPrice')
  Future<BaseSingleResponse<PartPriceModel>> getPartPrice(
      @Body() Map<String, dynamic> body);

  @POST('/api/AidServiceEvaluation/GetPartMarks')
  Future<BaseListResponse<PartMarkModel>> getPartMarks(
      @Body() Map<String, dynamic> body);

  @POST('/api/AidServiceEvaluation/GetParts')
  Future<BaseListResponse<PartModel>> getAidServicePartList(
      @Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceEvaluation/GetParts')
  Future<BaseListResponse<PartModel>> getHomeServicePartList(
      @Body() Map<String, dynamic> body);

  @GET('/api/AidServiceEvaluation/GetServiceCategories')
  Future<BaseListResponse<ServiceCategoryModel>> getAidServiceCategories(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/HomeServiceEvaluation/GetServiceCategories')
  Future<BaseListResponse<ServiceCategoryModel>> getHomeServiceCategories(
    @Queries() Map<String, dynamic> body,
  );

  @GET('/api/AidServiceEvaluation/GetServices')
  Future<BaseSingleResponse<ServiceResponseModel>> getAidServices(
    @Queries() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/post')
  Future<BaseSingleResponse<dynamic>> aidServiceEvaluationPost(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/InsertTrackerEvaluation')
  Future<BaseSingleResponse<dynamic>> insertTrackerEvaluation(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/InsertInvoiceOperatorEvaluation')
  Future<BaseSingleResponse<dynamic>> insertInvoiceOperatorEvaluation(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/InsertHesabdariEvaluation')
  Future<BaseSingleResponse<dynamic>> insertHesabdariEvaluation(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/InsertDaraeiEvaluation')
  Future<BaseSingleResponse<dynamic>> insertDaraeiEvaluation(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/HomeServiceEvaluation/post')
  Future<BaseSingleResponse<dynamic>> homeServiceEvaluationPost(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/EvaluationAccept')
  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>> aidEvaluationAccept(@Body() Map<String, dynamic> body);

  @POST('/api/AidServiceEvaluation/InvoiceOperatorEvaluationAccept')
  Future<BaseSingleResponse<dynamic>> invoiceOperatorEvaluationAccept(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/AmendmentInvoiceByHesabdari')
  Future<BaseSingleResponse<dynamic>> amendmentInvoiceByHesabdari(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/AidServiceEvaluation/AmendmentInvoiceByDaraei')
  Future<BaseSingleResponse<dynamic>> amendmentInvoiceByDaraei(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/HomeServiceEvaluation/EvaluationAccept')
  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>> homeServiceEvaluationAccept(@Body() Map<String, dynamic> body);


  @POST(
      '/api/AidServiceEvaluation/GetServiceDetailAndCheckSubscriptionForEmdagarEvaluation')
  Future<BaseSingleResponse<
      EmdadgarServiceDetailModel>> getAidServiceDetailAndCheckSubscriptionForEmdagarEvaluation(
      @Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceEvaluation/GetServiceDetailAndCheckSubscriptionForEmdagarEvaluation')
  Future<BaseSingleResponse<
      EmdadgarServiceDetailModel>> getHomeServiceDetailAndCheckSubscriptionForEmdagarEvaluation(
      @Body() Map<String, dynamic> body);

  @POST('/api/AidServiceEvaluation/GetLastEvaluation')
  Future<BaseSingleResponse<
      ResponseLastEvaluationModel>> getLastEvaluation(
      @Body() Map<String, dynamic> body);

  @POST('/api/Representation/GetByFilterJson')
  Future<BaseListResponse<RepresentationModel>> getRepresentationList(
      @Body() Map<String, dynamic> body);


}
