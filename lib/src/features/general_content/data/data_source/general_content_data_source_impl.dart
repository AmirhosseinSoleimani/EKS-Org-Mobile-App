import 'package:eks_sana_plus_org/src/features/general_content/data/data_source/general_content_data_source.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_page_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_target_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_form_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_id_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_target_request_model.dart';
import 'package:eks_sana_plus_org/src/features/general_content/data/service/general_content_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GeneralContentDataSource)
class GeneralContentDataSourceImpl extends GeneralContentDataSource {
  GeneralContentDataSourceImpl(this._service);

  final GeneralContentService _service;

  @override
  Future<BaseSingleResponse<GeneralContentPageModel>> getByFilter(
    GeneralContentFilterRequestModel request,
  ) {
    return _service.getByFilter(request);
  }

  @override
  Future<BaseSingleResponse<List<GeneralContentTargetModel>>> getTargets(
    GeneralContentIdRequestModel request,
  ) {
    return _service.getTargets(request);
  }

  @override
  Future<BaseSingleResponse<GeneralContentTargetModel>> addTarget(
    GeneralContentTargetRequestModel request,
  ) {
    return _service.addTarget(request);
  }

  @override
  Future<BaseSingleResponse<String>> addGeneralContent(
    GeneralContentFormRequestModel request,
  ) {
    return _service.addGeneralContent(request);
  }

  @override
  Future<BaseSingleResponse<String>> updateGeneralContent(
    GeneralContentFormRequestModel request,
  ) {
    return _service.updateGeneralContent(request);
  }

  @override
  Future<BaseSingleResponse<String>> deleteById(
    GeneralContentIdRequestModel request,
  ) {
    return _service.deleteById(request);
  }
}
