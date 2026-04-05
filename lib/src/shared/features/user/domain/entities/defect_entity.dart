import 'package:eks_sana_plus_org/src/shared/features/user/data/models/defect_model.dart';

class DefectEntity {
  const DefectEntity({
    this.id,
    this.code,
    this.title,
  });

  final int? id;
  final int? code;
  final String? title;

  DefectModel toModel() {
    return DefectModel(id: id, code: code, title: title);
  }
}
