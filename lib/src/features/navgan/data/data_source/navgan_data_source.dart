import 'package:eks_sana_plus_org/src/features/navgan/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/grade_pattern_reference_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_defect_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_page_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_service_group_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_grade_reference_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_ids_payload_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_service_category_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class NavganDataSource {
  Future<BaseSingleResponse<NavganPageModel>> getByFilter();

  Future<BaseSingleResponse<List<GradePatternModel>>> getGradePatterns();

  Future<BaseListResponse<GradePatternReferenceModel>> getGradePatternReferences(
    NavganIdRequestModel request,
  );

  Future<BaseSingleResponse<GradePatternModel>> getGradePatternById(
    NavganIdRequestModel request,
  );

  Future<BaseSingleResponse<String>> addGradeReference(
    NavganGradeReferenceRequestModel request,
  );

  Future<BaseSingleResponse<String>> deleteGradeReference(
    NavganIdRequestModel request,
  );

  Future<BaseSingleResponse<List<NavganServiceGroupModel>>> getServiceGroups(
    NavganIdRequestModel request,
  );

  Future<BaseSingleResponse<List<NavganDefectModel>>> getDefects(
    NavganServiceCategoryRequestModel request,
  );

  Future<BaseSingleResponse<String>> submitServiceCategories(
    NavganIdsPayloadRequestModel request,
  );

  Future<BaseSingleResponse<String>> submitDefects(
    NavganIdsPayloadRequestModel request,
  );
}
