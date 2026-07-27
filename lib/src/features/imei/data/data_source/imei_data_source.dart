import 'package:eks_sana_plus_org/src/features/imei/data/models/device_info_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/imei_info_page_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/imei/data/models/params/imei_info_mutation_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class ImeiDataSource {
  Future<BaseSingleResponse<ImeiInfoPageModel>> getByFilter(
    ImeiInfoFilterRequestModel request,
  );

  Future<BaseSingleResponse<List<DeviceInfoModel>>> getDeviceTypes();

  Future<BaseSingleResponse<ImeiInfoModel>> getById(
    ImeiInfoIdRequestModel request,
  );

  Future<BaseSingleResponse<String>> add(
    ImeiInfoMutationRequestModel request,
  );

  Future<BaseSingleResponse<String>> update(
    ImeiInfoMutationRequestModel request,
  );

  Future<BaseSingleResponse<String>> delete(
    ImeiInfoIdRequestModel request,
  );
}
