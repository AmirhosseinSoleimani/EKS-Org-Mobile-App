import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'shift_service.g.dart';

@RestApi()
@lazySingleton
abstract class ShiftService {
  @factoryMethod
  factory ShiftService(Dio dio) = _ShiftService;

  @POST('/api/Shift/GetByFilterJson')
  Future<dynamic> getByFilter(@Body() Map<String, dynamic> body);

  @GET('/api/Shift/GetById')
  Future<dynamic> getById(@Query('Id') int id);

  @POST('/api/Shift/post')
  Future<dynamic> create(@Body() Map<String, dynamic> body);

  @PUT('/api/Shift/put')
  Future<dynamic> update(@Body() Map<String, dynamic> body);

  @DELETE('/api/Shift/DeleteByID')
  Future<dynamic> deleteById(@Query('id') int id);

  @GET('/api/Shift/GetShifts')
  Future<dynamic> getShifts();
}
