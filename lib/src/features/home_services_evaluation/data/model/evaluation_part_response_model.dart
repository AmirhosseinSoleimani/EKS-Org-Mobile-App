import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/cost_center_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';

class EvaluationPartResponseModel extends EvaluationPartResponseEntity {
  EvaluationPartResponseModel({
    super.isReusable,
    super.laborId,
    super.mark,
    super.partName,
    super.partGroupId,
    super.serial,
    super.costCenterObject,
    super.costCenterList,
    super.hasReusable,
    super.reusablePrice,
    super.count,
    super.isCausing,
    super.laborCode,
    super.partGroupName,
    super.partPrice,
    super.reusablePartName,
    super.reusablePartSerial,
    super.laborName,
    super.garantyDurationDayKilometer,
    super.garantyKilometerKilometer
  });

  factory EvaluationPartResponseModel.fromJson(Map<String, dynamic> json) {
    return EvaluationPartResponseModel(
      isReusable: json['isReusable'],
      laborId: json['laborId'],
      mark: json['mark'],
      partName: json['name'],
      partGroupId: json['partGroupId'],
      serial: json['serial'],
      costCenterObject: (json['costCenter'] != null) ? CostCenterModel.fromJson(json['costCenter']) : null,
      costCenterList: json['allowableCostCenterList'] != null ? (json['allowableCostCenterList'] as List).map((e) => CostCenterModel.fromJson(e)).toList() : [],
      hasReusable: json['hasReusable'],
      reusablePrice: json['reusablePrice'],
      count: json['count'],
      isCausing: json['isCausing'],
      laborCode: json['laborCode'],
      partGroupName: json['partGroupName'],
      partPrice: json['price'],
      reusablePartName: json['reusablePartName'],
      reusablePartSerial: json['reusablePartSerial'],
      laborName: json['laborName'],
      garantyDurationDayKilometer: json['garantyDurationDayKilometer'],
      garantyKilometerKilometer: json['garantyKilometerKilometer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
    'isReusable': isReusable,
    'laborId': laborId,
    'mark': mark,
    'name': partName,
    'partGroupId': partGroupId,
    'serial': serial,
    'costCenter': costCenterObject?.toModel().toJson(),
    'allowableCostCenterList': costCenterList?.map((e) => e.toModel().toJson()).toList(),
    'hasReusable': hasReusable,
    'reusablePrice': reusablePrice,
    'isCausing': isCausing,
    'laborCode': laborCode,
    'partGroupName': partGroupName,
    'price': partPrice,
    'count': count,
    'reusablePartName': reusablePartName,
    'reusablePartSerial': reusablePartSerial,
    'laborName': laborName,
     'garantyDurationDayKilometer': garantyDurationDayKilometer,
     'garantyKilometerKilometer': garantyKilometerKilometer,
    };
  }
}