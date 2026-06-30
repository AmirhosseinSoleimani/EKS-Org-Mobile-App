import 'package:eks_sana_plus_org/src/features/evaluation/data/models/representation_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class RepresentationEntity implements DropdownItem<int?> {
  final int? id;
  final int? cityId;
  final String? systemCode;
  final String? boardCode;
  final String? name;
  final String? nameWithBoardCode;
  final String? address;
  final bool? isDeleted;
  final bool? isActive;
  final double? latitude;
  final double? longitude;

  const RepresentationEntity({
    this.id,
    this.cityId,
    this.systemCode,
    this.boardCode,
    this.name,
    this.nameWithBoardCode,
    this.address,
    this.isDeleted,
    this.isActive,
    this.latitude,
    this.longitude,
  });

  RepresentationEntity copyWith({
    int? id,
    int? cityId,
    String? systemCode,
    String? boardCode,
    String? name,
    String? nameWithBoardCode,
    String? address,
    bool? isDeleted,
    bool? isActive,
    double? latitude,
    double? longitude,
  }) {
    return RepresentationEntity(
      id: id ?? this.id,
      cityId: cityId ?? this.cityId,
      systemCode: systemCode ?? this.systemCode,
      boardCode: boardCode ?? this.boardCode,
      name: name ?? this.name,
      nameWithBoardCode: nameWithBoardCode ?? this.nameWithBoardCode,
      address: address ?? this.address,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  RepresentationModel toModel() {
    return RepresentationModel(
      id: id,
      cityId: cityId,
      systemCode: systemCode,
      boardCode: boardCode,
      name: name,
      nameWithBoardCode: nameWithBoardCode,
      address: address,
      isDeleted: isDeleted,
      isActive: isActive,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  String get label =>
      nameWithBoardCode ?? name ?? systemCode ?? boardCode ?? '';

  @override
  int? get value => id;

  @override
  Widget? leading(BuildContext context) => null;
}