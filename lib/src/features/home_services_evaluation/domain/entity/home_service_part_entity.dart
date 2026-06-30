import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/home_service_part_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';


class HomeServicePartEntity{
  const HomeServicePartEntity({
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
  final CostCenterEntity? partCostCenter;
  final bool? isMandatory;
  final bool? isSelected;
  final bool? hasReusable;
  final int? reusablePrice;
  final int? laborId;

  HomeServicePartEntity copyWith({
    int? partGroupId,
    String? partTitle,
    String? partGroupName,
    int? serial,
    String? mark,
    String? partCostCenterTitle,
    int? partPrice,
    CostCenterEntity? partCostCenter,
    bool? isMandatory,
    bool? isSelected,
    bool? hasReusable,
    int? reusablePrice,
    int? laborId,
  }) {
    return HomeServicePartEntity(
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

  HomeServicePartModel toModel() {
    return HomeServicePartModel(
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