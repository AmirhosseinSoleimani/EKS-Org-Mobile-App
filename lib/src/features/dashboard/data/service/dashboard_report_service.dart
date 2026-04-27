import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/server_date_time_model.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/indicatior_report_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'dashboard_report_service.g.dart';

@RestApi()
@lazySingleton
abstract class DashboardReportService {
  @factoryMethod
  factory DashboardReportService(Dio dio) = _DashboardReportService;

  @POST('/api/IndexReportOrg/IndexDashboard')
  Future<BaseSingleResponse<DashboardModel?>> getDashboardData(@Body() Map<String, dynamic> body);

  @POST('/api/BaseInfo/GetDateTime')
  Future<BaseSingleResponse<ServerDateTimeModel?>> getServerDateTime(@Body() Map<String, dynamic> body);
}
