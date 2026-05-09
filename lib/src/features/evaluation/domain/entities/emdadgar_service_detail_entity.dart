import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdadgar_service_detail_model.dart';

class EmdadgarServiceDetailEntity {
  final int? serviceType;
  final String? serviceTypeTitle;

  final int? serviceCategoryId;
  final String? serviceCategoryCode;
  final String? serviceCategoryTitle;

  final int? serviceId;
  final String? serviceCode;
  final String? serviceTitle;

  final bool? hasSubscription;
  final bool? hasGaranty;
  final String? garantyStartDate;

  final bool? isSubscribedByNationalCode;
  final bool? isImageMadatory;
  final bool? needImage;

  const EmdadgarServiceDetailEntity({
    this.serviceType,
    this.serviceTypeTitle,
    this.serviceCategoryId,
    this.serviceCategoryCode,
    this.serviceCategoryTitle,
    this.serviceId,
    this.serviceCode,
    this.serviceTitle,
    this.hasSubscription,
    this.hasGaranty,
    this.garantyStartDate,
    this.isSubscribedByNationalCode,
    this.isImageMadatory,
    this.needImage,
  });

  EmdadgarServiceDetailEntity copyWith({
    int? serviceType,
    String? serviceTypeTitle,
    int? serviceCategoryId,
    String? serviceCategoryCode,
    String? serviceCategoryTitle,
    int? serviceId,
    String? serviceCode,
    String? serviceTitle,
    bool? hasSubscription,
    bool? hasGaranty,
    String? garantyStartDate,
    bool? isSubscribedByNationalCode,
    bool? isImageMadatory,
    bool? needImage,
  }) {
    return EmdadgarServiceDetailEntity(
      serviceType: serviceType ?? this.serviceType,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceCategoryCode: serviceCategoryCode ?? this.serviceCategoryCode,
      serviceCategoryTitle:
      serviceCategoryTitle ?? this.serviceCategoryTitle,
      serviceId: serviceId ?? this.serviceId,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      hasGaranty: hasGaranty ?? this.hasGaranty,
      garantyStartDate: garantyStartDate ?? this.garantyStartDate,
      isSubscribedByNationalCode:
      isSubscribedByNationalCode ?? this.isSubscribedByNationalCode,
      isImageMadatory: isImageMadatory ?? this.isImageMadatory,
      needImage: needImage ?? this.needImage,
    );
  }

  EmdadgarServiceDetailModel toModel() =>
      EmdadgarServiceDetailModel.fromEntity(this);
}
