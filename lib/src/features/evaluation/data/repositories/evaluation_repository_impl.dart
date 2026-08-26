import 'package:eks_sana_plus_org/src/features/evaluation/data/remote/data_sources/evaluation_remote_data_source.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/accept_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/RepresentationParamEntity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/aid_service_evaluation_submit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/home_service_package_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/labor_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/last_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_marks_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_price_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_price_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/post_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/representation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_package_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EvaluationRepository)
class EvaluationRepositoryImpl extends EvaluationRepository {
  final EvaluationRemoteDataSource _remoteDataSource;

  EvaluationRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<DefectEntity>>> getDefectsList(
      int? serviceRequestId,
      ) async {
    try {
      final result = await _remoteDataSource.getDefectsList(
        serviceRequestId,
      );
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<ServiceCategoryEntity>>> getServiceCategoryList(
      CategoryParamEntity param,
      ) async {
    try {
      final result = await _remoteDataSource
          .getServiceCategoryList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ServiceResponseEntity>> getAidServices(
      ServicesParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .getAidServices(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PostEvaluationResponseEntity>> postEvaluation(ServiceEvaluationParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .postEvaluation(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> acceptEvaluation(AcceptEvaluationParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .acceptEvaluation(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> acceptInvoiceOperatorEvaluation(
    AcceptEvaluationParamEntity param,
  ) async {
    try {
      final result = await _remoteDataSource.acceptInvoiceOperatorEvaluation(
        param.toModel(),
      );
      return result.toApiResult<void>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> acceptHesabdariAmendment(
    AcceptEvaluationParamEntity param,
  ) async {
    try {
      final result = await _remoteDataSource.acceptHesabdariAmendment(
        param.toModel(),
      );
      return result.toApiResult<void>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> acceptDaraeiAmendment(
    AcceptEvaluationParamEntity param,
  ) async {
    try {
      final result = await _remoteDataSource.acceptDaraeiAmendment(
        param.toModel(),
      );
      return result.toApiResult<void>();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<EmdadgarServiceDetailEntity>> getServiceDetailAndCheckSubscriptionForEmdagar(ServiceDetailForEvaluationParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .getServiceDetailAndCheckSubscriptionForEmdagar(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<LaborEntity>>> getLaborList(LaborListParamEntity param) async {
    try {
      final result = await _remoteDataSource.getLaborList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PartEntity>>> getPartList(PartListParamEntity param) async {
    try {
      final result = await _remoteDataSource.getPartList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<ServicePackageEntity>>> getHomeServicePackage(HomeServicePackageParamEntity param) async {
    try {
      final result = await _remoteDataSource.getHomeServicePackage(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<PartMarkEntity>>> getPartMarks(PartMarksParamEntity param) async {
    try {
      final result = await _remoteDataSource.getPartMarks(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PartPriceEntity>> getPartPrice(
      PartPriceParamEntity param) async {
    try {
      final result = await _remoteDataSource.getPartPrice(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<ResponseLastEvaluationEntity>> getLastEvaluation(
      LastEvaluationParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .getLastEvaluation(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<
      ApiResult<PostEvaluationResponseEntity>> submitEvaluationForAidService(
      AidServiceEvaluationSubmitParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .submitEvaluationForAidService(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<RepresentationEntity>>> getRepresentationList(RepresentationParamEntity param) async {
    try {
      final result = await _remoteDataSource
          .getRepresentationList(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
  @override
  Future<ApiResult<PostEvaluationResponseEntity>> submitTrackerEvaluation(
    AidServiceEvaluationSubmitParamEntity param,
  ) async {
    try {
      final result = await _remoteDataSource.submitTrackerEvaluation(
        param.toModel(),
      );
      return _mapDynamicEvaluationResult(result);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PostEvaluationResponseEntity>> submitInvoiceOperatorEvaluation(
    AidServiceEvaluationSubmitParamEntity param,
  ) async {
    try {
      final result = await _remoteDataSource.submitInvoiceOperatorEvaluation(
        param.toModel(),
      );
      return _mapDynamicEvaluationResult(result);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PostEvaluationResponseEntity>> submitHesabdariEvaluation(
    AidServiceEvaluationSubmitParamEntity param,
  ) async {
    try {
      final result = await _remoteDataSource.submitHesabdariEvaluation(
        param.toModel(),
      );
      return _mapDynamicEvaluationResult(result);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PostEvaluationResponseEntity>> submitDaraeiEvaluation(
    AidServiceEvaluationSubmitParamEntity param,
  ) async {
    try {
      final result = await _remoteDataSource.submitDaraeiEvaluation(
        param.toModel(),
      );
      return _mapDynamicEvaluationResult(result);
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  ApiResult<PostEvaluationResponseEntity> _mapDynamicEvaluationResult(
    BaseSingleResponse<dynamic> result,
  ) {
    final mapped = result.toApiResult<dynamic>();
    return mapped.when(
      success: (data, failures, resultCode) {
        final id = _evaluationId(data);
        if (id == null || id.isEmpty || id == '0') {
          return ApiResult<PostEvaluationResponseEntity>.failure(
            failures: failures?.join('\n') ??
                'شناسه ارزیابی از پاسخ سرویس دریافت نشد.',
          );
        }
        return ApiResult<PostEvaluationResponseEntity>.success(
          data: PostEvaluationResponseEntity(id: id),
          failures: failures,
          resultCode: resultCode,
        );
      },
      failure: (error, failures) =>
          ApiResult<PostEvaluationResponseEntity>.failure(
            error: error,
            failures: failures,
          ),
      expireToken: () =>
          const ApiResult<PostEvaluationResponseEntity>.expireToken(),
      connectionError: () =>
          const ApiResult<PostEvaluationResponseEntity>.connectionError(),
    );
  }

  String? _evaluationId(dynamic data) {
    if (data == null) return null;
    if (data is Map) {
      final value = data['id'] ??
          data['Id'] ??
          data['evaluationId'] ??
          data['emdadgarEvaluationId'];
      return value?.toString();
    }
    return data.toString();
  }

}
