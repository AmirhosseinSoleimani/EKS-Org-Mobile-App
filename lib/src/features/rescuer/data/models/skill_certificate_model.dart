import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';

class SkillCertificateModel extends SkillCertificateEntity {
  const SkillCertificateModel({
    super.id,
    super.title,
    super.selectable,
  });

  factory SkillCertificateModel.fromJson(Map<String, dynamic> json) {
    return SkillCertificateModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title']?.toString(),
      selectable: json['selectable'] as bool?,
    );
  }
}
