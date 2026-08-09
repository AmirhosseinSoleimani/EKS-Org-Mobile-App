import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';

class InvoiceRequestContext {
  const InvoiceRequestContext({
    required this.requestId,
    required this.serviceType,
    this.requestStatusTitle,
    this.isGuaranty = false,
    this.isSubscription = false,
  });

  final int? requestId;
  final ServiceType? serviceType;
  final String? requestStatusTitle;
  final bool isGuaranty;
  final bool isSubscription;
}

abstract class InvoiceRequestContextLoader {
  Future<InvoiceRequestContext?> loadCached();

  Future<InvoiceRequestContext?> refresh(InvoiceRequestContext current);
}
