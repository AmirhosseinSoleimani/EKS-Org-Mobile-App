import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_record_page_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CustomerInvoiceService {
  const CustomerInvoiceService(this._dio);

  final Dio _dio;

  Future<InvoiceRecordPageModel> getPreInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportCustomerPreInvoice',
      data: request.toJson(),
    );
    return InvoiceRecordPageModel.fromResponse(response.data);
  }

  Future<InvoiceRecordPageModel> getInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportCustomerInvoice',
      data: request.toJson(),
    );
    return InvoiceRecordPageModel.fromResponse(response.data);
  }

  Future<BaseSingleResponse<InvoiceModel?>> getDetails(
    InvoiceDetailsRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/CustomerInvoice',
      data: request.toJson(),
    );
    return _invoiceResponse(response.data);
  }

  Future<BaseSingleResponse<String>> finalizeInvoice(
    InvoiceDetailsRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/AidServiceEvaluation/EvaluationAccept',
      data: request.toJson(),
    );
    return BaseSingleResponse<String>(
      resultCode: ResponseJsonReader.resultCode(response.data),
      data: ResponseJsonReader.unwrapData(response.data)?.toString() ?? '',
      failures: ResponseJsonReader.failures(response.data),
    );
  }

  BaseSingleResponse<InvoiceModel?> _invoiceResponse(dynamic raw) {
    final data = ResponseJsonReader.object(raw);
    return BaseSingleResponse<InvoiceModel?>(
      resultCode: ResponseJsonReader.resultCode(raw),
      data: data.isEmpty ? null : InvoiceModel.fromJson(data),
      failures: ResponseJsonReader.failures(raw),
    );
  }
}
