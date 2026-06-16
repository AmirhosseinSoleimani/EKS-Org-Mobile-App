import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_package_response_model.dart';

import 'insert_home_service_cost_center_entity.dart';
import 'insert_home_service_part_entity.dart';

class InsertHomeServicePackageResponseEntity {
  const InsertHomeServicePackageResponseEntity({
    this.id,
    this.serviceCategoryId,
    this.serviceId,
    this.serviceTitle,
    this.laborGroupId,
    this.laborGroupDescription,
    this.laborDesc,
    this.laborCode,
    this.isMandatory,
    this.laborTitle,
    this.laborId,
    this.laborCostCenterTitle,
    this.laborPrice,
    this.laborCostCenter,
    this.isPartMandatory,
    this.isSelected = false,
    this.partGroups,
    this.isImageMandatory,
  });

  final int? id;
  final int? serviceCategoryId;
  final int? serviceId;
  final String? serviceTitle;
  final int? laborGroupId;
  final String? laborGroupDescription;
  final String? laborDesc;
  final String? laborCode;
  final bool? isMandatory;
  final bool? isPartMandatory;
  final int? laborId;
  final String? laborTitle;
  final String? laborCostCenterTitle;
  final int? laborPrice;
  final InsertHomeServiceCostCenterEntity? laborCostCenter;
  final bool isSelected;
  final bool? isImageMandatory;
  final List<InsertHomeServicePartGroupEntity>? partGroups;

  InsertHomeServicePackageResponseEntity copyWith({
    int? id,
    int? serviceCategoryId,
    int? serviceId,
    String? serviceTitle,
    int? laborGroupId,
    String? laborGroupDescription,
    String? laborDesc,
    String? laborCode,
    bool? isMandatory,
    int? laborId,
    String? laborTitle,
    String? laborCostCenterTitle,
    int? laborPrice,
    InsertHomeServiceCostCenterEntity? laborCostCenter,
    bool? isSelected,
    bool? isPartMandatory,
    bool? isImageMandatory,
    List<InsertHomeServicePartGroupEntity>? partGroups,
  }) {
    return InsertHomeServicePackageResponseEntity(
      id: id ?? this.id,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceId: serviceId ?? this.serviceId,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      laborGroupId: laborGroupId ?? this.laborGroupId,
      laborGroupDescription:
          laborGroupDescription ?? this.laborGroupDescription,
      laborDesc: laborDesc ?? this.laborDesc,
      laborCode: laborCode ?? this.laborCode,
      isMandatory: isMandatory ?? this.isMandatory,
      laborId: laborId ?? this.laborId,
      laborTitle: laborTitle ?? this.laborTitle,
      laborCostCenterTitle: laborCostCenterTitle ?? this.laborCostCenterTitle,
      laborPrice: laborPrice ?? this.laborPrice,
      laborCostCenter: laborCostCenter ?? this.laborCostCenter,
      isPartMandatory: isPartMandatory ?? this.isPartMandatory,
      isSelected: isSelected ?? this.isSelected,
      partGroups: partGroups ?? this.partGroups,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }

  InsertHomeServicePackageResponseModel toModel() {
    return InsertHomeServicePackageResponseModel(
      id: id,
      isSelected: isSelected,
      serviceCategoryId: serviceCategoryId,
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      laborGroupId: laborGroupId,
      laborGroupDescription: laborGroupDescription,
      laborDesc: laborDesc,
      laborCode: laborCode,
      isMandatory: isMandatory,
      laborId: laborId,
      laborTitle: laborTitle,
      isPartMandatory: isPartMandatory,
      laborCostCenter: laborCostCenter,
      laborCostCenterTitle: laborCostCenterTitle,
      laborPrice: laborPrice,
      partGroups: partGroups,
      isImageMandatory: isImageMandatory,
    );
  }
}

class InsertHomeServicePartGroupEntity {
  final int? partGroupId;
  final int? laborId;
  final String? partGroupTitle;
  final List<InsertHomeServicePartEntity>? parts;

  const InsertHomeServicePartGroupEntity({
    this.partGroupId,
    this.partGroupTitle,
    this.parts,
    this.laborId,
  });

  InsertHomeServicePartGroupEntity copyWith({
    int? partGroupId,
    String? partGroupTitle,
    int? laborId,
    List<InsertHomeServicePartEntity>? parts,
  }) {
    return InsertHomeServicePartGroupEntity(
      partGroupId: partGroupId ?? this.partGroupId,
      partGroupTitle: partGroupTitle ?? this.partGroupTitle,
      parts: parts ?? this.parts,
      laborId: laborId ?? this.laborId,
    );
  }

  InsertHomeServicePartGroupModel toModel() {
    return InsertHomeServicePartGroupModel(
      partGroupId: partGroupId,
      partGroupTitle: partGroupTitle,
      laborId: laborId,
      parts: parts?.map((e) => e.toModel()).toList(),
    );
  }
}
