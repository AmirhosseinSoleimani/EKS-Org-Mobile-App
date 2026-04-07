import 'package:eks_sana_plus_org/src/features/indicator_report/data/data_sources/indicator_report_data_source.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/report_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/repositories/indicator_report_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IndicatorReportRepository)
class IndicatorReportRepositoryImpl extends IndicatorReportRepository {
  final IndicatorReportDataSource _dataSource;

  IndicatorReportRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<ApiResult<IndicatorReportEntity?>> fetchIndicatorReport(
      ReportParamEntity entity) async {
    try {
      final result = await _dataSource.fetchIndicatorReport(entity.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
