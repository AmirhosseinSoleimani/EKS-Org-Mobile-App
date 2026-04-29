import 'package:eks_sana_plus_org/src/features/dashboard/data/data_sources/dashboard_report_data_source.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/server_date_time_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/repositories/dashboard_report_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DashboardReportRepository)
class DashboardReportRepositoryImpl extends DashboardReportRepository {
  final DashboardDataSource _dataSource;

  DashboardReportRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<ApiResult<DashboardEntity?>> getDashboardData(
      DashboardParamEntity param) async {
    try {
      final result = await _dataSource.getDashboardData(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ServerDateTimeEntity?>> getServerDateTime() async {
    try {
      final result = await _dataSource.getServerDateTime();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
