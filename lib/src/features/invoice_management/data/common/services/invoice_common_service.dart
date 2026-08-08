import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_document_urls_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InvoiceCommonService {
  const InvoiceCommonService(this._dio);

  final Dio _dio;

  Future<InvoiceOperationAccessModel> getOperationAccess() async {
    final response = await _dio.get<dynamic>(
      '/api/Invoice/GetInvoiceOperationAccess',
    );
    return InvoiceOperationAccessModel.fromJson(
      ResponseJsonReader.object(response.data),
    );
  }

  Future<List<EmdadServiceCategoryModel>> getEmdadCategories() async {
    final response = await _dio.get<dynamic>(
      '/api/EmdadServiceCategoryBase/GetEmdadCategories',
    );
    return ResponseJsonReader.records(response.data)
        .map(EmdadServiceCategoryModel.fromJson)
        .toList();
  }

  Future<InvoiceDocumentUrlsModel> getCustomerDocumentUrls(
    String invoiceGuid,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/Invoice/GetCustomerInvoiceDocumentUrlsByInvoiceGuid',
      queryParameters: <String, dynamic>{'invoiceGuid': invoiceGuid},
    );
    return InvoiceDocumentUrlsModel.fromJson(
      ResponseJsonReader.object(response.data),
    );
  }

  Future<InvoiceDocumentUrlsModel> getEmdadgarDocumentUrls(
    String invoiceGuid,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/Invoice/GetEmdadgarInvoiceDocumentUrlsByInvoiceGuid',
      queryParameters: <String, dynamic>{'invoiceGuid': invoiceGuid},
    );
    return InvoiceDocumentUrlsModel.fromJson(
      ResponseJsonReader.object(response.data),
    );
  }
}
