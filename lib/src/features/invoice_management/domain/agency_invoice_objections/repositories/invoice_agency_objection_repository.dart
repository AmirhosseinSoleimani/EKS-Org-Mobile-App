import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/emdadgar_assignment_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_compact_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class InvoiceAgencyObjectionRepository {
  Future<ApiResult<EmdadgarAssignmentEntity?>> getEmdadgar(
    ServiceRequestParamEntity param,
  );

  Future<ApiResult<InvoiceAgencyObjectionEntity>> getObjection(
    ServiceRequestParamEntity param,
  );

  Future<ApiResult<ServiceRequestCompactEntity?>> getServiceRequest(
    int serviceRequestId,
  );

  Future<ApiResult<ServiceRequestOperationAccessEntity>> getOperationAccess();
}
