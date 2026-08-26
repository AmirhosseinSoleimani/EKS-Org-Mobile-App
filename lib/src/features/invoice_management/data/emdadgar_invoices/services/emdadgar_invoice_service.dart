import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_result_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_page_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EmdadgarInvoiceService {
  const EmdadgarInvoiceService(this._dio);

  final Dio _dio;

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>> getInitialInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarPreInvoice',
      data: request.toJson(),
    );
    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<InvoiceModel?>> getInitialInvoiceDetails(
    InvoiceDetailsRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/EmdadgarPreInvoice',
      data: request.toJson(),
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    final data = resultCode == 0
        ? ResponseJsonReader.object(response.data)
        : null;
    return BaseSingleResponse<InvoiceModel?>(
      resultCode: resultCode,
      data: data == null || data.isEmpty ? null : InvoiceModel.fromJson(data),
      failures: ResponseJsonReader.failures(response.data),
    );
  }

  Future<BaseSingleResponse<BulkInvoiceAcceptResultModel>>
      acceptInitialInvoices(
    BulkInvoiceAcceptParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AidServiceEvaluation/BulkInvoiceOperatorInvoiceAccept',
      data: request.toJson(),
    );
    return _bulkResponse(response.data);
  }

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>> getInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarInvoice',
      data: request.toJson(),
    );
    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<BulkInvoiceAcceptResultModel>> acceptInvoices(
    BulkInvoiceAcceptParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AidServiceEvaluation/BulkAdminOperatorInvoiceAccept',
      data: request.toJson(),
    );
    return _bulkResponse(response.data);
  }

  Future<BaseSingleResponse<BulkInvoiceAcceptResultModel>>
      acceptFinalApprovalInvoices(
    BulkInvoiceAcceptParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AidServiceEvaluation/BulkFinancialOperatorInvoiceAccept',
      data: request.toJson(),
    );
    return _bulkResponse(response.data);
  }

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>>
      getFinalApprovalInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarAmaliatFinalInvoice',
      data: request.toJson(),
    );
    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<BulkInvoiceAcceptResultModel>>
      acceptFinalCorrectionInvoices(
    BulkInvoiceAcceptParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AidServiceEvaluation/BulkDefiniteInvoiceAccept',
      data: request.toJson(),
    );
    return _bulkResponse(response.data);
  }

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>>
      getFinalCorrectionInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarFinalInvoice',
      data: request.toJson(),
    );
    return _pageResponse(response.data);
  }

  Future<BaseSingleResponse<EmdadgarInvoicePageModel>> getDefiniteInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarDefiniteInvoice',
      data: request.toJson(),
    );
    return _pageResponse(response.data);
  }

  BaseSingleResponse<EmdadgarInvoicePageModel> _pageResponse(dynamic raw) {
    final resultCode = ResponseJsonReader.resultCode(raw);
    return BaseSingleResponse<EmdadgarInvoicePageModel>(
      resultCode: resultCode,
      data: resultCode == 0 ? EmdadgarInvoicePageModel.fromResponse(raw) : null,
      failures: ResponseJsonReader.failures(raw),
    );
  }

  BaseSingleResponse<BulkInvoiceAcceptResultModel> _bulkResponse(dynamic raw) {
    final resultCode = ResponseJsonReader.resultCode(raw);
    return BaseSingleResponse<BulkInvoiceAcceptResultModel>(
      resultCode: resultCode,
      data: resultCode == 0
          ? BulkInvoiceAcceptResultModel.fromResponse(raw)
          : null,
      failures: ResponseJsonReader.failures(raw),
    );
  }
}
