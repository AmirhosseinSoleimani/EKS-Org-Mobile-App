import 'package:eks_sana_plus_org/src/features/vehicle_model/data/data_source/vehicle_model_data_source.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_ids_payload_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/params/vehicle_model_service_category_request_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_defect_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_page_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_navgan_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_service_group_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/service/vehicle_model_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VehicleModelDataSource)
class VehicleModelDataSourceImpl extends VehicleModelDataSource {
  VehicleModelDataSourceImpl(this._service);

  final VehicleModelService _service;

  @override
  Future<BaseSingleResponse<VehicleModelPageModel>> getByFilter(
    VehicleModelFilterRequestModel request,
  ) => _service.getByFilter(request);

  @override
  Future<BaseSingleResponse<List<VehicleNavganModel>>> getNavgans() =>
      _service.getNavgans();

  @override
  Future<BaseSingleResponse<List<VehicleServiceGroupModel>>> getServiceGroups(
    VehicleModelIdRequestModel request,
  ) => _service.getServiceGroups(request);

  @override
  Future<BaseSingleResponse<List<VehicleDefectModel>>> getDefects(
    VehicleModelServiceCategoryRequestModel request,
  ) => _service.getDefects(request);

  @override
  Future<BaseSingleResponse<String>> submitDefects(
    VehicleModelIdsPayloadRequestModel request,
  ) => _service.submitDefects(request);

  @override
  Future<BaseSingleResponse<String>> submitServiceCategories(
    VehicleModelIdsPayloadRequestModel request,
  ) => _service.submitServiceCategories(request);

  @override
  Future<BaseSingleResponse<String>> deleteById(
    VehicleModelIdRequestModel request,
  ) => _service.deleteById(request);

  @override
  Future<BaseSingleResponse<String>> updateVehicleModel(
    VehicleModelFormRequestModel request,
  ) => _service.updateVehicleModel(request);

  @override
  Future<BaseSingleResponse<String>> addVehicleModel(
    VehicleModelFormRequestModel request,
  ) => _service.addVehicleModel(request);
}
