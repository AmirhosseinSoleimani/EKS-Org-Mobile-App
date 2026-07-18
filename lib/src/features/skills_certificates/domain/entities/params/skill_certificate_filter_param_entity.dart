import '../../../data/models/params/skill_certificate_filter_param_model.dart';

class SkillCertificateFilterParamEntity {
  final int skip;
  final int pageSize;
  final String? title;
  final bool? isActive;

  const SkillCertificateFilterParamEntity({
    this.skip = 0,
    this.pageSize = 10,
    this.title,
    this.isActive,
  });

  SkillCertificateFilterParamModel toModel() {
    return SkillCertificateFilterParamModel(
      skip: skip,
      pageSize: pageSize,
      title: title,
      isActive: isActive,
    );
  }
}
