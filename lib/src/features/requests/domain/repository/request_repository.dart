import 'package:eks_sana_plus_org/src/features/requests/domain/entities/cancel_reasons_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/message_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/cancel_request_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/change_time_request_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/get_times_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/payment_type_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/payment_result_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/time_table_response_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class RequestRepository {
  Future<ApiResult<List<RequestEntity?>>> fetchActiveServiceRequestList();

  Future<ApiResult<List<RequestEntity?>>> fetchRequestHistory();

  Future<ApiResult<List<CancelReasonEntity>>> getCancelReasons(int? type);

  Future<ApiResult<MessageEntity>> cancelRequest(CancelRequestParam entity);

  Future<ApiResult<List<DayScheduleEntity?>>> getTimes(GetTimesParam param);

  Future<ApiResult<MessageEntity>> changeTimeRequest(
      ChangeTimeRequestParam changeTimeRequestEntity);

  Future<ApiResult<PaymentResultEntity>> updatePaymentType(PaymentTypeParam param);


}
