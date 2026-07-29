import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_page_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_product_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class SpecialPlanDataSource {
  Future<BaseSingleResponse<SpecialPlanPageModel>> getByFilter(
    SpecialPlanFilterRequestModel request,
  );

  Future<BaseSingleResponse<List<SpecialPlanProductModel>>> getProducts();

  Future<BaseSingleResponse<String>> create(
    SpecialPlanFormRequestModel request,
  );

  Future<BaseSingleResponse<String>> update(
    SpecialPlanFormRequestModel request,
  );

  Future<BaseSingleResponse<String>> deleteById(
    SpecialPlanIdRequestModel request,
  );
}
