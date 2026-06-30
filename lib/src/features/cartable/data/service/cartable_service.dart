import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cartable_service.g.dart';

@RestApi()
@lazySingleton
abstract class CartableService {
  @factoryMethod
  factory CartableService(Dio dio) = _CartableService;
/*
  @POST('/api/IndexReport/IndexDashboard')
  Future<BaseSingleResponse<DashboardModel?>> getDashboardData(@Body() Map<String, dynamic> body);*/
}
