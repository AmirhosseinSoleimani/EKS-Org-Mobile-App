import 'package:eks_sana_plus_org/src/features/rescuer/data/models/skill_certificate_model.dart';

class SkillCertificateEntity {
  final int? id;
  final String? title;
  final bool? selectable;

  const SkillCertificateEntity({
    this.id,
    this.title,
    this.selectable,
  });

  SkillCertificateModel toModel() {
    return SkillCertificateModel(
      id: id,
      title: title,
      selectable: selectable,
    );
  }

  SkillCertificateEntity copyWith({
    int? id,
    String? title,
    bool? selectable,
  }) {
    return SkillCertificateEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      selectable: selectable ?? this.selectable,
    );
  }
}
