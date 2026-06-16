import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_part_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_package_response_entity.dart';

class InsertHomeServicePackageResponseModel
    extends InsertHomeServicePackageResponseEntity {
  const InsertHomeServicePackageResponseModel({
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

  factory InsertHomeServicePackageResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InsertHomeServicePackageResponseModel(
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
          ? InsertHomeServiceCostCenterModel.fromJson(json['laborCostCenter'])
          : null,
      partGroups: json['partGroups'] != null
          ? (json['partGroups'] as List)
                .map((e) => InsertHomeServicePartGroupModel.fromJson(e))
                .toList()
          : [],
    );
  }
}

class InsertHomeServicePartGroupModel extends InsertHomeServicePartGroupEntity {
  const InsertHomeServicePartGroupModel({
    super.partGroupId,
    super.partGroupTitle,
    super.parts,
    super.laborId,
  });

  factory InsertHomeServicePartGroupModel.fromJson(Map<String, dynamic> json) {
    return InsertHomeServicePartGroupModel(
      partGroupId: json['partGroupId'],
      partGroupTitle: json['partGroupTitle'],
      laborId: json['laborId'],
      parts: json['parts'] != null
          ? (json['parts'] as List)
                .map((e) => InsertHomeServicePartModel.fromJson(e))
                .toList()
          : [],
    );
  }
}
