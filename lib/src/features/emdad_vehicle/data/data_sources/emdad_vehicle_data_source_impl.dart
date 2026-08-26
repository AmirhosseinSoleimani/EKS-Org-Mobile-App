import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/data_sources/emdad_vehicle_data_source.dart';
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
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/service/emdad_vehicle_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmdadVehicleDataSource)
class EmdadVehicleDataSourceImpl extends EmdadVehicleDataSource {
  final EmdadVehicleService _service;

  EmdadVehicleDataSourceImpl(this._service);

  @override
  Future<BaseListResponse<VehicleModelModel>> getEmdadVehicleList(
    GetEmdadVehicleListParamModel param,
  ) async =>
      await _service.getEmdadVehicleList(param.toJson());

  @override
  Future<BaseListResponse<VehicleToolModel>> getVehicleTools(
    GetVehicleToolsParamModel param,
  ) async =>
      await _service.getVehicleTools(param.toJson());

  @override
  Future<BaseSingleResponse<SubmitVehicleToolsResponseModel>>
      submitVehicleTools(SubmitVehicleToolsParamModel param) async =>
          await _service.submitVehicleTools(param.toJson());

  @override
  Future<BaseListResponse<VehicleServiceGroupModel>> getVehicleServices(
    GetVehicleServicesParamModel param,
  ) async =>
      await _service.getVehicleServices(param.toJson());

  @override
  Future<BaseListResponse<VehicleDefectModel>> getVehicleDefects(
    GetVehicleDefectsParamModel param,
  ) async =>
      await _service.getVehicleDefects(param.toJson());

  @override
  Future<BaseResponse> submitVehicleDefectLimitation(
    SubmitVehicleDefectLimitationParamModel param,
  ) =>
      _service.submitVehicleDefectLimitation(param.toJson());

  @override
  Future<BaseSingleResponse<SubmitVehicleServicesResponseModel>>
      submitVehicleServices(SubmitVehicleServicesParamModel param) async =>
          await _service.submitVehicleServices(param.toJson());

  @override
  Future<BaseSingleResponse<VehicleIdResponseModel>> deleteEmdadVehicle(
    DeleteEmdadVehicleParamModel param,
  ) async =>
      await _service.deleteEmdadVehicle(param.toJson());

  @override
  Future<BaseListResponse<VehicleHistoryModel>> getVehicleHistory(
    GetVehicleHistoryParamModel param,
  ) async =>
      await _service.getVehicleHistory(param.toJson());

  @override
  Future<BaseListResponse<ImeiInfoModel>> getImeiList() async =>
      await _service.getImeiList();

  @override
  Future<BaseListResponse<VehicleModelModel>> getActiveVehicleModels(
    GetActiveVehicleModelsParamModel param,
  ) async =>
      await _service.getActiveVehicleModels(param.toJson());

  @override
  Future<BaseSingleResponse<EmdadVehicleInfoModel>> getEmdadVehicleById(
    GetEmdadVehicleByIdParamModel param,
  ) async =>
      await _service.getEmdadVehicleById(param.toJson());

  @override
  Future<BaseSingleResponse<VehicleIdResponseModel>> updateEmdadVehicle(
    UpdateEmdadVehicleParamModel param,
  ) async =>
      await _service.updateEmdadVehicle(param.toJson());

  @override
  Future<BaseSingleResponse<VehicleIdResponseModel>> createEmdadVehicle(
    CreateEmdadVehicleParamModel param,
  ) async =>
      await _service.createEmdadVehicle(param.toJson());
}
