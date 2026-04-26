import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/service_invoice_model.dart';

class ServiceInvoiceEntity {
  final String? title;
  final List<ServiceReceptionEntity>? serviceReception;

  ServiceInvoiceEntity({
    this.title,
    this.serviceReception,
  });

  ServiceInvoiceEntity copyWith({
    String? title,
    List<ServiceReceptionEntity>? serviceReception,
  }) {
    return ServiceInvoiceEntity(
      title: title ?? this.title,
      serviceReception: serviceReception ?? this.serviceReception,
    );
  }

  ServiceInvoiceModel toModel() {
    return ServiceInvoiceModel(
      title: title,
      serviceReception:
      serviceReception?.map((e) => e.toModel()).toList(),
    );
  }
}

class ServiceReceptionEntity {
  final int? invoiceId;
  final int? serviceId;
  final String? serviceTitle;
  final int? serviceCategoryId;
  final String? serviceCategoryTitle;
  final String? serviceCategoryCode;
  final String? serviceCode;
  final int? serviceType;
  final String? serviceTypeTitle;

  ServiceReceptionEntity({
    this.invoiceId,
    this.serviceId,
    this.serviceTitle,
    this.serviceCategoryId,
    this.serviceCategoryTitle,
    this.serviceCategoryCode,
    this.serviceCode,
    this.serviceType,
    this.serviceTypeTitle,
  });

  ServiceReceptionEntity copyWith({
    int? invoiceId,
    int? serviceId,
    String? serviceTitle,
    int? serviceCategoryId,
    String? serviceCategoryTitle,
    String? serviceCategoryCode,
    String? serviceCode,
    int? serviceType,
    String? serviceTypeTitle,
  }) {
    return ServiceReceptionEntity(
      invoiceId: invoiceId ?? this.invoiceId,
      serviceId: serviceId ?? this.serviceId,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceCategoryTitle:
      serviceCategoryTitle ?? this.serviceCategoryTitle,
      serviceCategoryCode:
      serviceCategoryCode ?? this.serviceCategoryCode,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceType: serviceType ?? this.serviceType,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
    );
  }

  ServiceReceptionModel toModel() {
    return ServiceReceptionModel(
      invoiceId: invoiceId,
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      serviceCategoryId: serviceCategoryId,
      serviceCategoryTitle: serviceCategoryTitle,
      serviceCategoryCode: serviceCategoryCode,
      serviceCode: serviceCode,
      serviceType: serviceType,
      serviceTypeTitle: serviceTypeTitle,
    );
  }
}
