import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/indicatior_report_model.dart';
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
  Future<BaseSingleResponse<IndicatorReportModel?>> fetchReportList(@Body() Map<String, dynamic> body);
}
