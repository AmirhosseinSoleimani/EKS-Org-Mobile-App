import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/data_sources/invoice_agency_objection_data_source.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/emdadgar_assignment_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_page_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_compact_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/services/invoice_agency_objection_service.dart';
import 'package:injectable/injectable.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

@LazySingleton(as: InvoiceAgencyObjectionDataSource)
class InvoiceAgencyObjectionDataSourceImpl
    implements InvoiceAgencyObjectionDataSource {
  const InvoiceAgencyObjectionDataSourceImpl(this._service);

  final InvoiceAgencyObjectionService _service;

  @override
  Future<BaseSingleResponse<InvoiceAgencyObjectionPageModel>> getObjections(
    InvoiceAgencyObjectionFilterParamModel request,
  ) => _service.getObjections(request);

  @override
  Future<BaseSingleResponse<EmdadgarAssignmentModel?>> getEmdadgar(
    ServiceRequestParamModel request,
  ) => _service.getEmdadgar(request);

  @override
  Future<BaseSingleResponse<InvoiceAgencyObjectionModel>> getObjection(
    ServiceRequestParamModel request,
  ) => _service.getObjection(request);

  @override
  Future<BaseSingleResponse<ServiceRequestCompactModel?>> getServiceRequest(
    ServiceRequestParamModel request,
  ) => _service.getServiceRequest(request);

  @override
  Future<BaseSingleResponse<ServiceRequestOperationAccessModel>> getOperationAccess() =>
      _service.getOperationAccess();
}
