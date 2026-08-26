import 'package:eks_sana_plus_org/src/features/grade_pattern/data/data_sources/grade_pattern_data_source.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/repositories/grade_pattern_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GradePatternRepository)
class GradePatternRepositoryImpl extends GradePatternRepository {
  GradePatternRepositoryImpl(this._dataSource);

  final GradePatternDataSource _dataSource;

  @override
  Future<ApiResult<GradePatternPageEntity>> getByFilter(
    GradePatternFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getByFilter(param.toModel());
      return result.toApiResult<GradePatternPageEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<GradePatternEntity>> getById(int id) async {
    try {
      final result = await _dataSource.getById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<GradePatternEntity>> create(
    GradePatternEntity param,
  ) async {
    try {
      final result = await _dataSource.create(param.toModel().toJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<GradePatternEntity>> update(
    GradePatternEntity param,
  ) async {
    try {
      final result = await _dataSource.update(param.toModel().toJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> deleteById(int id) async {
    try {
      final result = await _dataSource.deleteById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<GradePatternReferenceEntity>>> getReferences({
    required int refId,
  }) async {
    try {
      final request = GradePatternFilterRequestModel(
        pageSize: 1000,
        filters: [
          GradePatternFilterModel(
            field: 'Ref_Id',
            value: refId.toString(),
            operator: 'eq',
          ),
          const GradePatternFilterModel(
            field: 'isActive',
            value: 'true',
            operator: 'eq',
          ),
        ],
      );
      final result = await _dataSource.referenceGetByFilter(request);
      return result.toApiResult<GradePatternReferenceEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> assignReference(
    GradePatternReferenceParamEntity param,
  ) async {
    try {
      final result = await _dataSource.referencePost(param.toJson());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> deleteReferenceById(int id) async {
    try {
      final result = await _dataSource.referenceDeleteById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
