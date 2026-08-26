import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
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
    super.productId,
    super.productTitle,
    super.subscriptionId,
    super.isSubscribedByNationalCode,
    super.isImageMadatory,
    super.needImage,
    super.defectInfoId,
    super.defectInfoProblemOrEzharCode,
    super.defectInfoTitle,
    super.limitationDescription,
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
      productId: entity.productId,
      productTitle: entity.productTitle,
      subscriptionId: entity.subscriptionId,
      isSubscribedByNationalCode: entity.isSubscribedByNationalCode,
      isImageMadatory: entity.isImageMadatory,
      needImage: entity.needImage,
      limitationDescription: entity.limitationDescription,
      defectInfoId: entity.defectInfoId,
      defectInfoTitle: entity.defectInfoTitle,
      defectInfoProblemOrEzharCode: entity.defectInfoProblemOrEzharCode,
    );
  }

  factory EmdadgarServiceDetailModel.fromJson(
      Map<String, dynamic> json) {
    return EmdadgarServiceDetailModel(
      serviceType: ServiceType.fromValue(json["serviceType"]),
      serviceTypeId: json["serviceTypeId"] ?? json["serviceType"],
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
      productId: json["productId"],
      productTitle: json["productTitle"],
      subscriptionId: json["subscriptionId"],
      isSubscribedByNationalCode: json["isSubscribedByNationalCode"],
      isImageMadatory: json["isImageMadatory"],
      needImage: json["needImage"],
      defectInfoId: json["defectInfoId"],
      limitationDescription: json['limitationDescription'],
      defectInfoProblemOrEzharCode: json['defectInfoProblemOrEzharCode'],
      defectInfoTitle: json['defectInfoTitle'],
    );
  }
}
