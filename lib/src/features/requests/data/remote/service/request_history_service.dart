import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/requests/data/models/active_request_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/cancel_reason_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/message_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/payment_result_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/request_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/time_table_response_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'request_history_service.g.dart';

@RestApi()
@lazySingleton
abstract class RequestService {
  @factoryMethod
  factory RequestService(Dio dio) = _RequestService;

  @POST('/api/SanaPlus/GetRequestHistory')
  Future<BaseListResponse<RequestModel>> fetchRequestHistory(@Body() Map<String, dynamic> body);

  @POST('/api/SanaPlus/GetCancelReasons')
  Future<BaseListResponse<CancelReasonModel>> getCancelReasonsList(
      @Body() Map<String, dynamic> body);


  @POST('/api/SanaPlus/CancelRequest')
  Future<BaseSingleResponse<MessageModel?>> cancelRequest(@Body() Map<String, dynamic> body);

  @GET('/api/HomeServiceRequest/GetTimeForHomeServiceRequest')
  Future<BaseListResponse<DayScheduleModel?>> getTimes(
      @Queries() Map<String, dynamic> query);

  @POST('/api/HomeServiceRequest/ChangeHomeServiceRequestTime')
  Future<BaseSingleResponse<MessageModel>> changeTime(
      @Body() Map<String, dynamic> body);

  @POST('/api/User/ActiveServiceRequests')
  Future<BaseListResponse<ActiveRequestModel?>> fetchActiveServiceRequestList(
      @Body() Map<String, dynamic> body);

  @POST('/api/Invoice/UpdatePaymentType')
  Future<BaseSingleResponse<PaymentResultModel>> updatePaymentType(
      @Body() Map<String, dynamic> body);
}
