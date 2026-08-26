import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/emdadgar_assignment_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_page_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_compact_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InvoiceAgencyObjectionService {
  const InvoiceAgencyObjectionService(this._dio);

  final Dio _dio;

  Future<BaseSingleResponse<InvoiceAgencyObjectionPageModel>> getObjections(
    InvoiceAgencyObjectionFilterParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/InvoiceAgencyObjection/GetByFilterJson',
      data: request.toJson(),
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    return BaseSingleResponse<InvoiceAgencyObjectionPageModel>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0
          ? InvoiceAgencyObjectionPageModel.fromResponse(response.data)
          : null,
    );
  }

  Future<BaseSingleResponse<EmdadgarAssignmentModel?>> getEmdadgar(
    ServiceRequestParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/NewEmdadgar/GetEmdadgarByServiceRequestId',
      data: request.toJson(),
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    final data = ResponseJsonReader.object(response.data);
    return BaseSingleResponse<EmdadgarAssignmentModel?>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0 && data.isNotEmpty
          ? EmdadgarAssignmentModel.fromJson(data)
          : null,
    );
  }

  Future<BaseSingleResponse<InvoiceAgencyObjectionModel>> getObjection(
    ServiceRequestParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/InvoiceAgencyObjection/GetInvoiceAgencyObjectionByServiceRequestId',
      data: request.toJson(),
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    return BaseSingleResponse<InvoiceAgencyObjectionModel>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0
          ? InvoiceAgencyObjectionModel.fromJson(
              ResponseJsonReader.object(response.data),
            )
          : null,
    );
  }

  Future<BaseSingleResponse<ServiceRequestCompactModel?>> getServiceRequest(
    ServiceRequestParamModel request,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/AidServiceRequest/GetServiceRequestCompactById',
      queryParameters: <String, dynamic>{
        'serviceRequestId': request.serviceRequestId,
      },
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    final data = ResponseJsonReader.object(response.data);
    return BaseSingleResponse<ServiceRequestCompactModel?>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0 && data.isNotEmpty
          ? ServiceRequestCompactModel.fromJson(data)
          : null,
    );
  }

  Future<BaseSingleResponse<ServiceRequestOperationAccessModel>> getOperationAccess() async {
    final response = await _dio.get<dynamic>(
      '/api/AidServiceRequest/GetServiceRequestOperationAccess',
    );
    final resultCode = ResponseJsonReader.resultCode(response.data);
    return BaseSingleResponse<ServiceRequestOperationAccessModel>(
      resultCode: resultCode,
      failures: ResponseJsonReader.failures(response.data),
      data: resultCode == 0
          ? ServiceRequestOperationAccessModel.fromJson(
              ResponseJsonReader.object(response.data),
            )
          : null,
    );
  }
}
