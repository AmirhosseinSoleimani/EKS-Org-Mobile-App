import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/home_service_package_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_part_entity.dart';

class HomeServicePackageResponseEntity {
  const HomeServicePackageResponseEntity({
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
  final CostCenterEntity? laborCostCenter;
  final bool isSelected;
  final bool? isImageMandatory;
  final List<HomeServicePartGroupEntity>? partGroups;

  HomeServicePackageResponseEntity copyWith({
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
    CostCenterEntity? laborCostCenter,
    bool? isSelected,
    bool? isPartMandatory,
    bool? isImageMandatory,
    List<HomeServicePartGroupEntity>? partGroups,
  }) {
    return HomeServicePackageResponseEntity(
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

  HomeServicePackageResponseModel toModel() {
    return HomeServicePackageResponseModel(
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

class HomeServicePartGroupEntity {
  final int? partGroupId;
  final int? laborId;
  final String? partGroupTitle;
  final List<HomeServicePartEntity>? parts;

  const HomeServicePartGroupEntity({
    this.partGroupId,
    this.partGroupTitle,
    this.parts,
    this.laborId,
  });

  HomeServicePartGroupEntity copyWith({
    int? partGroupId,
    String? partGroupTitle,
    int? laborId,
    List<HomeServicePartEntity>? parts,
  }) {
    return HomeServicePartGroupEntity(
      partGroupId: partGroupId ?? this.partGroupId,
      partGroupTitle: partGroupTitle ?? this.partGroupTitle,
      parts: parts ?? this.parts,
      laborId: laborId ?? this.laborId,
    );
  }

  HomeServicePartGroupModel toModel() {
    return HomeServicePartGroupModel(
      partGroupId: partGroupId,
      partGroupTitle: partGroupTitle,
      laborId: laborId,
      parts: parts?.map((e) => e.toModel()).toList(),
    );
  }
}
