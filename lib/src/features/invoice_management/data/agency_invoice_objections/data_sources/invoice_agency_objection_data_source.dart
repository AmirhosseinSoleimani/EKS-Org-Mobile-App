import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/emdadgar_assignment_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_compact_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_operation_access_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_param_model.dart';

abstract class InvoiceAgencyObjectionDataSource {
  Future<EmdadgarAssignmentModel?> getEmdadgar(
    ServiceRequestParamModel request,
  );

  Future<InvoiceAgencyObjectionModel> getObjection(
    ServiceRequestParamModel request,
  );

  Future<ServiceRequestCompactModel?> getServiceRequest(int serviceRequestId);

  Future<ServiceRequestOperationAccessModel> getOperationAccess();
}
