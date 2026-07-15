import 'package:eks_sana_plus_org/src/features/rescuer/data/models/delete_rescuer_response_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/params/get_rescuer_report_param_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/params/get_rescuers_param_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/rescuer_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/san_history_model.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/data/models/skill_certificate_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class RescuerDataSource {
  Future<BaseListResponse<RescuerModel>> getRescuers(
    GetRescuersParamModel param,
  );

  Future<BaseListResponse<RescuerModel>> getRescuerReport(
    GetRescuerReportParamModel param,
  );

  Future<BaseSingleResponse<RescuerModel>> getRescuerById(int id);

  Future<BaseListResponse<SkillCertificateModel>> getSkillCertificates(
    int id,
  );

  Future<BaseListResponse<SanHistoryModel>> getHistory(int id);

  Future<BaseSingleResponse<DeleteRescuerResponseModel>> deleteRescuer(
    int id,
  );
}
