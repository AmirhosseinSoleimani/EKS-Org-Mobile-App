
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/accept_evaluation_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdadgar_service_detail_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/labor_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/last_evaluation_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/accept_evaluation_param_model.dart';
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

import '../../../../../services/network/model/base_response.dart';
import '../../models/defect_model.dart';


abstract class EvaluationRemoteDataSource {
  Future<BaseListResponse<DefectModel?>> getDefectsList(int? serviceRequestId);

  Future<BaseListResponse<LaborModel>> getLaborList(LaborListParamModel param);

  Future<BaseListResponse<PartModel>> getPartList(PartListParamModel param);

  Future<BaseListResponse<ServicePackageModel>> getHomeServicePackage(
      HomeServicePackageParamModel param);

  Future<BaseListResponse<ServiceCategoryModel?>> getServiceCategoryList(CategoryParamModel param);

  Future<BaseSingleResponse<ServiceResponseModel>> getAidServices(ServicesParamModel param);

  Future<BaseSingleResponse<PostEvaluationResponseModel?>> postEvaluation(
      ServiceEvaluationParamModel param);

  Future<BaseSingleResponse<AcceptEvaluationResponseModel?>> acceptEvaluation(
      AcceptEvaluationParamModel param);

  Future<BaseSingleResponse<
      EmdadgarServiceDetailModel>> getServiceDetailAndCheckSubscriptionForEmdagar(ServiceDetailForEvaluationParamModel param);

  Future<BaseSingleResponse<PartPriceModel>> getPartPrice(
      PartPriceParamModel param);

  Future<BaseListResponse<PartMarkModel>> getPartMarks(
      PartMarksParamModel param);

  Future<BaseSingleResponse<ResponseLastEvaluationModel>> getLastEvaluation(
      LastEvaluationParamModel param);
}
