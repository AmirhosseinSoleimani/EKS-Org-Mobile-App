import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/emdad_service_category_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_document_urls_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InvoiceCommonService {
  const InvoiceCommonService(this._dio);

  final Dio _dio;

  Future<BaseSingleResponse<InvoiceOperationAccessModel>> getOperationAccess() async {
    final response = await _dio.get<dynamic>(
      '/api/Invoice/GetInvoiceOperationAccess',
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    return BaseSingleResponse<InvoiceOperationAccessModel>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0
          ? InvoiceOperationAccessModel.fromJson(
              ResponseJsonReader.object(response.data),
            )
          : null,
    );
  }

  Future<BaseListResponse<EmdadServiceCategoryModel>> getEmdadCategories() async {
    final response = await _dio.get<dynamic>(
      '/api/EmdadServiceCategoryBase/GetEmdadCategories',
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    return BaseListResponse<EmdadServiceCategoryModel>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0
          ? ResponseJsonReader.records(response.data)
              .map(EmdadServiceCategoryModel.fromJson)
              .toList()
          : null,
    );
  }

  Future<BaseSingleResponse<InvoiceDocumentUrlsModel>> getCustomerDocumentUrls(
    String invoiceGuid,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/Invoice/GetCustomerInvoiceDocumentUrlsByInvoiceGuid',
      queryParameters: <String, dynamic>{'invoiceGuid': invoiceGuid},
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    return BaseSingleResponse<InvoiceDocumentUrlsModel>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0
          ? InvoiceDocumentUrlsModel.fromJson(
              ResponseJsonReader.object(response.data),
            )
          : null,
    );
  }

  Future<BaseSingleResponse<InvoiceDocumentUrlsModel>> getEmdadgarDocumentUrls(
    String invoiceGuid,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/Invoice/GetEmdadgarInvoiceDocumentUrlsByInvoiceGuid',
      queryParameters: <String, dynamic>{'invoiceGuid': invoiceGuid},
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    return BaseSingleResponse<InvoiceDocumentUrlsModel>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0
          ? InvoiceDocumentUrlsModel.fromJson(
              ResponseJsonReader.object(response.data),
            )
          : null,
    );
  }

}
