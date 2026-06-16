import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_part_model.dart';

import 'insert_home_service_cost_center_entity.dart';

class InsertHomeServicePartEntity {
  const InsertHomeServicePartEntity({
    this.partGroupId,
    this.partTitle,
    this.serial,
    this.isSelected,
    this.mark,
    this.partCostCenterTitle,
    this.partPrice,
    this.partCostCenter,
    this.partGroupName,
    this.isMandatory,
    this.hasReusable,
    this.reusablePrice,
    this.laborId,
  });

  final int? partGroupId;
  final String? partTitle;
  final String? partGroupName;
  final int? serial;
  final String? mark;
  final String? partCostCenterTitle;
  final int? partPrice;
  final InsertHomeServiceCostCenterEntity? partCostCenter;
  final bool? isMandatory;
  final bool? isSelected;
  final bool? hasReusable;
  final int? reusablePrice;
  final int? laborId;

  InsertHomeServicePartEntity copyWith({
    int? partGroupId,
    String? partTitle,
    String? partGroupName,
    int? serial,
    String? mark,
    String? partCostCenterTitle,
    int? partPrice,
    InsertHomeServiceCostCenterEntity? partCostCenter,
    bool? isMandatory,
    bool? isSelected,
    bool? hasReusable,
    int? reusablePrice,
    int? laborId,
  }) {
    return InsertHomeServicePartEntity(
      partGroupId: partGroupId ?? this.partGroupId,
      partTitle: partTitle ?? this.partTitle,
      partGroupName: partGroupName ?? this.partGroupName,
      serial: serial ?? this.serial,
      mark: mark ?? this.mark,
      partCostCenterTitle: partCostCenterTitle ?? this.partCostCenterTitle,
      partPrice: partPrice ?? this.partPrice,
      partCostCenter: partCostCenter ?? this.partCostCenter,
      isMandatory: isMandatory ?? this.isMandatory,
      isSelected: isSelected ?? this.isSelected,
      hasReusable: hasReusable ?? this.hasReusable,
      reusablePrice: reusablePrice ?? this.reusablePrice,
    );
  }

  InsertHomeServicePartModel toModel() {
    return InsertHomeServicePartModel(
      partGroupId: partGroupId,
      hasReusable: hasReusable,
      partGroupName: partGroupName,
      laborId: laborId,
      reusablePrice: reusablePrice,
      partTitle: partTitle,
      serial: serial,
      mark: mark,
      isSelected: isSelected,
      partCostCenterTitle: partCostCenterTitle,
      partPrice: partPrice,
      partCostCenter: partCostCenter,
      isMandatory: isMandatory,
    );
  }
}
