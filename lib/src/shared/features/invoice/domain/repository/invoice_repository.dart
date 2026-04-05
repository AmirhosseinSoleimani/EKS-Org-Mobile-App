import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/confirm_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/confirm_invoice_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/service_invoice_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_response_entity.dart';

abstract class InvoiceRepository {
  Future<ApiResult<InvoiceResponseEntity?>> fetchPreInvoice(ServiceInvoiceRequestEntity? entity);

  Future<ApiResult<InvoiceResponseEntity?>> fetchInvoice(ServiceInvoiceRequestEntity? entity);

  Future<ApiResult<InvoiceResponseEntity?>> fetchPreInvoiceOnTheFly(ServiceInvoiceRequestEntity? entity);

  Future<ApiResult<ConfirmInvoiceResponseEntity?>> confirmHomeServiceInvoice(ConfirmHomeServiceRequest? entity);
}
