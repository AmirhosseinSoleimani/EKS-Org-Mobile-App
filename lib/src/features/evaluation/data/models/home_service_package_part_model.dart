import '../../domain/entities/home_service_package_part_entity.dart';
import 'allowable_cost_center_model.dart';

class HomeServicePackagePartModel extends HomeServicePackagePartEntity {
  const HomeServicePackagePartModel({
    super.laborId,
    super.laborName,
    super.partIdForClient,
    super.partGroupId,
    super.partGroupName,
    super.partTitle,
    super.serial,
    super.mark,
    super.partCostCenterTitle,
    super.partPrice,
    super.consumptionCoefficient,
    super.partCostCenter,
    super.isMandatory,
    super.hasReusable,
    super.reusablePrice,
    super.selected,
  });

  factory HomeServicePackagePartModel.fromJson(Map<String, dynamic> json) {
    return HomeServicePackagePartModel(
      laborId: json['laborId'],
      laborName: json['laborName'],
      partIdForClient: json['partIdForClient'],
      partGroupId: json['partGroupId'],
      partGroupName: json['partGroupName'],
      partTitle: json['partTitle'],
      serial: json['serial'],
      mark: json['mark'],
      partCostCenterTitle: json['partCostCenterTitle'],
      partPrice: json['partPrice'],
      consumptionCoefficient: json['consumptionCoefficient'],
      partCostCenter: json['partCostCenter'] == null
          ? null
          : AllowableCostCenterModel.fromJson(json['partCostCenter']),
      isMandatory: json['isMandatory'],
      hasReusable: json['hasReusable'],
      reusablePrice: json['reusablePrice'],
      selected: json['selected'],
    );
  }
}