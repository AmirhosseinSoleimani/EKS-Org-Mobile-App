import 'package:eks_sana_plus_org/src/features/dashboard/data/data_sources/dashboard_data_source.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_param_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/data/models/date_time_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/service/dashboard_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DashboardDataSource)
class DashboardDataSourceImpl extends DashboardDataSource {
  final DashboardService _service;

  DashboardDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<DashboardModel?>> getDashboardData(
          DashboardParamModel param) async =>
      await _service.getDashboardData(param.toJson());
}
