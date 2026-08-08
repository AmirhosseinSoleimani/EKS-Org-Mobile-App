import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/customer_invoices/data_sources/customer_invoice_data_source.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/customer_invoices/repositories/customer_invoice_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CustomerInvoiceRepository)
class CustomerInvoiceRepositoryImpl implements CustomerInvoiceRepository {
  const CustomerInvoiceRepositoryImpl(this._dataSource);

  final CustomerInvoiceDataSource _dataSource;

  @override
  Future<ApiResult<InvoiceRecordPageEntity>> getPreInvoices(
    InvoiceListFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getPreInvoices(
        param.toModel(),
      );
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<InvoiceRecordPageEntity>> getInvoices(
    InvoiceListFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getInvoices(
        param.toModel(),
      );
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<InvoiceEntity?>> getDetails(
    InvoiceDetailsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getDetails(
        param.toModel(),
      );
      return result.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<String>> finalizeInvoice(
    InvoiceDetailsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.finalizeInvoice(
        param.toModel(),
      );
      return result.toApiResult<String>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
