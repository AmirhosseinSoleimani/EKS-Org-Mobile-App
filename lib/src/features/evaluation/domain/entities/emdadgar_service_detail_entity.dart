import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdadgar_service_detail_model.dart';

class EmdadgarServiceDetailEntity {
  final ServiceType? serviceType;
  final int? serviceTypeId;
  final int? defectInfoId;
  final String? defectInfoTitle;
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
  final String? limitationDescription;
  final String? defectInfoProblemOrEzharCode;

  const EmdadgarServiceDetailEntity({
    this.defectInfoId,
    this.serviceType,
    this.serviceTypeId,
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
    this.defectInfoProblemOrEzharCode,
    this.defectInfoTitle,
    this.limitationDescription,
  });

  EmdadgarServiceDetailEntity copyWith({
    ServiceType? serviceType,
    int? serviceTypeId,
    int? defectInfoId,
    String? serviceTypeTitle,
    int? serviceCategoryId,
    String? serviceCategoryCode,
    String? serviceCategoryTitle,
    String? defectInfoProblemOrEzharCode,
    int? serviceId,
    String? serviceCode,
    String? serviceTitle,
    bool? hasSubscription,
    bool? hasGaranty,
    String? garantyStartDate,
    bool? isSubscribedByNationalCode,
    bool? isImageMadatory,
    bool? needImage,
    String? defectInfoTitle,
    String? limitationDescription,
  }) {
    return EmdadgarServiceDetailEntity(
      defectInfoId: defectInfoId ?? this.defectInfoId,
      serviceType: serviceType ?? this.serviceType,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
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
      defectInfoTitle: defectInfoTitle ?? this.defectInfoTitle,
      defectInfoProblemOrEzharCode: defectInfoProblemOrEzharCode ?? this.defectInfoProblemOrEzharCode,
      limitationDescription: limitationDescription ?? this.limitationDescription
    );
  }

  EmdadgarServiceDetailModel toModel() =>
      EmdadgarServiceDetailModel.fromEntity(this);
}
