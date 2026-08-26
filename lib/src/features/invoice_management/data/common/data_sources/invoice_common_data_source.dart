import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_document_urls_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class InvoiceCommonDataSource {
  Future<BaseSingleResponse<InvoiceOperationAccessModel>> getOperationAccess();
  Future<BaseListResponse<EmdadServiceCategoryModel>> getEmdadCategories();
  Future<BaseSingleResponse<InvoiceDocumentUrlsModel>> getCustomerDocumentUrls(String invoiceGuid);
  Future<BaseSingleResponse<InvoiceDocumentUrlsModel>> getEmdadgarDocumentUrls(String invoiceGuid);
}
