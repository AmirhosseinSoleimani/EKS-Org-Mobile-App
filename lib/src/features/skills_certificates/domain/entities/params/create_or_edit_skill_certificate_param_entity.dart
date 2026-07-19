import '../../../data/models/params/create_or_edit_skill_certificate_param_model.dart';

class CreateOrEditSkillCertificateParamEntity {
  final int? id;
  final String title;
  final bool isActive;

  const CreateOrEditSkillCertificateParamEntity({
    this.id,
    required this.title,
    required this.isActive,
  });

  CreateOrEditSkillCertificateParamModel toModel() {
    return CreateOrEditSkillCertificateParamModel(
      id: id,
      title: title,
      isActive: isActive,
    );
  }
}
