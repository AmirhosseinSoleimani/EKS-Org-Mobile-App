import 'package:eks_sana_plus_org/src/features/requests/domain/entities/car_entity.dart';

class CarModel extends CarEntity {
  CarModel({
    String? guid,
    String? name,
    int? productionYear,
    String? licensePlateNo,
    String? chassisNo,
    String? vin,
    int? coverCarId,
    int? carModelId,
    bool? hasSubscription,
    int? colorId,
    String? engineNumber,
    bool? isSaipa,
    bool? reliable,
    int? carFactoryId,
    String? carFactoryTitle,
    int? vehicleUsageId,
    String? vehicleUsageTitle,
    int? carGroupId,
    String? carGroupTitle,
  }) : super(
          guid: guid,
          name: name,
          productionYear: productionYear,
          licensePlateNo: licensePlateNo,
          chassisNo: chassisNo,
          vin: vin,
          coverCarId: coverCarId,
          carModelId: carModelId,
          hasSubscription: hasSubscription,
          colorId: colorId,
          engineNumber: engineNumber,
          isSaipa: isSaipa,
          reliable: reliable,
          carFactoryId: carFactoryId,
          carFactoryTitle: carFactoryTitle,
          vehicleUsageId: vehicleUsageId,
          vehicleUsageTitle: vehicleUsageTitle,
          carGroupId: carGroupId,
          carGroupTitle: carGroupTitle,
        );

  CarModel.fromJson(dynamic json) {
    guid = json['guid'];
    name = json['name'];
    productionYear = json['productionYear'];
    licensePlateNo = json['licensePlateNo'];
    chassisNo = json['chassisNo'];
    vin = json['vin'];
    coverCarId = json['coverCarId'];
    carModelId = json['carModelId'];
    hasSubscription = json['hasSubscription'];
    colorId = json['colorId'];
    engineNumber = json['engineNumber'];
    isSaipa = json['isSaipa'];
    reliable = json['reliable'];
    carFactoryId = json['carFactoryId'];
    carGroupTitle = json['carGroupTitle'];
    vehicleUsageId = json['vehicleUsageId'];
    vehicleUsageTitle = json['vehicleUsageTitle'];
    carGroupId = json['carGroupId'];
    carGroupTitle = json['carGroupTitle'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['guid'] = guid;
    map['name'] = name;
    map['productionYear'] = productionYear;
    map['licensePlateNo'] = licensePlateNo;
    map['chassisNo'] = chassisNo;
    map['vin'] = vin;
    map['coverCarId'] = coverCarId;
    map['carModelId'] = carModelId;
    map['hasSubscription'] = hasSubscription;
    map['colorId'] = colorId;
    map['engineNumber'] = engineNumber;
    map['isSaipa'] = isSaipa;
    map['reliable'] = reliable;
    map['carFactoryId'] = carFactoryId;
    map['carFactoryTitle'] = carFactoryTitle;
    map['vehicleUsageId'] = vehicleUsageId;
    map['vehicleUsageTitle'] = vehicleUsageTitle;
    map['carGroupId'] = carGroupId;
    map['carGroupTitle'] = carGroupTitle;
    return map;
  }
}
