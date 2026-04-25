
import 'package:eks_sana_plus_org/src/features/services/data/models/subscription_info_model.dart';

class SubscriptionInfoEntity {
  const SubscriptionInfoEntity({
    this.carModelId,
    this.productId,
    this.code,
    this.carName,
    this.productionYear,
    this.licensePlateNo,
    this.chassisNo,
    this.vin,
    this.colorId,
    this.engineNumber,
    this.nationalCode,
    this.firstName,
    this.lastName,
    this.address,
    this.mobileNumber,
    this.discountId,
    this.fromDate,
    this.toDate,
    this.saleProductId,
    this.saleProductTitle,
    this.fromKilometer,
    this.toKilometer,
    this.agencyCode,
    this.authorType,
    this.isDeleted = false,
    this.productTitle,
    this.productServiceType,
    this.productRequiredSubscription,
    this.isInverse = false,
    this.inverseText,
    this.inverseDateTime,
    this.isNullification = false,
    this.nullificationText,
    this.nullificationDateTime,
    this.factorNo,
    this.checkStatusBasedDateTime,
    this.emdadPackageId,
    this.emdadPackageCode,
    this.emdadServiceId,
    this.emdadServiceCode,
    this.description,
    this.isActiveTitle,
    this.isActive,
    this.status,
    this.statusTitle,
  });

  final int? carModelId;
  final int? productId;
  final int? code;
  final String? carName;
  final int? productionYear;
  final String? licensePlateNo;
  final String? chassisNo;
  final String? vin;
  final int? colorId;
  final String? engineNumber;
  final String? nationalCode;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? mobileNumber;
  final int? discountId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? saleProductId;
  final String? saleProductTitle;
  final int? fromKilometer;
  final int? toKilometer;
  final String? agencyCode;
  final int? authorType;
  final bool isDeleted;
  final String? productTitle;
  final int? productServiceType;
  final bool? productRequiredSubscription;
  final bool? isInverse;
  final String? inverseText;
  final DateTime? inverseDateTime;
  final bool? isNullification;
  final String? nullificationText;
  final DateTime? nullificationDateTime;
  final int? factorNo;
  final DateTime? checkStatusBasedDateTime;
  final int? emdadPackageId;
  final String? emdadPackageCode;
  final int? emdadServiceId;
  final String? emdadServiceCode;
  final String? description;
  final String? isActiveTitle;
  final bool? isActive;
  final int? status;
  final String? statusTitle;


  SubscriptionInfoEntity copyWith({
    int? carModelId,
    int? productId,
    int? code,
    String? carName,
    int? productionYear,
    String? licensePlateNo,
    String? chassisNo,
    String? vin,
    int? colorId,
    String? engineNumber,
    String? nationalCode,
    String? firstName,
    String? lastName,
    String? address,
    String? mobileNumber,
    int? discountId,
    DateTime? fromDate,
    DateTime? toDate,
    int? saleProductId,
    String? saleProductTitle,
    int? fromKilometer,
    int? toKilometer,
    String? agencyCode,
    int? authorType,
    bool? isDeleted,
    String? productTitle,
    int? productServiceType,
    bool? productRequiredSubscription,
    bool? isInverse,
    String? inverseText,
    DateTime? inverseDateTime,
    bool? isNullification,
    String? nullificationText,
    DateTime? nullificationDateTime,
    int? factorNo,
    DateTime? checkStatusBasedDateTime,
    int? emdadPackageId,
    String? emdadPackageCode,
    int? emdadServiceId,
    String? emdadServiceCode,
    String? description,
    String? isActiveTitle,
    bool? isActive,
    int? status,
    String? statusTitle,
  }) {
    return SubscriptionInfoEntity(
      carModelId: carModelId ?? this.carModelId,
      productId: productId ?? this.productId,
      code: code ?? this.code,
      carName: carName ?? this.carName,
      productionYear: productionYear ?? this.productionYear,
      licensePlateNo: licensePlateNo ?? this.licensePlateNo,
      chassisNo: chassisNo ?? this.chassisNo,
      vin: vin ?? this.vin,
      colorId: colorId ?? this.colorId,
      engineNumber: engineNumber ?? this.engineNumber,
      nationalCode: nationalCode ?? this.nationalCode,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      discountId: discountId ?? this.discountId,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      saleProductId: saleProductId ?? this.saleProductId,
      saleProductTitle: saleProductTitle ?? this.saleProductTitle,
      fromKilometer: fromKilometer ?? this.fromKilometer,
      toKilometer: toKilometer ?? this.toKilometer,
      agencyCode: agencyCode ?? this.agencyCode,
      authorType: authorType ?? this.authorType,
      isDeleted: isDeleted ?? this.isDeleted,
      productTitle: productTitle ?? this.productTitle,
      productServiceType: productServiceType ?? this.productServiceType,
      productRequiredSubscription:
      productRequiredSubscription ?? this.productRequiredSubscription,
      isInverse: isInverse ?? this.isInverse,
      inverseText: inverseText ?? this.inverseText,
      inverseDateTime: inverseDateTime ?? this.inverseDateTime,
      isNullification: isNullification ?? this.isNullification,
      nullificationText: nullificationText ?? this.nullificationText,
      nullificationDateTime:
      nullificationDateTime ?? this.nullificationDateTime,
      factorNo: factorNo ?? this.factorNo,
      checkStatusBasedDateTime:
      checkStatusBasedDateTime ?? this.checkStatusBasedDateTime,
      emdadPackageId: emdadPackageId ?? this.emdadPackageId,
      emdadPackageCode: emdadPackageCode ?? this.emdadPackageCode,
      emdadServiceId: emdadServiceId ?? this.emdadServiceId,
      emdadServiceCode: emdadServiceCode ?? this.emdadServiceCode,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      isActiveTitle: isActiveTitle ?? this.isActiveTitle,
      status: status ?? this.status,
      statusTitle: statusTitle ?? this.statusTitle,

    );
  }

  SubscriptionInfoModel toModel() {
    return SubscriptionInfoModel(
      carModelId: carModelId,
      productId: productId,
      code: code,
      carName: carName,
      productionYear: productionYear,
      licensePlateNo: licensePlateNo,
      chassisNo: chassisNo,
      vin: vin,
      colorId: colorId,
      engineNumber: engineNumber,
      nationalCode: nationalCode,
      firstName: firstName,
      lastName: lastName,
      address: address,
      mobileNumber: mobileNumber,
      discountId: discountId,
      fromDate: fromDate,
      toDate: toDate,
      saleProductId: saleProductId,
      saleProductTitle: saleProductTitle,
      fromKilometer: fromKilometer,
      toKilometer: toKilometer,
      agencyCode: agencyCode,
      authorType: authorType,
      isDeleted: isDeleted,
      productTitle: productTitle,
      productServiceType: productServiceType,
      productRequiredSubscription: productRequiredSubscription,
      isInverse: isInverse,
      inverseText: inverseText,
      inverseDateTime: inverseDateTime,
      isNullification: isNullification,
      nullificationText: nullificationText,
      nullificationDateTime: nullificationDateTime,
      factorNo: factorNo,
      checkStatusBasedDateTime: checkStatusBasedDateTime,
      emdadPackageId: emdadPackageId,
      emdadPackageCode: emdadPackageCode,
      emdadServiceId: emdadServiceId,
      emdadServiceCode: emdadServiceCode,
      description: description,
      isActive: isActive,
      isActiveTitle: isActiveTitle,
      status: status,
      statusTitle: statusTitle,
    );
  }
}