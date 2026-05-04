
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/category_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_category_model.dart';

import '../../../../../services/network/model/base_response.dart';
import '../../models/defect_model.dart';


abstract class EvaluationRemoteDataSource {
  Future<BaseListResponse<DefectModel?>> getDefectsList(int? serviceRequestId);

  Future<BaseListResponse<ServiceCategoryModel?>> getServiceCategoryList(CategoryParamModel param);
}
