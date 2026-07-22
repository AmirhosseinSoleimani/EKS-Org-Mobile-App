import 'package:dio/dio.dart' hide Headers;
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/skill_certificate_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/skill_service_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'skills_certificates_service.g.dart';

@RestApi()
@lazySingleton
abstract class SkillsCertificatesService {
  @factoryMethod
  factory SkillsCertificatesService(Dio dio) = _SkillsCertificatesService;

  @POST('/api/SkillCertificate/GetByFilterJson')
  Future<BaseSingleResponse<SkillCertificateListModel>> getSkills(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/SkillCertificate/GetById')
  Future<BaseSingleResponse<SkillCertificateModel>> getSkillById(
    @Queries() Map<String, dynamic> query,
  );

  @POST('/api/SkillCertificate/post')
  Future<Map<String, dynamic>> createSkill(
    @Body() Map<String, dynamic> body,
  );

  @PUT('/api/SkillCertificate/put')
  Future<BaseSingleResponse<void>> editSkill(
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/api/SkillCertificate/DeleteByID')
  Future<BaseSingleResponse<void>> deleteSkill(
    @Queries() Map<String, dynamic> query,
  );

  @GET('/api/SkillCertificate/GetServices')
  Future<BaseListResponse<SkillServiceModel>> getServices(
    @Queries() Map<String, dynamic> query,
  );

  @POST('/api/SkillCertificate/SubmitServices')
  Future<Map<String, dynamic>> submitServices(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/SkillCertificate/GetByFilterJson')
  Future<BaseSingleResponse<SkillCertificateListModel>> getReport(
    @Body() Map<String, dynamic> body,
  );
}
