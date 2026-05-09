import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'invoice_service.g.dart';

@RestApi()
@lazySingleton
abstract class InvoiceService {
  @factoryMethod
  factory InvoiceService(Dio dio) = _InvoiceService;

  @POST('/api/InvoiceOrg/CustomerInvoice')
  Future<BaseSingleResponse<InvoiceModel?>> getPreInvoice(@Body() Map<String, dynamic> body);

  @POST('/api/InvoiceOrg/EmdadgarInvoice')
  Future<BaseSingleResponse<InvoiceModel?>> getEmdadgarInvoice(@Body() Map<String, dynamic> body);

  @POST('/api/InvoiceOrg/CustomerPreInvoiceOnTheFly')
  Future<BaseSingleResponse<InvoiceModel?>> customerPreInvoiceOnTheFly(@Body() Map<String, dynamic> body);

}
