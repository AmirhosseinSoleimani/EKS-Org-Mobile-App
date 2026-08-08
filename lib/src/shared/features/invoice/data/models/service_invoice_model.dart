import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/service_invoice_entity.dart';

class ServiceInvoiceModel extends ServiceInvoiceEntity {
  ServiceInvoiceModel({
    super.title,
    super.serviceReception,
  });

  factory ServiceInvoiceModel.fromJson(Map<String, dynamic> json) {
    final receptions =
        json['serviceReception'] ?? json['optionServiceReception'];
    return ServiceInvoiceModel(
      title: json['title']?.toString(),
      serviceReception: (receptions as List?)
          ?.whereType<Map>()
          .map(
            (item) => ServiceReceptionModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
    );
  }
}

class ServiceReceptionModel extends ServiceReceptionEntity {
  ServiceReceptionModel({
    super.invoiceId,
    super.serviceId,
    super.serviceTitle,
    super.serviceCategoryId,
    super.serviceCategoryTitle,
    super.serviceCategoryCode,
    super.serviceCode,
    super.serviceType,
    super.serviceTypeTitle,
  });

  factory ServiceReceptionModel.fromJson(Map<String, dynamic> json) {
    return ServiceReceptionModel(
      invoiceId: (json['invoiceId'] as num?)?.toInt(),
      serviceId: (json['serviceId'] as num?)?.toInt(),
      serviceTitle: json['serviceTitle']?.toString(),
      serviceCategoryId: (json['serviceCategoryId'] as num?)?.toInt(),
      serviceCategoryTitle: json['serviceCategoryTitle']?.toString(),
      serviceCategoryCode: json['serviceCategoryCode']?.toString(),
      serviceCode: json['serviceCode']?.toString(),
      serviceType: (json['serviceType'] as num?)?.toInt(),
      serviceTypeTitle: json['serviceTypeTitle']?.toString(),
    );
  }
}
