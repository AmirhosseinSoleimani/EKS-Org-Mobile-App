import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class SpecialPlanRepository {
  Future<ApiResult<SpecialPlanPageEntity>> getByFilter(
    SpecialPlanFilterParamEntity param,
  );

  Future<ApiResult<List<SpecialPlanProductEntity>>> getProducts();

  Future<ApiResult<String>> create(SpecialPlanFormParamEntity param);

  Future<ApiResult<String>> update(SpecialPlanFormParamEntity param);

  Future<ApiResult<String>> deleteById(SpecialPlanIdParamEntity param);
}
