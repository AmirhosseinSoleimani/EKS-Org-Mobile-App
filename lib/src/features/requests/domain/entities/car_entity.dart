import 'package:eks_sana_plus_org/src/features/requests/data/models/car_model.dart';

class CarEntity {
  String? guid;
  String? name;
  int? productionYear;
  String? licensePlateNo;
  String? chassisNo;
  String? vin;
  int? coverCarId;
  int? carModelId;
  bool? hasSubscription;
  int? colorId;
  String? engineNumber;
  bool? isSaipa;
  bool? reliable;
  int? carFactoryId;
  String? carFactoryTitle;
  int? vehicleUsageId;
  String? vehicleUsageTitle;
  int? carGroupId;
  String? carGroupTitle;

  CarEntity({
    this.guid,
    this.name,
    this.productionYear,
    this.licensePlateNo,
    this.chassisNo,
    this.vin,
    this.coverCarId,
    this.carModelId,
    this.hasSubscription,
    this.colorId,
    this.engineNumber,
    this.isSaipa,
    this.reliable,
    this.carFactoryId,
    this.carFactoryTitle,
    this.vehicleUsageId,
    this.vehicleUsageTitle,
    this.carGroupId,
    this.carGroupTitle,
  });

  CarModel toModel() {
    return CarModel(
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
  }
}
