import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/delete_rescuer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuer_report_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuers_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/san_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class RescuerRepository {
  Future<ApiResult<List<RescuerEntity>>> getRescuers(
    GetRescuersParamEntity param,
  );

  Future<ApiResult<List<RescuerEntity>>> getRescuerReport(
    GetRescuerReportParamEntity param,
  );

  Future<ApiResult<RescuerEntity>> getRescuerById(int id);

  Future<ApiResult<List<SkillCertificateEntity>>> getSkillCertificates(
    int id,
  );

  Future<ApiResult<List<SanHistoryEntity>>> getHistory(int id);

  Future<ApiResult<DeleteRescuerResponseEntity>> deleteRescuer(int id);
}
