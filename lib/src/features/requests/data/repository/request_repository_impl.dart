import 'package:eks_sana_plus_org/src/features/requests/data/remote/data_source/request_history_data_source.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/cancel_reasons_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/message_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/cancel_request_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/change_time_request_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/get_times_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/payment_type_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/payment_result_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/time_table_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RequestRepository)
class RequestRepositoryImpl extends RequestRepository {
  final RequestDataSource _dataSource;

  RequestRepositoryImpl(
      this._dataSource,
      );

  @override
  Future<ApiResult<List<RequestEntity?>>> fetchRequestHistory() async{
    try {
      final result = await _dataSource.fetchRequestHistory();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<CancelReasonEntity>>> getCancelReasons(
      int? type) async {
    try {
      final result = await _dataSource.getCancelReasonsList(type);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<MessageEntity>> cancelRequest(
      CancelRequestParam entity) async {
    try {
      final result = await _dataSource.cancelRequest(entity.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<DayScheduleEntity?>>> getTimes(
      GetTimesParam param) async {
    try {
      final result = await _dataSource.getTimes(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<MessageEntity>> changeTimeRequest(
      ChangeTimeRequestParam changeTimeRequestEntity) async {
    try {
      final result = await _dataSource.changeTime(changeTimeRequestEntity.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<RequestEntity?>>> fetchActiveServiceRequestList() async {
    try {
      final result = await _dataSource.fetchActiveServiceRequestList();
      return result.toApiResultList();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<PaymentResultEntity>> updatePaymentType(
      PaymentTypeParam param) async {
    try {
      final result = await _dataSource.updatePaymentType(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
