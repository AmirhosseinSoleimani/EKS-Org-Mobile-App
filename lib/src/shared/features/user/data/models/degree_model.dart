import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/degree_entity.dart';

class DegreeModel extends DegreeEntity {
  const DegreeModel({
    super.id,
    super.title,
  });

  factory DegreeModel.fromJson(Map<String, dynamic> json) {
    return DegreeModel(
      id: json['id'],
      title: json['title'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
  };
}
