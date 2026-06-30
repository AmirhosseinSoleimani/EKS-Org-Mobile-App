import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/data/models/date_time_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'date_time_service.g.dart';

@RestApi()
@lazySingleton
abstract class DateTimeService {
  @factoryMethod
  factory DateTimeService(Dio dio) = _DateTimeService;

  @POST('/api/BaseInfo/GetDateTime')
  Future<BaseSingleResponse<DateTimeModel?>> getServerDateTime(@Body() Map<String, dynamic> body);
}
