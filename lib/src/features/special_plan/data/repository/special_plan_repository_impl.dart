import 'package:eks_sana_plus_org/src/features/special_plan/data/data_source/special_plan_data_source.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/data/models/params/special_plan_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/params/special_plan_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/repository/special_plan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SpecialPlanRepository)
class SpecialPlanRepositoryImpl extends SpecialPlanRepository {
  SpecialPlanRepositoryImpl(this._dataSource);

  final SpecialPlanDataSource _dataSource;

  @override
  Future<ApiResult<SpecialPlanPageEntity>> getByFilter(
    SpecialPlanFilterParamEntity param,
  ) async {
    try {
      return (await _dataSource.getByFilter(
        SpecialPlanFilterRequestModel.fromParam(param),
      ))
          .toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<SpecialPlanProductEntity>>> getProducts() async {
    try {
      return (await _dataSource.getProducts()).toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<String>> create(SpecialPlanFormParamEntity param) async {
    try {
      return (await _dataSource.create(
        SpecialPlanFormRequestModel.fromParam(param),
      ))
          .toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<String>> update(SpecialPlanFormParamEntity param) async {
    try {
      return (await _dataSource.update(
        SpecialPlanFormRequestModel.fromParam(param),
      ))
          .toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<String>> deleteById(SpecialPlanIdParamEntity param) async {
    try {
      return (await _dataSource.deleteById(
        SpecialPlanIdRequestModel.fromParam(param),
      ))
          .toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
