import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/defect_entity.dart';

class DefectModel extends DefectEntity {
  const DefectModel({
    super.code,
    super.id,
    super.title,
  });

  factory DefectModel.fromJson(Map<String, dynamic> json) {
    return DefectModel(
      id: json['id'],
      code: json['code'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'title': title,
      };
}
