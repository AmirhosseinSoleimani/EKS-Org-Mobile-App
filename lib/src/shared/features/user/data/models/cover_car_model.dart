import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/cover_car_entity.dart';

class CoverCarModel extends CoverCarEntity {
  const CoverCarModel({
    super.id,
    super.carCoverId,
    super.name,
    super.imageUrl,
    super.isOther,
    super.carFactoryId,
    super.carFactoryTitle,
  });

  factory CoverCarModel.fromJson(Map<String, dynamic> json) {
    return CoverCarModel(
      id: json['id'],
      carCoverId: json['carCoverId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      isOther: json['isOther'],
      carFactoryId: json['carFactoryId'],
      carFactoryTitle: json['carFactoryTitle'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'carCoverId': carCoverId,
    'name': name,
    'imageUrl': imageUrl,
    'isOther': isOther,
    'carFactoryId': carFactoryId,
    'carFactoryTitle': carFactoryTitle,
  };
}
