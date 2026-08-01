import 'package:eks_sana_plus_org/src/features/vehicle_model/data/data_source/vehicle_model_data_source.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_service_category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/repository/vehicle_model_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VehicleModelRepository)
class VehicleModelRepositoryImpl extends VehicleModelRepository {
  VehicleModelRepositoryImpl(this._dataSource);

  final VehicleModelDataSource _dataSource;

  @override
  Future<ApiResult<VehicleModelPageEntity>> getByFilter(
    VehicleModelFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getByFilter(
        VehicleModelFilterRequestModel.fromParam(param),
      );
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<VehicleNavganEntity>>> getNavgans() async {
    try {
      final result = await _dataSource.getNavgans();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<VehicleServiceGroupEntity>>> getServiceGroups(
    VehicleModelIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getServiceGroups(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<VehicleDefectEntity>>> getDefects(
    VehicleModelServiceCategoryParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getDefects(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> submitDefects(
    VehicleModelIdsPayloadParamEntity param,
  ) async {
    try {
      final result = await _dataSource.submitDefects(param.toDefectsModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> submitServiceCategories(
    VehicleModelIdsPayloadParamEntity param,
  ) async {
    try {
      final result = await _dataSource.submitServiceCategories(
        param.toServiceCategoriesModel(),
      );
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> deleteById(VehicleModelIdParamEntity param) async {
    try {
      final result = await _dataSource.deleteById(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> updateVehicleModel(
    VehicleModelFormParamEntity param,
  ) async {
    try {
      final result = await _dataSource.updateVehicleModel(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> addVehicleModel(
    VehicleModelFormParamEntity param,
  ) async {
    try {
      final result = await _dataSource.addVehicleModel(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
