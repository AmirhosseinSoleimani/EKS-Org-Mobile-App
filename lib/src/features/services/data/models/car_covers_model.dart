import 'package:eks_sana_plus_org/src/features/services/domain/entities/car_covers_entity.dart';

class CarCoversDataModel extends CarCoversDataEntity {
  const CarCoversDataModel({
    super.carColors,
    super.coverCars,
  });

  factory CarCoversDataModel.fromJson(Map<String, dynamic> json) {
    return CarCoversDataModel(
      carColors: (json['carColors'] as List<dynamic>?)
          ?.map((e) => CarColorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      coverCars: (json['coverCars'] as List<dynamic>?)
          ?.map((e) => CoverCarModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carColors': carColors?.map((e) => (e as CarColorModel).toJson()).toList(),
      'coverCars': coverCars?.map((e) => (e as CoverCarModel).toJson()).toList(),
    };
  }
}

class CarColorModel extends CarColorEntity {
  const CarColorModel({
    super.colorId,
    super.colorCode,
    super.colorName,
  });

  factory CarColorModel.fromJson(Map<String, dynamic> json) {
    return CarColorModel(
      colorId: json['colorId'] as int?,
      colorCode: json['colorCode'] as String?,
      colorName: json['colorName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colorId': colorId,
      'colorCode': colorCode,
      'colorName': colorName,
    };
  }
}

class CoverCarModel extends CoverCarEntity {
  const CoverCarModel({
    super.id,
    super.carCoverId,
    super.name,
    super.isOther,
    super.imageUrl,
    super.carGroupId,
    super.carGroupTitle,
    super.vehicleUsageId,
    super.vehicleUsageTitle,
    super.carFactoryId,
    super.carFactoryTitle,
    super.wageGroupType,
    super.weightGroupTitle,
  });

  factory CoverCarModel.fromJson(Map<String, dynamic> json) {
    return CoverCarModel(
      id: json['id'] as int?,
      carCoverId: json['carCoverId'] as int?,
      name: json['name'] as String?,
      isOther: json['isOther'] as bool?,
      imageUrl: json['imageUrl'] as String?,
      carGroupId: json['carGroupId'] as int?,
      carGroupTitle: json['carGroupTitle'] as String?,
      vehicleUsageId: json['vehicleUsageId'] as int?,
      vehicleUsageTitle: json['vehicleUsageTitle'] as String?,
      carFactoryId: json['carFactoryId'] as int?,
      carFactoryTitle: json['carFactoryTitle'] as String?,
      wageGroupType: json['wageGroupType'] as int?,
      weightGroupTitle: json['weightGroupTitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carCoverId': carCoverId,
      'name': name,
      'isOther': isOther,
      'imageUrl': imageUrl,
      'carGroupId': carGroupId,
      'carGroupTitle': carGroupTitle,
      'vehicleUsageId': vehicleUsageId,
      'vehicleUsageTitle': vehicleUsageTitle,
      'carFactoryId': carFactoryId,
      'carFactoryTitle': carFactoryTitle,
      'wageGroupType': wageGroupType,
      'weightGroupTitle': weightGroupTitle,
    };
  }
}
