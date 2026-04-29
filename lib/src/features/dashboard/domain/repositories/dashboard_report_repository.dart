

import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/server_date_time_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class DashboardReportRepository {
  Future<ApiResult<DashboardEntity?>> getDashboardData(
      DashboardParamEntity param);

  Future<ApiResult<ServerDateTimeEntity?>> getServerDateTime();

}
