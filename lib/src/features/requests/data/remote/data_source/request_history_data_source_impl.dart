import 'package:eks_sana_plus_org/src/features/requests/data/models/active_request_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/cancel_reason_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/message_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/params/cancel_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/params/change_time_request_param_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/params/get_times_param_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/params/payment_type_param_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/payment_result_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/request_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/models/time_table_response_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/data/remote/service/request_history_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

import 'request_history_data_source.dart';

@LazySingleton(as: RequestDataSource)
class RequestHistoryDataSourceImpl extends RequestDataSource {
  final RequestService _service;
  RequestHistoryDataSourceImpl(this._service);

  @override
  Future<BaseListResponse<RequestModel?>> fetchRequestHistory() async =>
      await _service.fetchRequestHistory({});

  @override
  Future<BaseListResponse<CancelReasonModel>> getCancelReasonsList(
          int? type) async =>
      await _service.getCancelReasonsList({"serviceType": type});

  @override
  Future<BaseSingleResponse<MessageModel?>> cancelRequest(
          CancelRequestParamModel params) async =>
      await _service.cancelRequest(params.toJson());

  @override
  Future<BaseSingleResponse<MessageModel>> changeTime(
      ChangeTimeRequestParamModel model) async {
    return _service.changeTime(model.toJson());
  }

  @override
  Future<BaseListResponse<DayScheduleModel?>> getTimes(
      GetTimesParamModel? model) async {
    return  await _service.getTimes(model?.toJson()??{});
  }

  @override
  Future<BaseListResponse<ActiveRequestModel?>>
      fetchActiveServiceRequestList() async {
    final result = await _service.fetchActiveServiceRequestList({});
    return result;
  }

  @override
  Future<BaseSingleResponse<PaymentResultModel>> updatePaymentType(
      PaymentTypeParamModel param) async {
    return await _service.updatePaymentType(param.toJson());
  }
}
