import 'package:eks_sana_plus_org/src/features/evaluation/data/models/allowable_cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_package_part_group_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_package_entity.dart';

class ServicePackageModel extends ServicePackageEntity {
  const ServicePackageModel({
    super.id,
    super.serviceCategoryId,
    super.serviceId,
    super.serviceTitle,
    super.laborId,
    super.laborGroupId,
    super.laborGroupDescription,
    super.laborTitle,
    super.laborDesc,
    super.laborCode,
    super.overLapCode,
    super.laborCostCenterTitle,
    super.laborPrice,
    super.laborCostCenter,
    super.isMandatory,
    super.partGroups,
    super.selected,
    super.isPartMandatory,
    super.isImageMandatory,
  });

  factory ServicePackageModel.fromJson(Map<String, dynamic> json) {
    return ServicePackageModel(
      id: json['id'],
      serviceCategoryId: json['serviceCategoryId'],
      serviceId: json['serviceId'],
      serviceTitle: json['serviceTitle'],
      laborId: json['laborId'],
      laborGroupId: json['laborGroupId'],
      laborGroupDescription: json['laborGroupDescription'],
      laborTitle: json['laborTitle'],
      laborDesc: json['laborDesc'],
      laborCode: json['laborCode'],
      overLapCode: json['overLapCode'],
      laborCostCenterTitle: json['laborCostCenterTitle'],
      laborPrice: json['laborPrice'],
      laborCostCenter: json['laborCostCenter'] == null
          ? null
          : AllowableCostCenterModel.fromJson(json['laborCostCenter']),
      isMandatory: json['isMandatory'],
      partGroups: json['partGroups'] == null
          ? null
          : (json['partGroups'] as List)
                .map((e) => ServicePackagePartGroupModel.fromJson(e))
                .toList(),
      selected: json['selected'],
      isPartMandatory: json['isPartMandatory'],
      isImageMandatory: json['isImageMandatory'],
    );
  }
}
