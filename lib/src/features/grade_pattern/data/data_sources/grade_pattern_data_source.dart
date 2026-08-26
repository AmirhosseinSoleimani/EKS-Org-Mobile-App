import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_page_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_reference_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class GradePatternDataSource {
  Future<BaseSingleResponse<GradePatternPageModel>> getByFilter(
    GradePatternFilterRequestModel request,
  );

  Future<BaseSingleResponse<GradePatternModel>> getById(int id);

  Future<BaseSingleResponse<GradePatternModel>> create(
    Map<String, dynamic> body,
  );

  Future<BaseSingleResponse<GradePatternModel>> update(
    Map<String, dynamic> body,
  );

  Future<BaseResponse> deleteById(int id);

  Future<BaseListResponse<GradePatternReferenceModel>> referenceGetByFilter(
    GradePatternFilterRequestModel request,
  );

  Future<BaseResponse> referencePost(Map<String, dynamic> body);

  Future<BaseResponse> referenceDeleteById(int id);
}
