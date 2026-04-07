import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/report_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/repositories/indicator_report_repository.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/remote/data_source/request_history_data_source.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IndicatorReportRepository)
class IndicatorReportRepositoryImpl extends IndicatorReportRepository {
  final RequestDataSource _dataSource;

  IndicatorReportRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<ApiResult<List<IndicatorReportEntity?>>> fetchReportList(
      ReportParamEntity? entity) async {
    try {
      final result = await _dataSource.fetchActiveServiceRequestList();
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
