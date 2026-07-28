import 'package:eks_sana_plus_org/src/features/navgan/data/data_source/navgan_data_source.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_grade_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_service_category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/repository/navgan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NavganRepository)
class NavganRepositoryImpl extends NavganRepository {
  NavganRepositoryImpl(this._dataSource);

  final NavganDataSource _dataSource;

  @override
  Future<ApiResult<NavganPageEntity>> getByFilter() async {
    try {
      final result = await _dataSource.getByFilter();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<GradePatternEntity>>> getGradePatterns() async {
    try {
      final result = await _dataSource.getGradePatterns();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<GradePatternReferenceEntity>>> getGradePatternReferences(
    NavganIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getGradePatternReferences(
        param.toModel(),
      );
      return result.toApiResult<GradePatternReferenceEntity>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<GradePatternEntity>> getGradePatternById(
    NavganIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getGradePatternById(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> addGradeReference(
    NavganGradeReferenceParamEntity param,
  ) async {
    try {
      final result = await _dataSource.addGradeReference(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> deleteGradeReference(
    NavganIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.deleteGradeReference(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<NavganServiceGroupEntity>>> getServiceGroups(
    NavganIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getServiceGroups(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<NavganDefectEntity>>> getDefects(
    NavganServiceCategoryParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getDefects(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> submitServiceCategories(
    NavganIdsPayloadParamEntity param,
  ) async {
    try {
      final result = await _dataSource.submitServiceCategories(
        param.toServiceCategoriesModel(),
      );
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> submitDefects(
    NavganIdsPayloadParamEntity param,
  ) async {
    try {
      final result = await _dataSource.submitDefects(param.toDefectsModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
