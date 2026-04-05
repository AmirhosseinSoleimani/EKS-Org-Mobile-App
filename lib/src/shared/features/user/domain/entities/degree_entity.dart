import 'package:eks_sana_plus_org/src/shared/features/user/data/models/degree_model.dart';

class DegreeEntity {
  const DegreeEntity({
    this.id,
    this.title,
  });

  final int? id;
  final String? title;

  DegreeModel toModel() {
    return DegreeModel(
      id: id,
      title: title,
    );
  }
}
