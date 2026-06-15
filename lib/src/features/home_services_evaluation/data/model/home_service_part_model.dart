import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_part_entity.dart';


class HomeServicePartModel extends HomeServicePartEntity {
  const HomeServicePartModel({
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

  factory HomeServicePartModel.fromJson(Map<String, dynamic> json) {
    return HomeServicePartModel(
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
        partCostCenter: (json['partCostCenter'] != null) ? CostCenterModel.fromJson(json['partCostCenter']) : null
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