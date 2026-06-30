import 'package:eks_sana_plus_org/src/common/utils/extensions/color_code_parser.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/car_covers_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class CarCoversDataEntity {
  final List<CarColorEntity>? carColors;
  final List<CoverCarEntity>? coverCars;

  const CarCoversDataEntity({this.carColors, this.coverCars});

  CarCoversDataEntity copyWith({
    List<CarColorEntity>? carColors,
    List<CoverCarEntity>? coverCars,
  }) {
    return CarCoversDataEntity(
      carColors: carColors ?? this.carColors,
      coverCars: coverCars ?? this.coverCars,
    );
  }

  CarCoversDataModel toModel() {
    return CarCoversDataModel(
      carColors: carColors?.map((element) => element.toModel()).toList(),
      coverCars: coverCars?.map((element) => element.toModel()).toList(),
    );
  }
}

class CarColorEntity implements DropdownItem {
  final int? colorId;
  final String? colorCode;
  final String? colorName;

  const CarColorEntity({this.colorId, this.colorCode, this.colorName});

  CarColorEntity copyWith({
    int? colorId,
    String? colorCode,
    String? colorName,
  }) {
    return CarColorEntity(
      colorId: colorId ?? this.colorId,
      colorCode: colorCode ?? this.colorCode,
      colorName: colorName ?? this.colorName,
    );
  }

  CarColorModel toModel() {
    return CarColorModel(
      colorId: colorId,
      colorCode: colorCode,
      colorName: colorName,
    );
  }

  @override
  String get label => colorName ?? '';

  @override
  Widget? leading(BuildContext context) {
    if (colorCode == null || colorCode!.isEmpty) return null;

    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorCodeParser.parse(colorCode),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
    );
  }

  @override
  get value => colorId;
}

class CoverCarEntity implements DropdownItem {
  final int? id;
  final int? carCoverId;
  final String? name;
  final bool? isOther;
  final String? imageUrl;
  final int? carGroupId;
  final String? carGroupTitle;
  final int? vehicleUsageId;
  final String? vehicleUsageTitle;
  final int? carFactoryId;
  final String? carFactoryTitle;
  final int? wageGroupType;
  final String? weightGroupTitle;

  const CoverCarEntity({
    this.id,
    this.carCoverId,
    this.name,
    this.isOther,
    this.imageUrl,
    this.carGroupId,
    this.carGroupTitle,
    this.vehicleUsageId,
    this.vehicleUsageTitle,
    this.carFactoryId,
    this.carFactoryTitle,
    this.wageGroupType,
    this.weightGroupTitle,
  });

  CoverCarEntity copyWith({
    int? id,
    int? carCoverId,
    String? name,
    bool? isOther,
    String? imageUrl,
    int? carGroupId,
    String? carGroupTitle,
    int? vehicleUsageId,
    String? vehicleUsageTitle,
    int? carFactoryId,
    String? carFactoryTitle,
    int? wageGroupType,
    String? weightGroupTitle,
  }) {
    return CoverCarEntity(
      id: id ?? this.id,
      carCoverId: carCoverId ?? this.carCoverId,
      name: name ?? this.name,
      isOther: isOther ?? this.isOther,
      imageUrl: imageUrl ?? this.imageUrl,
      carGroupId: carGroupId ?? this.carGroupId,
      carGroupTitle: carGroupTitle ?? this.carGroupTitle,
      vehicleUsageId: vehicleUsageId ?? this.vehicleUsageId,
      vehicleUsageTitle: vehicleUsageTitle ?? this.vehicleUsageTitle,
      carFactoryId: carFactoryId ?? this.carFactoryId,
      carFactoryTitle: carFactoryTitle ?? this.carFactoryTitle,
      wageGroupType: wageGroupType ?? this.wageGroupType,
      weightGroupTitle: weightGroupTitle ?? this.weightGroupTitle,
    );
  }

  CoverCarModel toModel() {
    return CoverCarModel(
      id: id,
      carCoverId: carCoverId,
      name: name,
      isOther: isOther,
      imageUrl: imageUrl,
      carGroupId: carGroupId,
      carGroupTitle: carGroupTitle,
      vehicleUsageId: vehicleUsageId,
      vehicleUsageTitle: vehicleUsageTitle,
      carFactoryId: carFactoryId,
      carFactoryTitle: carFactoryTitle,
      wageGroupType: wageGroupType,
      weightGroupTitle: weightGroupTitle,
    );
  }

  @override
  String get label => name ?? '';

  @override
  Widget? leading(BuildContext context) {
    return null;
  }

  @override
  get value => id;
}
