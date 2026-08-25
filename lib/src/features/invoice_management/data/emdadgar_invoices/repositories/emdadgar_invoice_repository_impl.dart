import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/data_sources/emdadgar_invoice_data_source.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/bulk_invoice_accept_result_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/params/bulk_invoice_accept_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/repositories/emdadgar_invoice_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EmdadgarInvoiceRepository)
class EmdadgarInvoiceRepositoryImpl implements EmdadgarInvoiceRepository {
  const EmdadgarInvoiceRepositoryImpl(this._dataSource);

  final EmdadgarInvoiceDataSource _dataSource;

  @override
  Future<ApiResult<EmdadgarInvoicePageEntity>> getInitialInvoices(
    InvoiceListFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getInitialInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<InvoiceEntity?>> getInitialInvoiceDetails(
    InvoiceDetailsParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getInitialInvoiceDetails(param.toModel());
      return result.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<BulkInvoiceAcceptResultEntity>> acceptInitialInvoices(
    BulkInvoiceAcceptParamEntity param,
  ) async {
    try {
      final result = await _dataSource.acceptInitialInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<EmdadgarInvoicePageEntity>> getInvoices(
    InvoiceListFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<BulkInvoiceAcceptResultEntity>> acceptInvoices(
    BulkInvoiceAcceptParamEntity param,
  ) async {
    try {
      final result = await _dataSource.acceptInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<BulkInvoiceAcceptResultEntity>> acceptFinalApprovalInvoices(
    BulkInvoiceAcceptParamEntity param,
  ) async {
    try {
      final result = await _dataSource.acceptFinalApprovalInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<EmdadgarInvoicePageEntity>> getFinalApprovalInvoices(
    InvoiceListFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getFinalApprovalInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<BulkInvoiceAcceptResultEntity>> acceptFinalCorrectionInvoices(
    BulkInvoiceAcceptParamEntity param,
  ) async {
    try {
      final result = await _dataSource.acceptFinalCorrectionInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<EmdadgarInvoicePageEntity>> getFinalCorrectionInvoices(
    InvoiceListFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getFinalCorrectionInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<EmdadgarInvoicePageEntity>> getDefiniteInvoices(
    InvoiceListFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getDefiniteInvoices(param.toModel());
      return ApiResult.success(data: result, resultCode: 0);
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
