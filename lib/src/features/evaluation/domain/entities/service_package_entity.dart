
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_package_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_package_part_group_entity.dart';

import 'allowable_cost_center_entity.dart';

class ServicePackageEntity {
  final int? id;
  final int? serviceCategoryId;
  final int? serviceId;
  final String? serviceTitle;
  final int? laborId;
  final int? laborGroupId;
  final String? laborGroupDescription;
  final String? laborTitle;
  final String? laborDesc;
  final String? laborCode;
  final String? overLapCode;
  final String? laborCostCenterTitle;
  final int? laborPrice;
  final AllowableCostCenterEntity? laborCostCenter;
  final bool? isMandatory;
  final List<ServicePackagePartGroupEntity>? partGroups;
  final bool? selected;
  final bool? isPartMandatory;
  final bool? isImageMandatory;

  const ServicePackageEntity({
    this.id,
    this.serviceCategoryId,
    this.serviceId,
    this.serviceTitle,
    this.laborId,
    this.laborGroupId,
    this.laborGroupDescription,
    this.laborTitle,
    this.laborDesc,
    this.laborCode,
    this.overLapCode,
    this.laborCostCenterTitle,
    this.laborPrice,
    this.laborCostCenter,
    this.isMandatory,
    this.partGroups,
    this.selected,
    this.isPartMandatory,
    this.isImageMandatory,
  });

  ServicePackageModel toModel() {
    return ServicePackageModel(
      id: id,
      serviceCategoryId: serviceCategoryId,
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      laborId: laborId,
      laborGroupId: laborGroupId,
      laborGroupDescription: laborGroupDescription,
      laborTitle: laborTitle,
      laborDesc: laborDesc,
      laborCode: laborCode,
      overLapCode: overLapCode,
      laborCostCenterTitle: laborCostCenterTitle,
      laborPrice: laborPrice,
      laborCostCenter: laborCostCenter?.toModel(),
      isMandatory: isMandatory,
      partGroups: partGroups?.map((element) => element.toModel()).toList(),
      selected: selected,
      isPartMandatory: isPartMandatory,
      isImageMandatory: isImageMandatory,
    );
  }

  ServicePackageEntity copyWith({
    int? id,
    int? serviceCategoryId,
    int? serviceId,
    String? serviceTitle,
    int? laborId,
    int? laborGroupId,
    String? laborGroupDescription,
    String? laborTitle,
    String? laborDesc,
    String? laborCode,
    String? overLapCode,
    String? laborCostCenterTitle,
    int? laborPrice,
    AllowableCostCenterEntity? laborCostCenter,
    bool? isMandatory,
    List<ServicePackagePartGroupEntity>? partGroups,
    bool? selected,
    bool? isPartMandatory,
    bool? isImageMandatory,
  }) {
    return ServicePackageEntity(
      id: id ?? this.id,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceId: serviceId ?? this.serviceId,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      laborId: laborId ?? this.laborId,
      laborGroupId: laborGroupId ?? this.laborGroupId,
      laborGroupDescription:
      laborGroupDescription ?? this.laborGroupDescription,
      laborTitle: laborTitle ?? this.laborTitle,
      laborDesc: laborDesc ?? this.laborDesc,
      laborCode: laborCode ?? this.laborCode,
      overLapCode: overLapCode ?? this.overLapCode,
      laborCostCenterTitle:
      laborCostCenterTitle ?? this.laborCostCenterTitle,
      laborPrice: laborPrice ?? this.laborPrice,
      laborCostCenter: laborCostCenter ?? this.laborCostCenter,
      isMandatory: isMandatory ?? this.isMandatory,
      partGroups: partGroups ?? this.partGroups,
      selected: selected ?? this.selected,
      isPartMandatory: isPartMandatory ?? this.isPartMandatory,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }
}