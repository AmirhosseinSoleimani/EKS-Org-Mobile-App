import 'package:eks_sana_plus_org/src/features/grade_pattern/data/data_sources/grade_pattern_data_source.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_page_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_reference_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/services/grade_pattern_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GradePatternDataSource)
class GradePatternDataSourceImpl extends GradePatternDataSource {
  GradePatternDataSourceImpl(this._service);

  final GradePatternService _service;

  @override
  Future<BaseSingleResponse<GradePatternPageModel>> getByFilter(
    GradePatternFilterRequestModel request,
  ) {
    return _service.getByFilter(request);
  }

  @override
  Future<BaseSingleResponse<GradePatternModel>> getById(int id) {
    return _service.getById(id);
  }

  @override
  Future<BaseSingleResponse<GradePatternModel>> create(
    Map<String, dynamic> body,
  ) {
    return _service.create(body);
  }

  @override
  Future<BaseSingleResponse<GradePatternModel>> update(
    Map<String, dynamic> body,
  ) {
    return _service.update(body);
  }

  @override
  Future<BaseResponse> deleteById(int id) {
    return _service.deleteById(id);
  }

  @override
  Future<BaseListResponse<GradePatternReferenceModel>> referenceGetByFilter(
    GradePatternFilterRequestModel request,
  ) {
    return _service.referenceGetByFilter(request);
  }

  @override
  Future<BaseResponse> referencePost(Map<String, dynamic> body) {
    return _service.referencePost(body);
  }

  @override
  Future<BaseResponse> referenceDeleteById(int id) {
    return _service.referenceDeleteById(id);
  }
}
