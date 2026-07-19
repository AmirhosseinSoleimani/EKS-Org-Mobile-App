class SubmitSkillServicesParamModel {
  final int skillCertificateId;
  final List<int> emdadServiceIds;

  const SubmitSkillServicesParamModel({
    required this.skillCertificateId,
    required this.emdadServiceIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'skillCertificateId': skillCertificateId,
      'EmdadServiceIds': emdadServiceIds,
    };
  }
}
