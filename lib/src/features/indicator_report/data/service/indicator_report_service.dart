import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/indicatior_report_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/active_request_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/cancel_reason_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/message_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/payment_result_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/request_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/time_table_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'indicator_report_service.g.dart';

@RestApi()
@lazySingleton
abstract class IndicatorReportService {
  @factoryMethod
  factory IndicatorReportService(Dio dio) = _IndicatorReportService;

  @POST('/api/IndexReport/IndexReport')
  Future<BaseListResponse<IndicatorReportModel?>> fetchReportList(@Body() Map<String, dynamic> body);
}
