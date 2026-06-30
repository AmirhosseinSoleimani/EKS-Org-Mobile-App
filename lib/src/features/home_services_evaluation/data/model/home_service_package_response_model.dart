import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/home_service_part_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_response_entity.dart';

class HomeServicePackageResponseModel
    extends HomeServicePackageResponseEntity {
  const HomeServicePackageResponseModel({
    super.laborId,
    super.laborTitle,
    super.laborCostCenterTitle,
    super.laborPrice,
    super.isPartMandatory,
    super.laborCostCenter,
    super.partGroups,
    super.id,
    super.isMandatory,
    super.laborCode,
    super.isSelected,
    super.laborDesc,
    super.laborGroupDescription,
    super.laborGroupId,
    super.serviceCategoryId,
    super.serviceId,
    super.serviceTitle,
    super.isImageMandatory,
  });

  factory HomeServicePackageResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HomeServicePackageResponseModel(
      id: json['id'],
      serviceCategoryId: json['serviceCategoryId'],
      serviceId: json['serviceId'],
      serviceTitle: json['serviceTitle'],
      laborGroupId: json['laborGroupId'],
      laborGroupDescription: json['laborGroupDescription'],
      laborDesc: json['laborDesc'],
      laborCode: json['laborCode'],
      isMandatory: json['isMandatory'],
      isPartMandatory: json['isPartMandatory'],
      isSelected: json['selected'],
      laborId: json['laborId'],
      laborTitle: json['laborTitle'],
      laborCostCenterTitle: json['laborCostCenterTitle'],
      isImageMandatory: json['isImageMandatory'],
      laborPrice: json['laborPrice'],
      laborCostCenter: json['laborCostCenter'] != null
          ? CostCenterModel.fromJson(json['laborCostCenter'])
          : null,
      partGroups: json['partGroups'] != null
          ? (json['partGroups'] as List)
                .map((e) => HomeServicePartGroupModel.fromJson(e))
                .toList()
          : [],
    );
  }
}

class HomeServicePartGroupModel extends HomeServicePartGroupEntity {
  const HomeServicePartGroupModel({
    super.partGroupId,
    super.partGroupTitle,
    super.parts,
    super.laborId,
  });

  factory HomeServicePartGroupModel.fromJson(Map<String, dynamic> json) {
    return HomeServicePartGroupModel(
      partGroupId: json['partGroupId'],
      partGroupTitle: json['partGroupTitle'],
      laborId: json['laborId'],
      parts: json['parts'] != null
          ? (json['parts'] as List)
                .map((e) => HomeServicePartModel.fromJson(e))
                .toList()
          : [],
    );
  }
}
