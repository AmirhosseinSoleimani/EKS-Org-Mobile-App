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
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVehicleInfoListUseCase {
  const GetVehicleInfoListUseCase(this._repository);
  final VehicleInfoRepository _repository;
  Future<ApiResult<VehicleInfoPageEntity>> call(VehicleInfoFilterParamEntity param) => _repository.getVehicles(param);
}

@injectable
class GetVehicleInfoByIdUseCase {
  const GetVehicleInfoByIdUseCase(this._repository);
  final VehicleInfoRepository _repository;
  Future<ApiResult<VehicleInfoEntity>> call(int id) => _repository.getVehicleById(id);
}

@injectable
class SaveVehicleInfoUseCase {
  const SaveVehicleInfoUseCase(this._repository);
  final VehicleInfoRepository _repository;
  Future<ApiResult<void>> create(CreateOrEditVehicleParamEntity param) => _repository.createVehicle(param);
  Future<ApiResult<void>> edit(CreateOrEditVehicleParamEntity param) => _repository.editVehicle(param);
}

@injectable
class DeleteVehicleInfoUseCase {
  const DeleteVehicleInfoUseCase(this._repository);
  final VehicleInfoRepository _repository;
  Future<ApiResult<void>> call(int id) => _repository.deleteVehicle(id);
}

@injectable
class GetVehicleInfoLookupsUseCase {
  const GetVehicleInfoLookupsUseCase(this._repository);
  final VehicleInfoRepository _repository;
  Future<ApiResult<List<VehicleModelEntity>>> getVehicleModels({bool onlyActive = false}) {
    return _repository.getVehicleModels(onlyActive: onlyActive);
  }
}

@injectable
class VehicleInfoToolsUseCase {
  const VehicleInfoToolsUseCase(this._repository);
  final VehicleInfoRepository _repository;
  Future<ApiResult<List<VehicleToolEntity>>> getTools(int vehicleId) {
    return _repository.getVehicleTools(GetVehicleToolsParamEntity(vehicleId: vehicleId));
  }

  Future<ApiResult<void>> submit({
    required int vehicleId,
    required List<int> emdadToolsIds,
  }) {
    return _repository.submitVehicleTools(SubmitVehicleToolsParamEntity(
      vehicleId: vehicleId,
      emdadToolsIds: emdadToolsIds,
    ));
  }
}

@injectable
class VehicleInfoServiceCategoriesUseCase {
  const VehicleInfoServiceCategoriesUseCase(this._repository);
  final VehicleInfoRepository _repository;

  Future<ApiResult<List<EmdadServiceCategoryGroupEntity>>> getServiceCategories(int id) {
    return _repository.getServiceCategories(id);
  }

  Future<ApiResult<void>> submitServiceCategories({
    required int vehicleInfoId,
    required List<int> emdadServiceCategoryIds,
  }) {
    return _repository.submitServiceCategories(SubmitVehicleServiceCategoriesParamEntity(
      vehicleInfoId: vehicleInfoId,
      emdadServiceCategoryIds: emdadServiceCategoryIds,
    ));
  }

  Future<ApiResult<List<EmdadServiceCategoryGroupEntity>>> getGroupedServiceCategories(int id) {
    return _repository.getGroupedServiceCategories(id);
  }

  Future<ApiResult<void>> insertBatch({
    required int vehicleId,
    required List<int> emdadServiceCategoryIds,
  }) {
    return _repository.insertBatchServiceCategories(InsertBatchVehicleServiceCategoriesParamEntity(
      vehicleId: vehicleId,
      emdadServiceCategoryIds: emdadServiceCategoryIds,
    ));
  }

  Future<ApiResult<List<VehicleDefectLimitationEntity>>> getDefects({
    required int vehicleInfoId,
    required int emdadServiceCategoryId,
  }) {
    return _repository.getDefects(GetVehicleDefectsParamEntity(
      vehicleInfoId: vehicleInfoId,
      emdadServiceCategoryId: emdadServiceCategoryId,
    ));
  }

  Future<ApiResult<void>> submitDefectLimitation({
    required int vehicleId,
    required int serviceCategoryId,
    required List<int> defectInfoIds,
  }) {
    return _repository.submitDefectLimitation(SubmitVehicleDefectLimitationParamEntity(
      vehicleId: vehicleId,
      serviceCategoryId: serviceCategoryId,
      defectInfoIds: defectInfoIds,
    ));
  }
}

@injectable
class VehicleInfoHistoryUseCase {
  const VehicleInfoHistoryUseCase(this._repository);
  final VehicleInfoRepository _repository;

  Future<ApiResult<List<VehicleHistoryEntity>>> getHistories({
    required int refId,
    int type = 2,
  }) {
    return _repository.getVehicleHistories(VehicleHistoryParamEntity(
      refId: refId,
      type: type,
    ));
  }
}
