import 'package:eks_sana_plus_org/src/features/special_plan/data/data_source/special_plan_data_source.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_page_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/special_plan_product_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/service/special_plan_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SpecialPlanDataSource)
class SpecialPlanDataSourceImpl extends SpecialPlanDataSource {
  SpecialPlanDataSourceImpl(this._service);

  final SpecialPlanService _service;

  @override
  Future<BaseSingleResponse<SpecialPlanPageModel>> getByFilter(
    SpecialPlanFilterRequestModel request,
  ) => _service.getByFilter(request);

  @override
  Future<BaseSingleResponse<List<SpecialPlanProductModel>>> getProducts() =>
      _service.getProducts();

  @override
  Future<BaseSingleResponse<String>> create(
    SpecialPlanFormRequestModel request,
  ) => _service.create(request);

  @override
  Future<BaseSingleResponse<String>> update(
    SpecialPlanFormRequestModel request,
  ) => _service.update(request);

  @override
  Future<BaseSingleResponse<String>> deleteById(
    SpecialPlanIdRequestModel request,
  ) => _service.deleteById(request);
}
