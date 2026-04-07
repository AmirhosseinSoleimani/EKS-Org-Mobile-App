import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/indicatior_report_model.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/report_param_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class IndicatorReportDataSource {
  Future<BaseSingleResponse<IndicatorReportModel?>> fetchIndicatorReport(
      ReportParamModel param);
}
