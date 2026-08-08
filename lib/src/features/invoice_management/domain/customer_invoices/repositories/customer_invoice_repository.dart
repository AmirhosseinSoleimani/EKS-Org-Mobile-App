import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';

abstract class CustomerInvoiceRepository {
  Future<ApiResult<InvoiceRecordPageEntity>> getPreInvoices(
    InvoiceListFilterParamEntity param,
  );

  Future<ApiResult<InvoiceRecordPageEntity>> getInvoices(
    InvoiceListFilterParamEntity param,
  );

  Future<ApiResult<InvoiceEntity?>> getDetails(InvoiceDetailsParamEntity param);

  Future<ApiResult<String>> finalizeInvoice(InvoiceDetailsParamEntity param);
}
