import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';

class IndicatorReportModel extends IndicatorReportEntity {
  const IndicatorReportModel({
    required super.serviceRequestEmdadgarFollowUpWithTabletPercent,
    required super.serviceRequestEmdadgarFollowUpWithTabletCount,
    required super.allActiveEmdadgars,
    required super.totalLackofCooperationWithGreaterThanZeroWeightCount,
    required super.totalLackofCooperationCount,
    required super.lackofCooperationPercent,
    required super.sumLackofCooperationsWithGreaterThanZireoWeight,
    required super.serviceRequestCategoriesPercent,
    required super.totalAllAllowdCancelationOrClosedServiceRequestsCount,
    required super.allCancelationServiceRequestCount,
    required super.totalAllNotAllowdCancelationServiceRequestCount,
    required super.allBeforeAssignCancelationServiceRequestCount,
    required super.totalAllAllowdCancelationServiceRequestCount,
    required super.totalCompeletedServiceRequestCount,
    required super.totalServiceRequestHaveAssignDateCount,
    required super.totalRegisterServiceRequest,
    required super.totalUrgentServiceRequest,
    required super.totalNotProceededServiceRequest,
    required super.averageServiceRequestInsertDateToCallLogAnswerDate,
    required super.averageServiceRequestInsertDateToEntryPageDate,
    required super.averageServiceRequestAssignToInsertDate,
    required super.averageServiceRequestAssignEmdadgarArriveDateTime,
    required super.averageServiceRequestAddressLinkCompleteDate,
    required super.averageServiceRequestAddressLinkCompleteDateHasAssignDate,
    required super.totalIntraNetworkActiveNavganCount,
    required super.totalIntraNetworkServiceRequestCount,
    required super.tootalCallLogCount,
    required super.serviceRequestAverageInsertDateToAssingEmdadgarAssignDate,
    required super.serviceRequestEmdadgarInvoicedWithTabletCount,
    required super.serviceRequestEmdadgarInvoicedWithTabletPercent,
    required super.totalHamlAzadServiceRequestCount,
    required super.totalHamlAzadServiceRequestPercent,
  });

  factory IndicatorReportModel.fromJson(Map<String, dynamic> json) {
    return IndicatorReportModel(
      serviceRequestEmdadgarFollowUpWithTabletPercent:
      (json['serviceRequestEmdadgarFollowUpWithTabletPercent'] as num).toDouble(),
      serviceRequestEmdadgarFollowUpWithTabletCount:
      json['serviceRequestEmdadgarFollowUpWithTabletCount'] as int,
      allActiveEmdadgars: json['allActiveEmdadgars'] as int,
      totalLackofCooperationWithGreaterThanZeroWeightCount:
      json['totalLackofCooperationWithGreaterThanZeroWeightCount'] as int,
      totalLackofCooperationCount: json['totalLackofCooperationCount'] as int,
      lackofCooperationPercent: (json['lackofCooperationPercent'] as num).toDouble(),
      sumLackofCooperationsWithGreaterThanZireoWeight:
      (json['sumLackofCooperationsWithGreaterThanZireoWeight'] as num).toDouble(),
      serviceRequestCategoriesPercent: json['serviceRequestCategoriesPercent'] as String,
      totalAllAllowdCancelationOrClosedServiceRequestsCount:
      json['totalAllAllowdCancelationOrClosedServiceRequestsCount'] as int,
      allCancelationServiceRequestCount: json['allCancelationServiceRequestCount'] as int,
      totalAllNotAllowdCancelationServiceRequestCount:
      json['totalAllNotAllowdCancelationServiceRequestCount'] as int,
      allBeforeAssignCancelationServiceRequestCount:
      json['allBeforeAssignCancelationServiceRequestCount'] as int,
      totalAllAllowdCancelationServiceRequestCount:
      json['totalAllAllowdCancelationServiceRequestCount'] as int,
      totalCompeletedServiceRequestCount: json['totalCompeletedServiceRequestCount'] as int,
      totalServiceRequestHaveAssignDateCount:
      json['totalServiceRequestHaveAssignDateCount'] as int,
      totalRegisterServiceRequest: json['totalRegisterServiceRequest'] as int,
      totalUrgentServiceRequest: json['totalUrgentServiceRequest'] as int,
      totalNotProceededServiceRequest: json['totalNotProceededServiceRequest'] as String,
      averageServiceRequestInsertDateToCallLogAnswerDate:
      json['averageServiceRequestInsertDateToCallLogAnswerDate'] as String,
      averageServiceRequestInsertDateToEntryPageDate:
      json['averageServiceRequestInsertDateToEntryPageDate'] as String,
      averageServiceRequestAssignToInsertDate:
      json['averageServiceRequestAssignToInsertDate'] as String,
      averageServiceRequestAssignEmdadgarArriveDateTime:
      json['averageServiceRequestAssignEmdadgarArriveDateTime'] as String,
      averageServiceRequestAddressLinkCompleteDate:
      json['averageServiceRequestAddressLinkCompleteDate'] as String,
      averageServiceRequestAddressLinkCompleteDateHasAssignDate:
      json['averageServiceRequestAddressLinkCompleteDateHasAssignDate'] as String,
      totalIntraNetworkActiveNavganCount: json['totalIntraNetworkActiveNavganCount'] as int,
      totalIntraNetworkServiceRequestCount:
      json['totalIntraNetworkServiceRequestCount'] as int,
      tootalCallLogCount: json['tootalCallLogCount'] as String,
      serviceRequestAverageInsertDateToAssingEmdadgarAssignDate:
      json['serviceRequestAverageInsertDateToAssingEmdadgarAssignDate'] as String,
      serviceRequestEmdadgarInvoicedWithTabletCount:
      json['serviceRequestEmdadgarInvoicedWithTabletCount'] as int,
      serviceRequestEmdadgarInvoicedWithTabletPercent:
      (json['serviceRequestEmdadgarInvoicedWithTabletPercent'] as num).toDouble(),
      totalHamlAzadServiceRequestCount: json['totalHamlAzadServiceRequestCount'] as int,
      totalHamlAzadServiceRequestPercent:
      (json['totalHamlAzadServiceRequestPercent'] as num).toDouble(),
    );
  }
}
