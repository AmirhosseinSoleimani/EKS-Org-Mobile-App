import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_page_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_target_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_target_request_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class GeneralContentDataSource {
  Future<BaseSingleResponse<GeneralContentPageModel>> getByFilter(
    GeneralContentFilterRequestModel request,
  );

  Future<BaseSingleResponse<List<GeneralContentTargetModel>>> getTargets(
    GeneralContentIdRequestModel request,
  );

  Future<BaseSingleResponse<GeneralContentTargetModel>> addTarget(
    GeneralContentTargetRequestModel request,
  );

  Future<BaseSingleResponse<String>> addGeneralContent(
    GeneralContentFormRequestModel request,
  );

  Future<BaseSingleResponse<String>> updateGeneralContent(
    GeneralContentFormRequestModel request,
  );

  Future<BaseSingleResponse<String>> deleteById(
    GeneralContentIdRequestModel request,
  );
}
