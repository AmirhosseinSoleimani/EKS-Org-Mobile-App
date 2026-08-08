import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/bulk_invoice_accept_result_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_definite_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_final_invoice_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/params/bulk_invoice_accept_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';

abstract class EmdadgarInvoiceRepository {
  Future<ApiResult<EmdadgarInvoicePageEntity>> getInitialInvoices(
    InvoiceListFilterParamEntity param,
  );

  Future<ApiResult<InvoiceEntity?>> getInitialInvoiceDetails(
    InvoiceDetailsParamEntity param,
  );

  Future<ApiResult<BulkInvoiceAcceptResultEntity>> acceptInitialInvoices(
    BulkInvoiceAcceptParamEntity param,
  );

  Future<ApiResult<EmdadgarInvoicePageEntity>> getInvoices(
    InvoiceListFilterParamEntity param,
  );

  Future<ApiResult<BulkInvoiceAcceptResultEntity>> acceptInvoices(
    BulkInvoiceAcceptParamEntity param,
  );

  Future<ApiResult<EmdadgarInvoicePageEntity>> getFinalApprovalInvoices(
    InvoiceListFilterParamEntity param,
  );

  Future<ApiResult<EmdadgarFinalInvoicePageEntity>> getFinalCorrectionInvoices(
    InvoiceListFilterParamEntity param,
  );

  Future<ApiResult<EmdadgarDefiniteInvoicePageEntity>> getDefiniteInvoices(
    InvoiceListFilterParamEntity param,
  );
}
