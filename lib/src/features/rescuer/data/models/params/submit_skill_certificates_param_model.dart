class SubmitSkillCertificatesParamModel {
  final List<int> skillCertificateIds;
  final int personInfoId;

  const SubmitSkillCertificatesParamModel({
    required this.skillCertificateIds,
    required this.personInfoId,
  });

  Map<String, dynamic> toJson() {
    return {
      'skillCertificateIds': skillCertificateIds,
      'personInfoId': personInfoId,
    };
  }
}
