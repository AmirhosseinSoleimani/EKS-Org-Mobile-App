import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_ids_payload_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_service_category_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_defect_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_page_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_navgan_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_service_group_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class VehicleModelDataSource {
  Future<BaseSingleResponse<VehicleModelPageModel>> getByFilter(
    VehicleModelFilterRequestModel request,
  );

  Future<BaseSingleResponse<List<VehicleNavganModel>>> getNavgans();

  Future<BaseSingleResponse<List<VehicleServiceGroupModel>>> getServiceGroups(
    VehicleModelIdRequestModel request,
  );

  Future<BaseSingleResponse<List<VehicleDefectModel>>> getDefects(
    VehicleModelServiceCategoryRequestModel request,
  );

  Future<BaseSingleResponse<String>> submitDefects(
    VehicleModelIdsPayloadRequestModel request,
  );

  Future<BaseSingleResponse<String>> submitServiceCategories(
    VehicleModelIdsPayloadRequestModel request,
  );

  Future<BaseSingleResponse<String>> deleteById(
    VehicleModelIdRequestModel request,
  );

  Future<BaseSingleResponse<String>> updateVehicleModel(
    VehicleModelFormRequestModel request,
  );

  Future<BaseSingleResponse<String>> addVehicleModel(
    VehicleModelFormRequestModel request,
  );
}
