import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_param_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class DashboardDataSource {
  Future<BaseSingleResponse<DashboardModel?>> getDashboardData(
      DashboardParamModel param);
}
