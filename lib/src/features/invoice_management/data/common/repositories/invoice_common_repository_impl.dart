import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/data_sources/invoice_common_data_source.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_document_urls_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/repositories/invoice_common_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InvoiceCommonRepository)
class InvoiceCommonRepositoryImpl implements InvoiceCommonRepository {
  const InvoiceCommonRepositoryImpl(this._dataSource);

  final InvoiceCommonDataSource _dataSource;

  @override
  Future<ApiResult<InvoiceOperationAccessEntity>> getOperationAccess() async {
    try {
      final result = await _dataSource.getOperationAccess();
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<EmdadServiceCategoryEntity>>> getEmdadCategories() async {
    try {
      final result = await _dataSource.getEmdadCategories();
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<InvoiceDocumentUrlsEntity>> getCustomerDocumentUrls(
    String invoiceGuid,
  ) async {
    try {
      final result = await _dataSource.getCustomerDocumentUrls(invoiceGuid);
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<InvoiceDocumentUrlsEntity>> getEmdadgarDocumentUrls(
    String invoiceGuid,
  ) async {
    try {
      final result = await _dataSource.getEmdadgarDocumentUrls(invoiceGuid);
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
