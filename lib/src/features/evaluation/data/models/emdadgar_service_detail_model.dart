import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';

class EmdadgarServiceDetailModel extends EmdadgarServiceDetailEntity {
  const EmdadgarServiceDetailModel({
    super.serviceType,
    super.serviceTypeId,
    super.serviceTypeTitle,
    super.serviceCategoryId,
    super.serviceCategoryCode,
    super.serviceCategoryTitle,
    super.serviceId,
    super.serviceCode,
    super.serviceTitle,
    super.hasSubscription,
    super.hasGaranty,
    super.garantyStartDate,
    super.isSubscribedByNationalCode,
    super.isImageMadatory,
    super.needImage,
    super.defectInfoId,
  });

  factory EmdadgarServiceDetailModel.fromEntity(
      EmdadgarServiceDetailEntity entity) {
    return EmdadgarServiceDetailModel(
      serviceType: entity.serviceType,
      serviceTypeId: entity.serviceTypeId,
      serviceTypeTitle: entity.serviceTypeTitle,
      serviceCategoryId: entity.serviceCategoryId,
      serviceCategoryCode: entity.serviceCategoryCode,
      serviceCategoryTitle: entity.serviceCategoryTitle,
      serviceId: entity.serviceId,
      serviceCode: entity.serviceCode,
      serviceTitle: entity.serviceTitle,
      hasSubscription: entity.hasSubscription,
      hasGaranty: entity.hasGaranty,
      garantyStartDate: entity.garantyStartDate,
      isSubscribedByNationalCode: entity.isSubscribedByNationalCode,
      isImageMadatory: entity.isImageMadatory,
      needImage: entity.needImage,
    );
  }

  factory EmdadgarServiceDetailModel.fromJson(
      Map<String, dynamic> json) {
    return EmdadgarServiceDetailModel(
      serviceType: json["serviceType"],
      serviceTypeId: json["serviceTypeId"],
      serviceTypeTitle: json["serviceTypeTitle"],
      serviceCategoryId: json["serviceCategoryId"],
      serviceCategoryCode: json["serviceCategoryCode"],
      serviceCategoryTitle: json["serviceCategoryTitle"],
      serviceId: json["serviceId"],
      serviceCode: json["serviceCode"],
      serviceTitle: json["serviceTitle"],
      hasSubscription: json["hasSubscription"],
      hasGaranty: json["hasGaranty"],
      garantyStartDate: json["garantyStartDate"],
      isSubscribedByNationalCode: json["isSubscribedByNationalCode"],
      isImageMadatory: json["isImageMadatory"],
      needImage: json["needImage"],
      defectInfoId: json["defectInfoId"],
    );
  }
}
