import 'package:eks_sana_plus_org/src/features/skills_certificates/data/data_source/skills_certificates_data_source.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/params/create_or_edit_skill_certificate_param_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/params/skill_certificate_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/params/submit_skill_services_param_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/skill_certificate_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/skill_service_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/service/skills_certificates_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SkillsCertificatesDataSource)
class SkillsCertificatesDataSourceImpl extends SkillsCertificatesDataSource {
  final SkillsCertificatesService _service;

  SkillsCertificatesDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<SkillCertificateListModel>> getSkills(
    SkillCertificateFilterParamModel param,
  ) =>
      _service.getSkills(param.toJson());

  @override
  Future<BaseSingleResponse<SkillCertificateModel>> getSkillById(int id) =>
      _service.getSkillById({'Id': id});

  @override
  Future<BaseSingleResponse<void>> createSkill(
    CreateOrEditSkillCertificateParamModel param,
  ) async {
    final rawResponse = await _service.createSkill(param.toJson());
    final normalizedResponse = Map<String, dynamic>.from(rawResponse);

    // The create endpoint returns the created id as a string, for example
    // data: "202". BaseSingleResponse<void> expects object-shaped data.
    if (normalizedResponse['data'] is! Map<String, dynamic>) {
      normalizedResponse['data'] = <String, dynamic>{};
    }

    return BaseSingleResponse<void>.fromJson(
      normalizedResponse,
      (_) {},
    );
  }

  @override
  Future<BaseSingleResponse<void>> editSkill(
    CreateOrEditSkillCertificateParamModel param,
  ) =>
      _service.editSkill(param.toJson());

  @override
  Future<BaseSingleResponse<void>> deleteSkill(int id) =>
      _service.deleteSkill({'id': id});

  @override
  Future<BaseListResponse<SkillServiceModel>> getServices(int skillId) =>
      _service.getServices({'SkillCertificateId': skillId});

  @override
  Future<BaseSingleResponse<void>> submitServices(
    SubmitSkillServicesParamModel param,
  ) =>
      _service.submitServices(param.toJson());

  @override
  Future<BaseSingleResponse<SkillCertificateListModel>> getReport(
    SkillCertificateFilterParamModel param,
  ) {
    final body = param.toJson()
      ..['Skip'] = 0
      ..['Take'] = 0
      ..['PageSize'] = 0;
    return _service.getReport(body);
  }
}
