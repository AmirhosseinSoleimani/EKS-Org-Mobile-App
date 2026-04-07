import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/report_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/repositories/indicator_report_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchIndicatorReportUseCase extends BaseUseCase<
    ApiResult<IndicatorReportEntity?>, ReportParamEntity> {
  FetchIndicatorReportUseCase(this._repository);

  final IndicatorReportRepository _repository;

  @override
  Future<ApiResult<IndicatorReportEntity?>> call(
      ReportParamEntity arg) async {
    return await _repository.fetchIndicatorReport(arg);
  }
}
