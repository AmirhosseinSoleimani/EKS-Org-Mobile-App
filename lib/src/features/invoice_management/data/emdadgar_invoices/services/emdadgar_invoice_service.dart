import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_details_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_page_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/invoice_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EmdadgarInvoiceService {
  const EmdadgarInvoiceService(this._dio);

  final Dio _dio;

  Future<EmdadgarInvoicePageModel> getInitialInvoices(
    InvoiceListFilterRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/ReportEmdadgarPreInvoice',
      data: request.toJson(),
    );
    return EmdadgarInvoicePageModel.fromResponse(response.data);
  }

  Future<BaseSingleResponse<InvoiceModel?>> getInitialInvoiceDetails(
    InvoiceDetailsRequestModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/Invoice/EmdadgarPreInvoice',
      data: request.toJson(),
    );
    final data = ResponseJsonReader.object(response.data);
    return BaseSingleResponse<InvoiceModel?>(
      resultCode: ResponseJsonReader.resultCode(response.data),
      data: data.isEmpty ? null : InvoiceModel.fromJson(data),
      failures: ResponseJsonReader.failures(response.data),
    );
  }
}
