import 'package:eks_sana_plus_org/src/features/navgan/data/data_source/navgan_data_source.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/grade_pattern_reference_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_defect_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_page_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_service_group_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/grade_pattern_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_grade_reference_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_ids_payload_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_service_category_request_model.dart';
import 'package:eks_sana_plus_org/src/features/navgan/data/service/navgan_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NavganDataSource)
class NavganDataSourceImpl extends NavganDataSource {
  NavganDataSourceImpl(this._service);

  final NavganService _service;

  @override
  Future<BaseSingleResponse<NavganPageModel>> getByFilter() {
    return _service.getByFilter();
  }

  @override
  Future<BaseSingleResponse<List<GradePatternModel>>> getGradePatterns() {
    return _service.getGradePatterns(const GradePatternFilterRequestModel());
  }

  @override
  Future<BaseListResponse<GradePatternReferenceModel>> getGradePatternReferences(
    NavganIdRequestModel request,
  ) {
    return _service.getGradePatternReferences(request);
  }

  @override
  Future<BaseSingleResponse<GradePatternModel>> getGradePatternById(
    NavganIdRequestModel request,
  ) {
    return _service.getGradePatternById(request);
  }

  @override
  Future<BaseSingleResponse<String>> addGradeReference(
    NavganGradeReferenceRequestModel request,
  ) {
    return _service.addGradeReference(request);
  }

  @override
  Future<BaseSingleResponse<String>> deleteGradeReference(
    NavganIdRequestModel request,
  ) {
    return _service.deleteGradeReference(request);
  }

  @override
  Future<BaseSingleResponse<List<NavganServiceGroupModel>>> getServiceGroups(
    NavganIdRequestModel request,
  ) {
    return _service.getServiceGroups(request);
  }

  @override
  Future<BaseSingleResponse<List<NavganDefectModel>>> getDefects(
    NavganServiceCategoryRequestModel request,
  ) {
    return _service.getDefects(request);
  }

  @override
  Future<BaseSingleResponse<String>> submitServiceCategories(
    NavganIdsPayloadRequestModel request,
  ) {
    return _service.submitServiceCategories(request);
  }

  @override
  Future<BaseSingleResponse<String>> submitDefects(
    NavganIdsPayloadRequestModel request,
  ) {
    return _service.submitDefects(request);
  }
}
