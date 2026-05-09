import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/accept_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/accept_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/category_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/service_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/services_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/post_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_category_model.dart';
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
}
