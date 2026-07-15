import 'package:eks_sana_plus_org/src/features/rescuer/data/data_sources/rescuer_data_source.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/delete_rescuer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/params/get_rescuer_report_param_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/params/get_rescuers_param_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/rescuer_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/san_history_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/skill_certificate_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/service/rescuer_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RescuerDataSource)
class RescuerDataSourceImpl extends RescuerDataSource {
  final RescuerService _service;

  RescuerDataSourceImpl(this._service);

  @override
  Future<BaseListResponse<RescuerModel>> getRescuers(
    GetRescuersParamModel param,
  ) {
    return _service.getRescuers(param.toJson());
  }

  @override
  Future<BaseListResponse<RescuerModel>> getRescuerReport(
    GetRescuerReportParamModel param,
  ) {
    return _service.getRescuerReport(param.toJson());
  }

  @override
  Future<BaseSingleResponse<RescuerModel>> getRescuerById(int id) {
    return _service.getRescuerById(id);
  }

  @override
  Future<BaseListResponse<SkillCertificateModel>> getSkillCertificates(
    int id,
  ) {
    return _service.getSkillCertificates(id);
  }

  @override
  Future<BaseListResponse<SanHistoryModel>> getHistory(int id) {
    return _service.getHistory(id);
  }

  @override
  Future<BaseSingleResponse<DeleteRescuerResponseModel>> deleteRescuer(
    int id,
  ) {
    return _service.deleteRescuer(id);
  }
}
