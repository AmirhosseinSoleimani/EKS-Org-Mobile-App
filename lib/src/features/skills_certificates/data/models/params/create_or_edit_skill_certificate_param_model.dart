class CreateOrEditSkillCertificateParamModel {
  final int? id;
  final String title;
  final bool isActive;

  const CreateOrEditSkillCertificateParamModel({
    this.id,
    required this.title,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title.trim(),
      'isActive': isActive,
    };
  }
}
