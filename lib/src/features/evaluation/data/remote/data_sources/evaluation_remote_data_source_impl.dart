import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/accept_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdadgar_service_detail_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/labor_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/last_evaluation_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/accept_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/aid_service_evaluation_submit_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/category_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/home_service_package_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/labor_list_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/last_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/part_list_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/part_marks_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/part_price_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/service_detail_for_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/service_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/services_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_mark_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_price_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/post_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_package_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../services/network/model/base_response.dart';
import '../../models/defect_model.dart';
import '../service/evaluation_service.dart';
import 'evaluation_remote_data_source.dart';

@LazySingleton(as: EvaluationRemoteDataSource)
class FinalizeInvoiceRemoteDataSourceImpl extends EvaluationRemoteDataSource {
  final EvaluationService _service;

  FinalizeInvoiceRemoteDataSourceImpl(this._service);

  @override
  Future<BaseListResponse<DefectModel?>> getDefectsList(
    int? serviceRequestId,
  ) async {
    return await _service.getDefectsList({
      'serviceRequestId': serviceRequestId,
    });
  }

  @override
  Future<BaseListResponse<ServiceCategoryModel>> getServiceCategoryList(
    CategoryParamModel param,
  ) async {
    return (param.serviceType == ServiceType.reliefService)
        ? await _service.getAidServiceCategories(param.toJson())
        : await _service.getHomeServiceCategories(param.toJson());
  }

  @override
  Future<BaseSingleResponse<ServiceResponseModel>> getAidServices(ServicesParamModel param) async{
    return await _service.getAidServices(param.toJson());
  }

  @override
  Future<BaseSingleResponse<PostEvaluationResponseModel>> postEvaluation(
      ServiceEvaluationParamModel param) async {
    return (param.serviceType == ServiceType.reliefService)
        ? await _service.aidServiceEvaluationPost(param.toJson())
        : await _service.homeServiceEvaluationPost(param.toJson());
  }

  @override
  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>> acceptEvaluation(
      AcceptEvaluationParamModel param) async {
    return (param.serviceType == ServiceType.reliefService)
        ? await _service.aidEvaluationAccept(param.toJson())
        : await _service.homeServiceEvaluationAccept(param.toJson());
  }

  @override
  Future<BaseSingleResponse<
      EmdadgarServiceDetailModel>> getServiceDetailAndCheckSubscriptionForEmdagar(
      ServiceDetailForEvaluationParamModel param) async {
    return (param.serviceType == ServiceType.reliefService)
        ? await _service.getAidServiceDetailAndCheckSubscriptionForEmdagarEvaluation(param.toJson())
        : await _service.getHomeServiceDetailAndCheckSubscriptionForEmdagarEvaluation(param.toJson());
  }

  @override
  Future<BaseListResponse<LaborModel>> getLaborList(
      LaborListParamModel param) async
  =>
      (param.serviceType == ServiceType.reliefService)
          ? await _service.getAidServiceLaborList(param.toJson())
          : await _service.getHomeServiceLaborList(param.toJson());

  @override
  Future<BaseListResponse<PartModel>> getPartList(
      PartListParamModel param) async
  =>
      (param.serviceType == ServiceType.reliefService)
          ? await _service.getAidServicePartList(param.toJson())
          : await _service.getHomeServicePartList(param.toJson());

  @override
  Future<BaseListResponse<ServicePackageModel>> getHomeServicePackage(
      HomeServicePackageParamModel param) async
  => await _service.getHomeServicePackage(param.toJson());

  @override
  Future<BaseListResponse<PartMarkModel>> getPartMarks(
      PartMarksParamModel param) async
  => await _service.getPartMarks(param.toJson());

  @override
  Future<BaseSingleResponse<PartPriceModel>> getPartPrice(
      PartPriceParamModel param) async
  => await _service.getPartPrice(param.toJson());

  @override
  Future<BaseSingleResponse<ResponseLastEvaluationModel>> getLastEvaluation(LastEvaluationParamModel param)
  async => await _service.getLastEvaluation(param.toJson());

  @override
  Future<BaseSingleResponse<PostEvaluationResponseModel>> submitEvaluationForAidService(AidServiceEvaluationSubmitParamModel param)
  async => await _service.aidServiceEvaluationPost(param.toJson());

}
