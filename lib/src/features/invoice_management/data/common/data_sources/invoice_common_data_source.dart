import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_document_urls_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_operation_access_model.dart';

abstract class InvoiceCommonDataSource {
  Future<InvoiceOperationAccessModel> getOperationAccess();
  Future<List<EmdadServiceCategoryModel>> getEmdadCategories();
  Future<InvoiceDocumentUrlsModel> getCustomerDocumentUrls(String invoiceGuid);
  Future<InvoiceDocumentUrlsModel> getEmdadgarDocumentUrls(String invoiceGuid);
}
