

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/defect_response_entity.dart';



class DefectResponseModel extends DefectResponseEntity{
  DefectResponseModel({
    super.id,
    super.title,
    super.code,
    super.parentId,
    super.saipaYadakEzharCode,
    super.parentCode,
    super.isActive
  });

  DefectResponseModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parentId'];
    code = json['code'];
    saipaYadakEzharCode = json['saipaYadakEzharCode'];
    parentCode = json['parentCode'];
    isActive = json['isActive'];
  }
}