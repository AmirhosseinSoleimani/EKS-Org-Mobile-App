import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_part_entity.dart';

class InsertHomeServicePartModel extends InsertHomeServicePartEntity {
  const InsertHomeServicePartModel({
    super.serial,
    super.mark,
    super.partGroupId,
    super.laborId,
    super.partPrice,
    super.partCostCenter,
    super.partTitle,
    super.hasReusable,
    super.reusablePrice,
    super.isSelected,
    super.isMandatory,
    super.partCostCenterTitle,
    super.partGroupName,
  });

  factory InsertHomeServicePartModel.fromJson(Map<String, dynamic> json) {
    return InsertHomeServicePartModel(
      hasReusable: json['hasReusable'],
      reusablePrice: json['reusablePrice'],
      partGroupName: json['partGroupName'],
      partGroupId: json['partGroupId'],
      partTitle: json['partTitle'],
      serial: json['serial'],
      isSelected: json['selected'],
      mark: json['mark'],
      partCostCenterTitle: json['partCostCenterTitle'],
      partPrice: json['partPrice'],
      isMandatory: json['isMandatory'],
      partCostCenter: (json['partCostCenter'] != null)
          ? InsertHomeServiceCostCenterModel.fromJson(json['partCostCenter'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serial'] = serial;
    map['mark'] = mark;
    map['partGroupId'] = partGroupId;
    map['name'] = partTitle;
    map['laborId'] = laborId;
    map['hasReusable'] = hasReusable;
    map['reusablePrice'] = reusablePrice;
    map['partCostCenter '] = partCostCenter?.toModel().toJson();
    map['partPrice'] = partPrice;
    return map;
  }
}
