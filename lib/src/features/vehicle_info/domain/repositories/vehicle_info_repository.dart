import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/create_or_edit_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_service_category_params.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_tool_params.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_defect_limitation_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class VehicleInfoRepository {
  Future<ApiResult<VehicleInfoPageEntity>> getVehicles(VehicleInfoFilterParamEntity param);
  Future<ApiResult<VehicleInfoEntity>> getVehicleById(int id);
  Future<ApiResult<void>> createVehicle(CreateOrEditVehicleParamEntity param);
  Future<ApiResult<void>> editVehicle(CreateOrEditVehicleParamEntity param);
  Future<ApiResult<void>> deleteVehicle(int id);
  Future<ApiResult<List<VehicleModelEntity>>> getVehicleModels({bool onlyActive = false});
  Future<ApiResult<List<EmdadServiceCategoryGroupEntity>>> getServiceCategories(int id);
  Future<ApiResult<void>> submitServiceCategories(SubmitVehicleServiceCategoriesParamEntity param);
  Future<ApiResult<List<VehicleToolEntity>>> getVehicleTools(GetVehicleToolsParamEntity param);
  Future<ApiResult<void>> submitVehicleTools(SubmitVehicleToolsParamEntity param);
  Future<ApiResult<List<EmdadServiceCategoryGroupEntity>>> getGroupedServiceCategories(int id);
  Future<ApiResult<void>> insertBatchServiceCategories(InsertBatchVehicleServiceCategoriesParamEntity param);
  Future<ApiResult<List<VehicleDefectLimitationEntity>>> getDefects(GetVehicleDefectsParamEntity param);
  Future<ApiResult<void>> submitDefectLimitation(SubmitVehicleDefectLimitationParamEntity param);
}
