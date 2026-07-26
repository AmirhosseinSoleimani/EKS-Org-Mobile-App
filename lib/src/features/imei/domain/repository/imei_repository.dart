import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_mutation_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class ImeiRepository {
  Future<ApiResult<ImeiInfoPageEntity>> getByFilter(
    ImeiInfoFilterParamEntity param,
  );

  Future<ApiResult<List<DeviceInfoEntity>>> getDeviceTypes();

  Future<ApiResult<ImeiInfoEntity>> getById(ImeiInfoIdParamEntity param);

  Future<ApiResult<String>> add(ImeiInfoMutationParamEntity param);

  Future<ApiResult<String>> update(ImeiInfoMutationParamEntity param);

  Future<ApiResult<String>> delete(ImeiInfoIdParamEntity param);
}
