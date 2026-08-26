import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/emdad_vehicle_info_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/imei_info_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/submit_vehicle_services_response_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/submit_vehicle_tools_response_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_defect_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_history_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_id_response_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_service_group_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_tool_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_emdad_vehicle_list_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_vehicle_tools_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/submit_vehicle_tools_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_vehicle_services_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_vehicle_defects_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/submit_vehicle_defect_limitation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/submit_vehicle_services_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/delete_emdad_vehicle_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_vehicle_history_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_active_vehicle_models_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/get_emdad_vehicle_by_id_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/update_emdad_vehicle_param_model.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/params/create_emdad_vehicle_param_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class EmdadVehicleDataSource {
  Future<BaseListResponse<VehicleModelModel>> getEmdadVehicleList(
    GetEmdadVehicleListParamModel param,
  );

  Future<BaseListResponse<VehicleToolModel>> getVehicleTools(
    GetVehicleToolsParamModel param,
  );

  Future<BaseSingleResponse<SubmitVehicleToolsResponseModel>>
      submitVehicleTools(SubmitVehicleToolsParamModel param);

  Future<BaseListResponse<VehicleServiceGroupModel>> getVehicleServices(
    GetVehicleServicesParamModel param,
  );

  Future<BaseListResponse<VehicleDefectModel>> getVehicleDefects(
    GetVehicleDefectsParamModel param,
  );

  Future<BaseResponse> submitVehicleDefectLimitation(
    SubmitVehicleDefectLimitationParamModel param,
  );

  Future<BaseSingleResponse<SubmitVehicleServicesResponseModel>>
      submitVehicleServices(SubmitVehicleServicesParamModel param);

  Future<BaseSingleResponse<VehicleIdResponseModel>> deleteEmdadVehicle(
    DeleteEmdadVehicleParamModel param,
  );

  Future<BaseListResponse<VehicleHistoryModel>> getVehicleHistory(
    GetVehicleHistoryParamModel param,
  );

  Future<BaseListResponse<ImeiInfoModel>> getImeiList();

  Future<BaseListResponse<VehicleModelModel>> getActiveVehicleModels(
    GetActiveVehicleModelsParamModel param,
  );

  Future<BaseSingleResponse<EmdadVehicleInfoModel>> getEmdadVehicleById(
    GetEmdadVehicleByIdParamModel param,
  );

  Future<BaseSingleResponse<VehicleIdResponseModel>> updateEmdadVehicle(
    UpdateEmdadVehicleParamModel param,
  );

  Future<BaseSingleResponse<VehicleIdResponseModel>> createEmdadVehicle(
    CreateEmdadVehicleParamModel param,
  );
}
