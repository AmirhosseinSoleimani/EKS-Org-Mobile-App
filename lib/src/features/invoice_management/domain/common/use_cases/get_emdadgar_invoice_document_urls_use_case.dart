import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_document_urls_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/repositories/invoice_common_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetEmdadgarInvoiceDocumentUrlsUseCase {
  const GetEmdadgarInvoiceDocumentUrlsUseCase(this._repository);

  final InvoiceCommonRepository _repository;

  Future<ApiResult<InvoiceDocumentUrlsEntity>> call(String invoiceGuid) {
    return _repository.getEmdadgarDocumentUrls(invoiceGuid);
  }
}
