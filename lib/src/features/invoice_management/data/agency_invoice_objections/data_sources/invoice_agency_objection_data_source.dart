import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/emdadgar_assignment_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_page_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_compact_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_param_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class InvoiceAgencyObjectionDataSource {
  Future<BaseSingleResponse<InvoiceAgencyObjectionPageModel>> getObjections(
    InvoiceAgencyObjectionFilterParamModel request,
  );

  Future<BaseSingleResponse<EmdadgarAssignmentModel?>> getEmdadgar(
    ServiceRequestParamModel request,
  );

  Future<BaseSingleResponse<InvoiceAgencyObjectionModel>> getObjection(
    ServiceRequestParamModel request,
  );

  Future<BaseSingleResponse<ServiceRequestCompactModel?>> getServiceRequest(
    ServiceRequestParamModel request,
  );

  Future<BaseSingleResponse<ServiceRequestOperationAccessModel>> getOperationAccess();
}
