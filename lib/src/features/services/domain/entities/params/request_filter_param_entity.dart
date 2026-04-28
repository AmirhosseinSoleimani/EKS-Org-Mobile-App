import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_filter_param_model.dart';

class RequestFilterParamEntity {
  final String? serviceRequestId;
  final String? callMobileNumber;
  final String? chassisNumber;
  final String? cityName;
  final String? provinceName;
  final String? rescuerName;
  final RequestStatus requestStatus;
  final TimePeriod? timePeriod;
  final int pageSize;
  final int page;

  const RequestFilterParamEntity({
    this.serviceRequestId,
    this.callMobileNumber,
    this.chassisNumber,
    this.rescuerName,
    this.cityName,
    this.provinceName,
    this.requestStatus = RequestStatus.openRequests,
    this.timePeriod,
    this.page = 1,
    this.pageSize = 20,
  });

  RequestFilterParamEntity copyWith({
    String? serviceRequestId,
    String? callMobileNumber,
    String? chassisNumber,
    String? rescuerName,
    String? cityName,
    String? provinceName,
    RequestStatus? requestStatus,
    TimePeriod? timePeriod,
    int? page,
    int? pageSize,
  }) {
    return RequestFilterParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      callMobileNumber: callMobileNumber ?? this.callMobileNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      rescuerName: rescuerName ?? this.rescuerName,
      cityName: cityName ?? this.cityName,
      provinceName: provinceName ?? this.provinceName,
      requestStatus: requestStatus ?? this.requestStatus,
      timePeriod: timePeriod ?? this.timePeriod,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  RequestFilterParamModel toModel() {
    return RequestFilterParamModel(
      serviceRequestId: serviceRequestId,
      callMobileNumber: callMobileNumber,
      chassisNumber: chassisNumber,
      rescuerName: rescuerName,
      cityName: cityName,
      provinceName: provinceName,
      requestStatus: requestStatus,
      timePeriod: timePeriod,
      pageSize: pageSize,
      page: page,
    );
  }
}
