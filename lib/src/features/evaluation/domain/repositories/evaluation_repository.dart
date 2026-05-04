import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class EvaluationRepository {
  Future<ApiResult<List<DefectEntity>>> getDefectsList(int? serviceRequestId);

  Future<ApiResult<List<ServiceCategoryEntity>>> getServiceCategoryList(
    CategoryParamEntity param,
  );
}
