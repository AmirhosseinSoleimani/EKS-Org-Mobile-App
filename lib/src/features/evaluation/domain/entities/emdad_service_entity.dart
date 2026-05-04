import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdad_service_model.dart';

class EmdadServiceEntity {
  final int serviceType;
  final String serviceTypeTitle;
  final int serviceCategoryId;
  final String serviceCategoryCode;
  final String serviceCategoryTitle;
  final int serviceId;
  final String serviceCode;
  final String serviceTitle;
  final int serviceFromKilometer;
  final int serviceToKilometer;
  final bool isSelectable;
  final String workOrderCode;
  final bool isSubscribedByNationalCode;
  final bool isImageMandatory;

  const EmdadServiceEntity({
    required this.serviceType,
    required this.serviceTypeTitle,
    required this.serviceCategoryId,
    required this.serviceCategoryCode,
    required this.serviceCategoryTitle,
    required this.serviceId,
    required this.serviceCode,
    required this.serviceTitle,
    required this.serviceFromKilometer,
    required this.serviceToKilometer,
    required this.isSelectable,
    required this.workOrderCode,
    required this.isSubscribedByNationalCode,
    required this.isImageMandatory,
  });

  EmdadServiceEntity copyWith({
    int? serviceType,
    String? serviceTypeTitle,
    int? serviceCategoryId,
    String? serviceCategoryCode,
    String? serviceCategoryTitle,
    int? serviceId,
    String? serviceCode,
    String? serviceTitle,
    int? serviceFromKilometer,
    int? serviceToKilometer,
    bool? isSelectable,
    String? workOrderCode,
    bool? isSubscribedByNationalCode,
    bool? isImageMandatory,
  }) {
    return EmdadServiceEntity(
      serviceType: serviceType ?? this.serviceType,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceCategoryCode: serviceCategoryCode ?? this.serviceCategoryCode,
      serviceCategoryTitle: serviceCategoryTitle ?? this.serviceCategoryTitle,
      serviceId: serviceId ?? this.serviceId,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      serviceFromKilometer: serviceFromKilometer ?? this.serviceFromKilometer,
      serviceToKilometer: serviceToKilometer ?? this.serviceToKilometer,
      isSelectable: isSelectable ?? this.isSelectable,
      workOrderCode: workOrderCode ?? this.workOrderCode,
      isSubscribedByNationalCode:
          isSubscribedByNationalCode ?? this.isSubscribedByNationalCode,

      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }

  EmdadServiceModel toModel() => EmdadServiceModel(
    serviceType: serviceType,
    serviceTypeTitle: serviceTypeTitle,
    serviceCategoryId: serviceCategoryId,
    serviceCategoryCode: serviceCategoryCode,
    serviceCategoryTitle: serviceCategoryTitle,
    serviceId: serviceId,
    serviceCode: serviceCode,
    serviceTitle: serviceTitle,
    serviceFromKilometer: serviceFromKilometer,
    serviceToKilometer: serviceToKilometer,
    isSelectable: isSelectable,
    workOrderCode: workOrderCode,
    isSubscribedByNationalCode: isSubscribedByNationalCode,
    isImageMandatory: isImageMandatory,
  );
}
