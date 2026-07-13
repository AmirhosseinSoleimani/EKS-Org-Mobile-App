import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/data_sources/emdad_vehicle_data_source.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/emdad_vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/submit_vehicle_services_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/submit_vehicle_tools_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_id_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_emdad_vehicle_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_tools_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/submit_vehicle_tools_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_defects_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/submit_vehicle_defect_limitation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/submit_vehicle_services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/delete_emdad_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_vehicle_history_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_active_vehicle_models_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_emdad_vehicle_by_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/update_emdad_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/create_emdad_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmdadVehicleRepository)
class EmdadVehicleRepositoryImpl extends EmdadVehicleRepository {
  final EmdadVehicleDataSource _dataSource;

  EmdadVehicleRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<List<VehicleModelEntity>>> getEmdadVehicleList(
    GetEmdadVehicleListParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getEmdadVehicleList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<VehicleToolEntity>>> getVehicleTools(
    GetVehicleToolsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getVehicleTools(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<SubmitVehicleToolsResponseEntity>> submitVehicleTools(
    SubmitVehicleToolsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.submitVehicleTools(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<VehicleServiceGroupEntity>>> getVehicleServices(
    GetVehicleServicesParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getVehicleServices(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<VehicleDefectEntity>>> getVehicleDefects(
    GetVehicleDefectsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getVehicleDefects(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> submitVehicleDefectLimitation(
    SubmitVehicleDefectLimitationParamEntity param,
  ) async {
    try {
      final result = await _dataSource.submitVehicleDefectLimitation(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<SubmitVehicleServicesResponseEntity>> submitVehicleServices(
    SubmitVehicleServicesParamEntity param,
  ) async {
    try {
      final result = await _dataSource.submitVehicleServices(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<VehicleIdResponseEntity>> deleteEmdadVehicle(
    DeleteEmdadVehicleParamEntity param,
  ) async {
    try {
      final result = await _dataSource.deleteEmdadVehicle(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<VehicleHistoryEntity>>> getVehicleHistory(
    GetVehicleHistoryParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getVehicleHistory(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<ImeiInfoEntity>>> getImeiList() async {
    try {
      final result = await _dataSource.getImeiList();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<VehicleModelEntity>>> getActiveVehicleModels(
    GetActiveVehicleModelsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getActiveVehicleModels(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadVehicleInfoEntity>> getEmdadVehicleById(
    GetEmdadVehicleByIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getEmdadVehicleById(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<VehicleIdResponseEntity>> updateEmdadVehicle(
    UpdateEmdadVehicleParamEntity param,
  ) async {
    try {
      final result = await _dataSource.updateEmdadVehicle(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<VehicleIdResponseEntity>> createEmdadVehicle(
    CreateEmdadVehicleParamEntity param,
  ) async {
    try {
      final result = await _dataSource.createEmdadVehicle(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

}
