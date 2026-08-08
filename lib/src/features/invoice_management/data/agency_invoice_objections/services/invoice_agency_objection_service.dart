import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/emdadgar_assignment_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_compact_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InvoiceAgencyObjectionService {
  const InvoiceAgencyObjectionService(this._dio);

  final Dio _dio;

  Future<EmdadgarAssignmentModel?> getEmdadgar(
    ServiceRequestParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/NewEmdadgar/GetEmdadgarByServiceRequestId',
      data: request.toJson(),
    );
    final data = ResponseJsonReader.object(response.data);
    return data.isEmpty ? null : EmdadgarAssignmentModel.fromJson(data);
  }

  Future<InvoiceAgencyObjectionModel> getObjection(
    ServiceRequestParamModel request,
  ) async {
    final response = await _dio.post<dynamic>(
      '/api/InvoiceAgencyObjection/GetInvoiceAgencyObjectionByServiceRequestId',
      data: request.toJson(),
    );
    return InvoiceAgencyObjectionModel.fromJson(
      ResponseJsonReader.object(response.data),
    );
  }

  Future<ServiceRequestCompactModel?> getServiceRequest(
    int serviceRequestId,
  ) async {
    final response = await _dio.get<dynamic>(
      '/api/AidServiceRequest/GetServiceRequestCompactById',
      queryParameters: <String, dynamic>{
        'serviceRequestId': serviceRequestId,
      },
    );
    final data = ResponseJsonReader.object(response.data);
    return data.isEmpty ? null : ServiceRequestCompactModel.fromJson(data);
  }

  Future<ServiceRequestOperationAccessModel> getOperationAccess() async {
    final response = await _dio.get<dynamic>(
      '/api/AidServiceRequest/GetServiceRequestOperationAccess',
    );
    return ServiceRequestOperationAccessModel.fromJson(
      ResponseJsonReader.object(response.data),
    );
  }
}
