import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/service_invoice_entity.dart';

class ServiceInvoiceModel extends ServiceInvoiceEntity {
  ServiceInvoiceModel({
    super.title,
    super.serviceReception,
  });

  factory ServiceInvoiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceInvoiceModel(
      title: json['title'],
      serviceReception: json['serviceReception'] != null
          ? (json['serviceReception'] as List)
              .map((e) => ServiceReceptionModel.fromJson(e))
              .toList()
          : null,
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
      invoiceId: json['invoiceId'],
      serviceId: json['serviceId'],
      serviceTitle: json['serviceTitle'],
      serviceCategoryId: json['serviceCategoryId'],
      serviceCategoryTitle: json['serviceCategoryTitle'],
      serviceCategoryCode: json['serviceCategoryCode'],
      serviceCode: json['serviceCode'],
      serviceType: json['serviceType'],
      serviceTypeTitle: json['serviceTypeTitle'],
    );
  }
}
