import '../../data/models/home_service_package_part_model.dart';
import 'allowable_cost_center_entity.dart';

class HomeServicePackagePartEntity {
  final int? laborId;
  final String? laborName;
  final int? partIdForClient;
  final int? partGroupId;
  final String? partGroupName;
  final String? partTitle;
  final int? serial;
  final String? mark;
  final String? partCostCenterTitle;
  final int? partPrice;
  final int? consumptionCoefficient;
  final AllowableCostCenterEntity? partCostCenter;
  final bool? isMandatory;
  final bool? hasReusable;
  final int? reusablePrice;
  final bool? selected;

  const HomeServicePackagePartEntity({
    this.laborId,
    this.laborName,
    this.partIdForClient,
    this.partGroupId,
    this.partGroupName,
    this.partTitle,
    this.serial,
    this.mark,
    this.partCostCenterTitle,
    this.partPrice,
    this.consumptionCoefficient,
    this.partCostCenter,
    this.isMandatory,
    this.hasReusable,
    this.reusablePrice,
    this.selected,
  });

  HomeServicePackagePartModel toModel() {
    return HomeServicePackagePartModel(
      laborId: laborId,
      laborName: laborName,
      partIdForClient: partIdForClient,
      partGroupId: partGroupId,
      partGroupName: partGroupName,
      partTitle: partTitle,
      serial: serial,
      mark: mark,
      partCostCenterTitle: partCostCenterTitle,
      partPrice: partPrice,
      consumptionCoefficient: consumptionCoefficient,
      partCostCenter: partCostCenter?.toModel(),
      isMandatory: isMandatory,
      hasReusable: hasReusable,
      reusablePrice: reusablePrice,
      selected: selected,
    );
  }

  HomeServicePackagePartEntity copyWith({
    int? laborId,
    String? laborName,
    int? partIdForClient,
    int? partGroupId,
    String? partGroupName,
    String? partTitle,
    int? serial,
    String? mark,
    String? partCostCenterTitle,
    int? partPrice,
    int? consumptionCoefficient,
    AllowableCostCenterEntity? partCostCenter,
    bool? isMandatory,
    bool? hasReusable,
    int? reusablePrice,
    bool? selected,
  }) {
    return HomeServicePackagePartEntity(
      laborId: laborId ?? this.laborId,
      laborName: laborName ?? this.laborName,
      partIdForClient: partIdForClient ?? this.partIdForClient,
      partGroupId: partGroupId ?? this.partGroupId,
      partGroupName: partGroupName ?? this.partGroupName,
      partTitle: partTitle ?? this.partTitle,
      serial: serial ?? this.serial,
      mark: mark ?? this.mark,
      partCostCenterTitle:
      partCostCenterTitle ?? this.partCostCenterTitle,
      partPrice: partPrice ?? this.partPrice,
      consumptionCoefficient:
      consumptionCoefficient ?? this.consumptionCoefficient,
      partCostCenter: partCostCenter ?? this.partCostCenter,
      isMandatory: isMandatory ?? this.isMandatory,
      hasReusable: hasReusable ?? this.hasReusable,
      reusablePrice: reusablePrice ?? this.reusablePrice,
      selected: selected ?? this.selected,
    );
  }
}