import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/repositories/invoice_agency_objection_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetServiceRequestOperationAccessUseCase {
  const GetServiceRequestOperationAccessUseCase(this._repository);

  final InvoiceAgencyObjectionRepository _repository;

  Future<ApiResult<ServiceRequestOperationAccessEntity>> call() {
    return _repository.getOperationAccess();
  }
}
