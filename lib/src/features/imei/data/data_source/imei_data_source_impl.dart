import 'package:eks_sana_plus_org/src/features/imei/data/data_source/imei_data_source.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/device_info_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_page_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/device_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_mutation_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/service/imei_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImeiDataSource)
class ImeiDataSourceImpl extends ImeiDataSource {
  ImeiDataSourceImpl(this._service);

  final ImeiService _service;

  @override
  Future<BaseSingleResponse<ImeiInfoPageModel>> getByFilter(
    ImeiInfoFilterRequestModel request,
  ) {
    return _service.getByFilter(request);
  }

  @override
  Future<BaseSingleResponse<List<DeviceInfoModel>>> getDeviceTypes() {
    return _service.getDeviceTypes(const DeviceInfoFilterRequestModel());
  }

  @override
  Future<BaseSingleResponse<ImeiInfoModel>> getById(
    ImeiInfoIdRequestModel request,
  ) {
    return _service.getById(request);
  }

  @override
  Future<BaseSingleResponse<String>> add(
    ImeiInfoMutationRequestModel request,
  ) {
    return _service.add(request);
  }

  @override
  Future<BaseSingleResponse<String>> update(
    ImeiInfoMutationRequestModel request,
  ) {
    return _service.update(request);
  }

  @override
  Future<BaseSingleResponse<String>> delete(
    ImeiInfoIdRequestModel request,
  ) {
    return _service.delete(request);
  }
}
