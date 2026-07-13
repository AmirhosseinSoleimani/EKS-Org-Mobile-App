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
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class EmdadVehicleRepository {
  Future<ApiResult<List<VehicleModelEntity>>> getEmdadVehicleList(
    GetEmdadVehicleListParamEntity param,
  );

  Future<ApiResult<List<VehicleToolEntity>>> getVehicleTools(
    GetVehicleToolsParamEntity param,
  );

  Future<ApiResult<SubmitVehicleToolsResponseEntity>> submitVehicleTools(
    SubmitVehicleToolsParamEntity param,
  );

  Future<ApiResult<List<VehicleServiceGroupEntity>>> getVehicleServices(
    GetVehicleServicesParamEntity param,
  );

  Future<ApiResult<List<VehicleDefectEntity>>> getVehicleDefects(
    GetVehicleDefectsParamEntity param,
  );

  Future<ApiResult<void>> submitVehicleDefectLimitation(
    SubmitVehicleDefectLimitationParamEntity param,
  );

  Future<ApiResult<SubmitVehicleServicesResponseEntity>>
      submitVehicleServices(SubmitVehicleServicesParamEntity param);

  Future<ApiResult<VehicleIdResponseEntity>> deleteEmdadVehicle(
    DeleteEmdadVehicleParamEntity param,
  );

  Future<ApiResult<List<VehicleHistoryEntity>>> getVehicleHistory(
    GetVehicleHistoryParamEntity param,
  );

  Future<ApiResult<List<ImeiInfoEntity>>> getImeiList();

  Future<ApiResult<List<VehicleModelEntity>>> getActiveVehicleModels(
    GetActiveVehicleModelsParamEntity param,
  );

  Future<ApiResult<EmdadVehicleInfoEntity>> getEmdadVehicleById(
    GetEmdadVehicleByIdParamEntity param,
  );

  Future<ApiResult<VehicleIdResponseEntity>> updateEmdadVehicle(
    UpdateEmdadVehicleParamEntity param,
  );

  Future<ApiResult<VehicleIdResponseEntity>> createEmdadVehicle(
    CreateEmdadVehicleParamEntity param,
  );
}
