import 'package:eks_sana_plus_org/src/shared/features/user/data/models/cover_car_model.dart';
import 'package:flutter/material.dart';

@immutable
class CoverCarEntity {
  const CoverCarEntity({
    this.id,
    this.name,
    this.carCoverId,
    this.imageUrl,
    this.isOther,
    this.carFactoryId,
    this.carFactoryTitle,
  });

  final int? id;
  final int? carCoverId;
  final String? name;
  final String? imageUrl;
  final bool? isOther;
  final int? carFactoryId;
  final String? carFactoryTitle;

  CoverCarModel toModel() {
    return CoverCarModel(
      id: id,
      name: name,
      carCoverId: carCoverId,
      imageUrl: imageUrl,
      isOther: isOther,
      carFactoryId: carFactoryId,
      carFactoryTitle: carFactoryTitle,
    );
  }
}
