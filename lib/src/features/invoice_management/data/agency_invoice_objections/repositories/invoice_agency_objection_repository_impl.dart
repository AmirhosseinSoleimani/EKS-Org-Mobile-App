import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/data_sources/invoice_agency_objection_data_source.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/emdadgar_assignment_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/params/invoice_agency_objection_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_compact_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/repositories/invoice_agency_objection_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InvoiceAgencyObjectionRepository)
class InvoiceAgencyObjectionRepositoryImpl
    implements InvoiceAgencyObjectionRepository {
  const InvoiceAgencyObjectionRepositoryImpl(this._dataSource);

  final InvoiceAgencyObjectionDataSource _dataSource;

  @override
  Future<ApiResult<InvoiceAgencyObjectionPageEntity>> getObjections(
    InvoiceAgencyObjectionFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getObjections(param.toModel());
      return result.toApiResult<InvoiceAgencyObjectionPageEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<EmdadgarAssignmentEntity?>> getEmdadgar(
    ServiceRequestParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getEmdadgar(param.toModel());
      return result.toApiResult<EmdadgarAssignmentEntity?>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<InvoiceAgencyObjectionEntity>> getObjection(
    ServiceRequestParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getObjection(param.toModel());
      return result.toApiResult<InvoiceAgencyObjectionEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<ServiceRequestCompactEntity?>> getServiceRequest(
    ServiceRequestParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getServiceRequest(param.toModel());
      return result.toApiResult<ServiceRequestCompactEntity?>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<ServiceRequestOperationAccessEntity>> getOperationAccess() async {
    try {
      final result = await _dataSource.getOperationAccess();
      return result.toApiResult<ServiceRequestOperationAccessEntity>();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
