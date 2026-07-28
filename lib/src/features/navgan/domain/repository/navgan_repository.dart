import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_grade_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_service_category_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class NavganRepository {
  Future<ApiResult<NavganPageEntity>> getByFilter();

  Future<ApiResult<List<GradePatternEntity>>> getGradePatterns();

  Future<ApiResult<List<GradePatternReferenceEntity>>> getGradePatternReferences(
    NavganIdParamEntity param,
  );

  Future<ApiResult<GradePatternEntity>> getGradePatternById(
    NavganIdParamEntity param,
  );

  Future<ApiResult<String>> addGradeReference(
    NavganGradeReferenceParamEntity param,
  );

  Future<ApiResult<String>> deleteGradeReference(NavganIdParamEntity param);

  Future<ApiResult<List<NavganServiceGroupEntity>>> getServiceGroups(
    NavganIdParamEntity param,
  );

  Future<ApiResult<List<NavganDefectEntity>>> getDefects(
    NavganServiceCategoryParamEntity param,
  );

  Future<ApiResult<String>> submitServiceCategories(
    NavganIdsPayloadParamEntity param,
  );

  Future<ApiResult<String>> submitDefects(NavganIdsPayloadParamEntity param);
}
