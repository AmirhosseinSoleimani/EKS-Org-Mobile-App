import 'package:eks_sana_plus_org/src/features/general_content/data/data_source/general_content_data_source.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_target_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_target_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/repository/general_content_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GeneralContentRepository)
class GeneralContentRepositoryImpl extends GeneralContentRepository {
  GeneralContentRepositoryImpl(this._dataSource);

  final GeneralContentDataSource _dataSource;

  @override
  Future<ApiResult<GeneralContentPageEntity>> getByFilter(
    GeneralContentFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getByFilter(
        GeneralContentFilterRequestModel.fromParam(param),
      );
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<GeneralContentTargetEntity>>> getTargets(
    GeneralContentIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getTargets(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<GeneralContentTargetEntity>> addTarget(
    GeneralContentTargetParamEntity param,
  ) async {
    try {
      final result = await _dataSource.addTarget(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> addGeneralContent(
    GeneralContentFormParamEntity param,
  ) async {
    try {
      final result = await _dataSource.addGeneralContent(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> updateGeneralContent(
    GeneralContentFormParamEntity param,
  ) async {
    try {
      final result = await _dataSource.updateGeneralContent(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<String>> deleteById(
    GeneralContentIdParamEntity param,
  ) async {
    try {
      final result = await _dataSource.deleteById(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
