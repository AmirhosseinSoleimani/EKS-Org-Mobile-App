import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/presentation/invoice_request_context_loader.dart';

class ServiceInvoiceRequestContextLoader
    implements InvoiceRequestContextLoader {
  ServiceInvoiceRequestContextLoader(
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
  );

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;

  @override
  Future<InvoiceRequestContext?> loadCached() async {
    final selectedRequest = await _fetchSelectedRequestItemUseCase();
    return selectedRequest == null ? null : _map(selectedRequest);
  }

  @override
  Future<InvoiceRequestContext?> refresh(
    InvoiceRequestContext current,
  ) async {
    final id = current.requestId ?? 0;
    final result = current.serviceType == ServiceType.homeService
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    BaseRequestEntity? refreshed;
    result.whenOrNull(
      success: (data, failures, resultCode) {
        refreshed = data;
      },
    );

    return refreshed == null ? null : _map(refreshed!);
  }

  InvoiceRequestContext _map(BaseRequestEntity request) {
    return InvoiceRequestContext(
      requestId: request.id,
      serviceType: request.serviceType,
      requestStatusTitle: request.requestStatusTitle,
      isGuaranty: request.isGuaranty ?? false,
      isSubscription: request.isSubscription ?? false,
    );
  }
}

ServiceInvoiceRequestContextLoader createServiceInvoiceRequestContextLoader() {
  return ServiceInvoiceRequestContextLoader(
    getIt<FetchSelectedRequestItemUseCase>(),
    getIt<GetReliefRequestByIdUseCase>(),
    getIt<GetHomeServiceRequestByIdUseCase>(),
  );
}
