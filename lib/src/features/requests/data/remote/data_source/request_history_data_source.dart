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
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';


abstract class RequestDataSource {
  Future<BaseListResponse<RequestModel?>> fetchRequestHistory();
  Future<BaseListResponse<CancelReasonModel>> getCancelReasonsList(
      int? type);
  Future<BaseSingleResponse<MessageModel?>> cancelRequest(
      CancelRequestParamModel params);

  Future<BaseListResponse<DayScheduleModel?>> getTimes(
      GetTimesParamModel? model);

  Future<BaseSingleResponse<MessageModel>> changeTime(
      ChangeTimeRequestParamModel model);

  Future<BaseListResponse<ActiveRequestModel?>> fetchActiveServiceRequestList();

  Future<BaseSingleResponse<PaymentResultModel?>> updatePaymentType(PaymentTypeParamModel param);
}
