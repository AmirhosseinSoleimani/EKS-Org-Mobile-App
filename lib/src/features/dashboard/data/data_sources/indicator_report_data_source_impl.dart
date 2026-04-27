import 'package:eks_sana_plus_org/src/features/dashboard/data/data_sources/dashboard_report_data_source.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_param_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/server_date_time_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/service/dashboard_report_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DashboardDataSource)
class DashboardDataSourceImpl extends DashboardDataSource {
  final DashboardReportService _service;

  DashboardDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<DashboardModel?>> getDashboardData(
          DashboardParamModel param) async =>
      await _service.getDashboardData(param.toJson());

  @override
  Future<BaseSingleResponse<ServerDateTimeModel?>> getServerDateTime() async =>
      await _service.getServerDateTime({});
}
