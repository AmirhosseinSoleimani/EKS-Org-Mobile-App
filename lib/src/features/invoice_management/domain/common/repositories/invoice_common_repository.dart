import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_document_urls_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class InvoiceCommonRepository {
  Future<ApiResult<InvoiceOperationAccessEntity>> getOperationAccess();

  Future<ApiResult<List<EmdadServiceCategoryEntity>>> getEmdadCategories();

  Future<ApiResult<InvoiceDocumentUrlsEntity>> getCustomerDocumentUrls(
    String invoiceGuid,
  );

  Future<ApiResult<InvoiceDocumentUrlsEntity>> getEmdadgarDocumentUrls(
    String invoiceGuid,
  );
}
