import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'invoice_service.g.dart';

@RestApi()
@lazySingleton
abstract class InvoiceService {
  @factoryMethod
  factory InvoiceService(Dio dio) = _InvoiceService;

  @POST('/api/Invoice/PreInvoice')
  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchPreInvoice(@Body() Map<String, dynamic> body);

  @POST('/api/Invoice/Invoice')
  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchInvoice(@Body() Map<String, dynamic> body);

  @POST('/api/Invoice/CustomerPreInvoiceOnTheFly')
  Future<BaseSingleResponse<InvoiceResponseModel?>> fetchPreInvoiceOnTheFly(@Body() Map<String, dynamic> body);

  @POST('/api/HomeServiceRequest/CustomerEvaluationAccept')
  Future<BaseSingleResponse<ConfirmInvoiceResponseModel?>> confirmHomeServiceInvoice(@Body() Map<String, dynamic> body);

}
