import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_target_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_target_param_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class GeneralContentRepository {
  Future<ApiResult<GeneralContentPageEntity>> getByFilter(
    GeneralContentFilterParamEntity param,
  );

  Future<ApiResult<List<GeneralContentTargetEntity>>> getTargets(
    GeneralContentIdParamEntity param,
  );

  Future<ApiResult<GeneralContentTargetEntity>> addTarget(
    GeneralContentTargetParamEntity param,
  );

  Future<ApiResult<String>> addGeneralContent(
    GeneralContentFormParamEntity param,
  );

  Future<ApiResult<String>> updateGeneralContent(
    GeneralContentFormParamEntity param,
  );

  Future<ApiResult<String>> deleteById(GeneralContentIdParamEntity param);
}
