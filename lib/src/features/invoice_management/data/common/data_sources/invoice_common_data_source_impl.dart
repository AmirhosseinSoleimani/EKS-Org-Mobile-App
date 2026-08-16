import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/data_sources/invoice_common_data_source.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_document_urls_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/services/invoice_common_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InvoiceCommonDataSource)
class InvoiceCommonDataSourceImpl implements InvoiceCommonDataSource {
  const InvoiceCommonDataSourceImpl(this._service);

  final InvoiceCommonService _service;

  @override
  Future<InvoiceOperationAccessModel> getOperationAccess() {
    return _service.getOperationAccess();
  }

  @override
  Future<List<EmdadServiceCategoryModel>> getEmdadCategories() {
    return _service.getEmdadCategories();
  }

  @override
  Future<InvoiceDocumentUrlsModel> getCustomerDocumentUrls(String invoiceGuid) {
    return _service.getCustomerDocumentUrls(invoiceGuid);
  }

  @override
  Future<InvoiceDocumentUrlsModel> getEmdadgarDocumentUrls(String invoiceGuid) {
    return _service.getEmdadgarDocumentUrls(invoiceGuid);
  }
}
