import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_service_category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class VehicleModelRepository {
  Future<ApiResult<VehicleModelPageEntity>> getByFilter(
    VehicleModelFilterParamEntity param,
  );

  Future<ApiResult<List<VehicleNavganEntity>>> getNavgans();

  Future<ApiResult<List<VehicleServiceGroupEntity>>> getServiceGroups(
    VehicleModelIdParamEntity param,
  );

  Future<ApiResult<List<VehicleDefectEntity>>> getDefects(
    VehicleModelServiceCategoryParamEntity param,
  );

  Future<ApiResult<String>> submitDefects(VehicleModelIdsPayloadParamEntity param);

  Future<ApiResult<String>> submitServiceCategories(
    VehicleModelIdsPayloadParamEntity param,
  );

  Future<ApiResult<String>> deleteById(VehicleModelIdParamEntity param);

  Future<ApiResult<String>> updateVehicleModel(VehicleModelFormParamEntity param);

  Future<ApiResult<String>> addVehicleModel(VehicleModelFormParamEntity param);
}
