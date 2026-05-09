
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/accept_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdadgar_service_detail_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/accept_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/category_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/service_detail_for_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/service_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/services_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/post_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_response_model.dart';

import '../../../../../services/network/model/base_response.dart';
import '../../models/defect_model.dart';


abstract class EvaluationRemoteDataSource {
  Future<BaseListResponse<DefectModel?>> getDefectsList(int? serviceRequestId);

  Future<BaseListResponse<ServiceCategoryModel?>> getServiceCategoryList(CategoryParamModel param);

  Future<BaseSingleResponse<ServiceResponseModel>> getAidServices(ServicesParamModel param);

  Future<BaseSingleResponse<PostEvaluationResponseModel?>> postEvaluation(
      ServiceEvaluationParamModel param);

  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>> acceptEvaluation(
      AcceptEvaluationParamModel param);

  Future<BaseSingleResponse<
      EmdadgarServiceDetailModel>> getServiceDetailAndCheckSubscriptionForEmdagar(ServiceDetailForEvaluationParamModel param);
}
