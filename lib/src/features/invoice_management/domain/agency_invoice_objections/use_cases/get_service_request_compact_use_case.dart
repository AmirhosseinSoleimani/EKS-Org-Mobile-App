import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_compact_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/repositories/invoice_agency_objection_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetServiceRequestCompactUseCase {
  const GetServiceRequestCompactUseCase(this._repository);

  final InvoiceAgencyObjectionRepository _repository;

  Future<ApiResult<ServiceRequestCompactEntity?>> call(
    ServiceRequestParamEntity param,
  ) {
    return _repository.getServiceRequest(param);
  }
}
