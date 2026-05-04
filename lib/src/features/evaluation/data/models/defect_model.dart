import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';

class DefectModel extends DefectEntity {
  DefectModel({
    super.id,
    super.title,
    super.code,
    super.parentId,
    super.saipaYadakEzharCode,
    super.parentCode,
    super.isActive,
  });

  DefectModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parentId'];
    code = json['code'];
    saipaYadakEzharCode = json['saipaYadakEzharCode'];
    parentCode = json['parentCode'];
    isActive = json['isActive'];
  }
}
