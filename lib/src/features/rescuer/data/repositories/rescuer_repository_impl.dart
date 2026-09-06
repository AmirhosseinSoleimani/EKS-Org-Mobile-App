import 'package:eks_sana_plus_org/src/features/rescuer/data/data_sources/rescuer_data_source.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/add_rescuer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/delete_rescuer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/add_rescuer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuer_report_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuers_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/submit_skill_certificates_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/san_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/submit_skill_certificates_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RescuerRepository)
class RescuerRepositoryImpl extends RescuerRepository {
  final RescuerDataSource _dataSource;

  RescuerRepositoryImpl(this._dataSource);


  @override
  Future<ApiResult<AddRescuerResponseEntity>> addRescuer(AddRescuerParamEntity param) async {
    try {
      final response = await _dataSource.addRescuer(param.toModel());
      return response.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<RescuerEntity>>> getRescuers(
    GetRescuersParamEntity param,
  ) async {
    try {
      final response = await _dataSource.getRescuers(param.toModel());
      return response.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<RescuerEntity>>> getRescuerReport(
    GetRescuerReportParamEntity param,
  ) async {
    try {
      final response = await _dataSource.getRescuerReport(param.toModel());
      return response.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<RescuerEntity>> getRescuerById(int id) async {
    try {
      final response = await _dataSource.getRescuerById(id);
      return response.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<SkillCertificateEntity>>> getSkillCertificates(
    int id,
  ) async {
    try {
      final response = await _dataSource.getSkillCertificates(id);
      return response.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<SubmitSkillCertificatesResponseEntity>>
      submitSkillCertificates(SubmitSkillCertificatesParamEntity param) async {
    try {
      final response = await _dataSource.submitSkillCertificates(
        param.toModel(),
      );
      return response.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<List<SanHistoryEntity>>> getHistory(int id) async {
    try {
      final response = await _dataSource.getHistory(id);
      return response.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }

  @override
  Future<ApiResult<DeleteRescuerResponseEntity>> deleteRescuer(int id) async {
    try {
      final response = await _dataSource.deleteRescuer(id);
      return response.toApiResult();
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
