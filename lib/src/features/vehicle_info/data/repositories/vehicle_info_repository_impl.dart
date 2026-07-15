import 'package:eks_sana_plus_org/src/common/event_bus/app_event_bus.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/data_sources/vehicle_info_data_source.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/create_or_edit_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_history_param.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_service_category_params.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_tool_params.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_defect_limitation_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/repositories/vehicle_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VehicleInfoRepository)
class VehicleInfoRepositoryImpl extends VehicleInfoRepository {
  VehicleInfoRepositoryImpl(this._dataSource);

  final VehicleInfoDataSource _dataSource;

  @override
  Future<ApiResult<VehicleInfoPageEntity>> getVehicles(VehicleInfoFilterParamEntity param) async {
    try {
      final result = await _dataSource.getVehicles(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<VehicleInfoEntity>> getVehicleById(int id) async {
    try {
      final result = await _dataSource.getVehicleById(id);
      return result.toApiResult<VehicleInfoEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> createVehicle(CreateOrEditVehicleParamEntity param) async {
    try {
      return _mapBaseResponse(await _dataSource.createVehicle(param.toJson()));
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> editVehicle(CreateOrEditVehicleParamEntity param) async {
    try {
      return _mapBaseResponse(await _dataSource.editVehicle(param.toJson()));
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> deleteVehicle(int id) async {
    try {
      return _mapBaseResponse(await _dataSource.deleteVehicle(id));
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<VehicleModelEntity>>> getVehicleModels({bool onlyActive = false}) async {
    try {
      final request = VehicleInfoFilterRequestModel(
        pageSize: 0,
        filters: onlyActive
            ? const [
                VehicleInfoFilterModel(field: 'IsActive', value: 'true', operator: 'eq'),
              ]
            : const [],
      );
      final result = await _dataSource.getVehicleModels(request);
      return ApiResult.success(data: result.records, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<EmdadServiceCategoryGroupEntity>>> getServiceCategories(int id) async {
    try {
      final result = await _dataSource.getServiceCategories(id);
      return result.toApiResult<EmdadServiceCategoryGroupEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> submitServiceCategories(SubmitVehicleServiceCategoriesParamEntity param) async {
    try {
      return _mapBaseResponse(await _dataSource.submitServiceCategories(param.toJson()));
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<VehicleToolEntity>>> getVehicleTools(GetVehicleToolsParamEntity param) async {
    try {
      final result = await _dataSource.getVehicleTools(param.toJson());
      return result.toApiResult<VehicleToolEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> submitVehicleTools(SubmitVehicleToolsParamEntity param) async {
    try {
      return _mapBaseResponse(await _dataSource.submitVehicleTools(param.toJson()));
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<EmdadServiceCategoryGroupEntity>>> getGroupedServiceCategories(int id) async {
    try {
      final result = await _dataSource.getGroupedServiceCategories(id);
      return result.toApiResult<EmdadServiceCategoryGroupEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> insertBatchServiceCategories(InsertBatchVehicleServiceCategoriesParamEntity param) async {
    try {
      return _mapBaseResponse(await _dataSource.insertBatchServiceCategories(param.toJson()));
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<VehicleDefectLimitationEntity>>> getDefects(GetVehicleDefectsParamEntity param) async {
    try {
      final result = await _dataSource.getDefects(param.toJson());
      return result.toApiResult<VehicleDefectLimitationEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<void>> submitDefectLimitation(SubmitVehicleDefectLimitationParamEntity param) async {
    try {
      return _mapBaseResponse(await _dataSource.submitDefectLimitation(param.toJson()));
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<VehicleHistoryEntity>>> getVehicleHistories(VehicleHistoryParamEntity param) async {
    try {
      final result = await _dataSource.getVehicleHistories(param.toQueryParameters());
      return result.toApiResult<VehicleHistoryEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  ApiResult<void> _mapBaseResponse(BaseResponse response) {
    switch (response.resultCode) {
      case 0:
        return const ApiResult.success(data: null, resultCode: 0);
      case 3:
        AppEventBus.emit(AppEvent.tokenExpired);
        return const ApiResult.expireToken();
      case 1:
      case 2:
      case 4:
      default:
        return ApiResult.failure(
          failures: response.failures?.listToString() ?? 'خطای غیرمنتظره، لطفا با شماره 096550 تماس بگیرید',
        );
    }
  }
}
