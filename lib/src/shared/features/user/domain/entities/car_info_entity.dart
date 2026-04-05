import 'package:eks_sana_plus_org/src/shared/features/user/data/models/car_info_model.dart';

class CarInfoEntity {
  final String? guid;
  final String? name;
  final int? productionYear;
  final String? licensePlateNo;
  final String? chassisNo;
  final String? vin;
  final int? coverCarId;
  final int? carModelId;
  final bool? hasSubscription;
  final int? colorId;
  final String? engineNumber;
  final bool? isSaipa;
  final bool? reliable;
  final int? carFactoryId;
  final String? carFactoryTitle;
  final int? vehicleUsageId;
  final String? vehicleUsageTitle;
  final int? carGroupId;
  final String? carGroupTitle;
  final bool? state;
  final int? kilometer;

  const CarInfoEntity(
      {this.guid,
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
      this.state,
      this.kilometer,
      });

  CarInfoEntity copyWith({
    int? id,
    int? ownerUserId,
    String? guid,
    int? carModelId,
    String? ownerUserGuid,
    String? carName,
    int? carColor,
    int? year,
    String? chassisNumber,
    String? licensePlate,
    bool? licensePlateNoIsUpdated,
    String? engineNumber,
    int? factoryId,
    String? factoryTitle,
    bool? isSaipa,
    bool? isBlocked,
    int? vehicleUsageId,
    String? vehicleUsageTitle,
    int? carGroupId,
    String? carGroupTitle,
    bool? homeServiceSubscription,
    bool? state,
    bool? isGuaranty,
    String? guarantyStartDate,
    String? lastMileage,
    int? colorId,
    String? vin,
    int? kilometer,
  }) {
    return CarInfoEntity(
        guid: guid ?? this.guid,
        carModelId: carModelId ?? this.carModelId,
        engineNumber: engineNumber ?? this.engineNumber,
        isSaipa: isSaipa ?? this.isSaipa,
        vehicleUsageId: vehicleUsageId ?? this.vehicleUsageId,
        vehicleUsageTitle: vehicleUsageTitle ?? this.vehicleUsageTitle,
        carGroupId: carGroupId ?? this.carGroupId,
        carGroupTitle: carGroupTitle ?? this.carGroupTitle,
        chassisNo: chassisNumber ?? chassisNo,
        name: carName ?? name,
        productionYear: year ?? productionYear,
        licensePlateNo: licensePlate ?? licensePlateNo,
        state: state ?? this.state,
        colorId: colorId ?? this.colorId,
        vin: vin ?? this.vin,
        kilometer: kilometer ?? this.kilometer,
    );
  }

  CarInfoModel toModel() {
    return CarInfoModel(
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
