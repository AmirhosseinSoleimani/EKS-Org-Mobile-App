import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/car_info_entity.dart';

class CarInfoModel extends CarInfoEntity {
  const CarInfoModel({
    super.carFactoryId,
    super.carFactoryTitle,
    super.carGroupId,
    super.carGroupTitle,
    super.carModelId,
    super.chassisNo,
    super.colorId,
    super.coverCarId,
    super.engineNumber,
    super.guid,
    super.hasSubscription,
    super.isSaipa,
    super.licensePlateNo,
    super.name,
    super.productionYear,
    super.reliable,
    super.vehicleUsageId,
    super.vehicleUsageTitle,
    super.vin,
  });

  factory CarInfoModel.fromJson(Map<String, dynamic> json) {
    return CarInfoModel(
      guid: json['guid'],
      name: json['name'],
      productionYear: json['productionYear'],
      licensePlateNo: json['licensePlateNo'],
      chassisNo: json['chassisNo'],
      vin: json['vin'],
      coverCarId: json['coverCarId'],
      carModelId: json['carModelId'],
      hasSubscription: json['hasSubscription'],
      colorId: json['colorId'],
      engineNumber: json['engineNumber'],
      isSaipa: json['isSaipa'],
      reliable: json['reliable'],
      carFactoryId: json['carFactory'],
      carFactoryTitle: json['carFactoryTitle'],
      vehicleUsageId: json['vehicleUsageId'],
      vehicleUsageTitle: json['vehicleUsageTitle'],
      carGroupId: json['carGroupId'],
      carGroupTitle: json['carGroupTitle'],
    );
  }

  Map<String, dynamic> toJson() => {
    'guid': guid,
    'name': name,
    'productionYear': productionYear,
    'licensePlateNo': licensePlateNo,
    'chassisNo': chassisNo,
    'vin': vin,
    'coverCarId': coverCarId,
    'carModelId': carModelId,
    'hasSubscription': hasSubscription,
    'colorId': colorId,
    'engineNumber': engineNumber,
    'isSaipa': isSaipa,
    'reliable': reliable,
    'carFactory': carFactoryId,
    'carFactoryTitle': carFactoryTitle,
    'vehicleUsageId': vehicleUsageId,
    'vehicleUsageTitle': vehicleUsageTitle,
    'carGroupId': carGroupId,
    'carGroupTitle': carGroupTitle,
  };
}
