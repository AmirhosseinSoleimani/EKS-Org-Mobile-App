import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/report_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class IndicatorReportRepository {
  Future<ApiResult<List<IndicatorReportEntity?>>> fetchReportList(
      ReportParamEntity? entity);
}
