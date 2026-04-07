import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/indicatior_report_model.dart';

class IndicatorReportEntity {
  final double serviceRequestEmdadgarFollowUpWithTabletPercent;
  final int serviceRequestEmdadgarFollowUpWithTabletCount;
  final int allActiveEmdadgars;
  final int totalLackofCooperationWithGreaterThanZeroWeightCount;
  final int totalLackofCooperationCount;
  final double lackofCooperationPercent;
  final double sumLackofCooperationsWithGreaterThanZireoWeight;
  final String serviceRequestCategoriesPercent;
  final int totalAllAllowdCancelationOrClosedServiceRequestsCount;
  final int allCancelationServiceRequestCount;
  final int totalAllNotAllowdCancelationServiceRequestCount;
  final int allBeforeAssignCancelationServiceRequestCount;
  final int totalAllAllowdCancelationServiceRequestCount;
  final int totalCompeletedServiceRequestCount;
  final int totalServiceRequestHaveAssignDateCount;
  final int totalRegisterServiceRequest;
  final int totalUrgentServiceRequest;
  final String totalNotProceededServiceRequest;
  final String averageServiceRequestInsertDateToCallLogAnswerDate;
  final String averageServiceRequestInsertDateToEntryPageDate;
  final String averageServiceRequestAssignToInsertDate;
  final String averageServiceRequestAssignEmdadgarArriveDateTime;
  final String averageServiceRequestAddressLinkCompleteDate;
  final String averageServiceRequestAddressLinkCompleteDateHasAssignDate;
  final int totalIntraNetworkActiveNavganCount;
  final int totalIntraNetworkServiceRequestCount;
  final String tootalCallLogCount;
  final String serviceRequestAverageInsertDateToAssingEmdadgarAssignDate;
  final int serviceRequestEmdadgarInvoicedWithTabletCount;
  final double serviceRequestEmdadgarInvoicedWithTabletPercent;
  final int totalHamlAzadServiceRequestCount;
  final double totalHamlAzadServiceRequestPercent;

  const IndicatorReportEntity({
    required this.serviceRequestEmdadgarFollowUpWithTabletPercent,
    required this.serviceRequestEmdadgarFollowUpWithTabletCount,
    required this.allActiveEmdadgars,
    required this.totalLackofCooperationWithGreaterThanZeroWeightCount,
    required this.totalLackofCooperationCount,
    required this.lackofCooperationPercent,
    required this.sumLackofCooperationsWithGreaterThanZireoWeight,
    required this.serviceRequestCategoriesPercent,
    required this.totalAllAllowdCancelationOrClosedServiceRequestsCount,
    required this.allCancelationServiceRequestCount,
    required this.totalAllNotAllowdCancelationServiceRequestCount,
    required this.allBeforeAssignCancelationServiceRequestCount,
    required this.totalAllAllowdCancelationServiceRequestCount,
    required this.totalCompeletedServiceRequestCount,
    required this.totalServiceRequestHaveAssignDateCount,
    required this.totalRegisterServiceRequest,
    required this.totalUrgentServiceRequest,
    required this.totalNotProceededServiceRequest,
    required this.averageServiceRequestInsertDateToCallLogAnswerDate,
    required this.averageServiceRequestInsertDateToEntryPageDate,
    required this.averageServiceRequestAssignToInsertDate,
    required this.averageServiceRequestAssignEmdadgarArriveDateTime,
    required this.averageServiceRequestAddressLinkCompleteDate,
    required this.averageServiceRequestAddressLinkCompleteDateHasAssignDate,
    required this.totalIntraNetworkActiveNavganCount,
    required this.totalIntraNetworkServiceRequestCount,
    required this.tootalCallLogCount,
    required this.serviceRequestAverageInsertDateToAssingEmdadgarAssignDate,
    required this.serviceRequestEmdadgarInvoicedWithTabletCount,
    required this.serviceRequestEmdadgarInvoicedWithTabletPercent,
    required this.totalHamlAzadServiceRequestCount,
    required this.totalHamlAzadServiceRequestPercent,
  });

  IndicatorReportEntity copyWith({
    double? serviceRequestEmdadgarFollowUpWithTabletPercent,
    int? serviceRequestEmdadgarFollowUpWithTabletCount,
    int? allActiveEmdadgars,
    int? totalLackofCooperationWithGreaterThanZeroWeightCount,
    int? totalLackofCooperationCount,
    double? lackofCooperationPercent,
    double? sumLackofCooperationsWithGreaterThanZireoWeight,
    String? serviceRequestCategoriesPercent,
    int? totalAllAllowdCancelationOrClosedServiceRequestsCount,
    int? allCancelationServiceRequestCount,
    int? totalAllNotAllowdCancelationServiceRequestCount,
    int? allBeforeAssignCancelationServiceRequestCount,
    int? totalAllAllowdCancelationServiceRequestCount,
    int? totalCompeletedServiceRequestCount,
    int? totalServiceRequestHaveAssignDateCount,
    int? totalRegisterServiceRequest,
    int? totalUrgentServiceRequest,
    String? totalNotProceededServiceRequest,
    String? averageServiceRequestInsertDateToCallLogAnswerDate,
    String? averageServiceRequestInsertDateToEntryPageDate,
    String? averageServiceRequestAssignToInsertDate,
    String? averageServiceRequestAssignEmdadgarArriveDateTime,
    String? averageServiceRequestAddressLinkCompleteDate,
    String? averageServiceRequestAddressLinkCompleteDateHasAssignDate,
    int? totalIntraNetworkActiveNavganCount,
    int? totalIntraNetworkServiceRequestCount,
    String? tootalCallLogCount,
    String? serviceRequestAverageInsertDateToAssingEmdadgarAssignDate,
    int? serviceRequestEmdadgarInvoicedWithTabletCount,
    double? serviceRequestEmdadgarInvoicedWithTabletPercent,
    int? totalHamlAzadServiceRequestCount,
    double? totalHamlAzadServiceRequestPercent,
  }) {
    return IndicatorReportEntity(
      serviceRequestEmdadgarFollowUpWithTabletPercent:
      serviceRequestEmdadgarFollowUpWithTabletPercent ?? this.serviceRequestEmdadgarFollowUpWithTabletPercent,
      serviceRequestEmdadgarFollowUpWithTabletCount:
      serviceRequestEmdadgarFollowUpWithTabletCount ?? this.serviceRequestEmdadgarFollowUpWithTabletCount,
      allActiveEmdadgars: allActiveEmdadgars ?? this.allActiveEmdadgars,
      totalLackofCooperationWithGreaterThanZeroWeightCount:
      totalLackofCooperationWithGreaterThanZeroWeightCount ?? this.totalLackofCooperationWithGreaterThanZeroWeightCount,
      totalLackofCooperationCount: totalLackofCooperationCount ?? this.totalLackofCooperationCount,
      lackofCooperationPercent: lackofCooperationPercent ?? this.lackofCooperationPercent,
      sumLackofCooperationsWithGreaterThanZireoWeight:
      sumLackofCooperationsWithGreaterThanZireoWeight ?? this.sumLackofCooperationsWithGreaterThanZireoWeight,
      serviceRequestCategoriesPercent: serviceRequestCategoriesPercent ?? this.serviceRequestCategoriesPercent,
      totalAllAllowdCancelationOrClosedServiceRequestsCount:
      totalAllAllowdCancelationOrClosedServiceRequestsCount ?? this.totalAllAllowdCancelationOrClosedServiceRequestsCount,
      allCancelationServiceRequestCount: allCancelationServiceRequestCount ?? this.allCancelationServiceRequestCount,
      totalAllNotAllowdCancelationServiceRequestCount:
      totalAllNotAllowdCancelationServiceRequestCount ?? this.totalAllNotAllowdCancelationServiceRequestCount,
      allBeforeAssignCancelationServiceRequestCount:
      allBeforeAssignCancelationServiceRequestCount ?? this.allBeforeAssignCancelationServiceRequestCount,
      totalAllAllowdCancelationServiceRequestCount:
      totalAllAllowdCancelationServiceRequestCount ?? this.totalAllAllowdCancelationServiceRequestCount,
      totalCompeletedServiceRequestCount: totalCompeletedServiceRequestCount ?? this.totalCompeletedServiceRequestCount,
      totalServiceRequestHaveAssignDateCount:
      totalServiceRequestHaveAssignDateCount ?? this.totalServiceRequestHaveAssignDateCount,
      totalRegisterServiceRequest: totalRegisterServiceRequest ?? this.totalRegisterServiceRequest,
      totalUrgentServiceRequest: totalUrgentServiceRequest ?? this.totalUrgentServiceRequest,
      totalNotProceededServiceRequest: totalNotProceededServiceRequest ?? this.totalNotProceededServiceRequest,
      averageServiceRequestInsertDateToCallLogAnswerDate:
      averageServiceRequestInsertDateToCallLogAnswerDate ?? this.averageServiceRequestInsertDateToCallLogAnswerDate,
      averageServiceRequestInsertDateToEntryPageDate:
      averageServiceRequestInsertDateToEntryPageDate ?? this.averageServiceRequestInsertDateToEntryPageDate,
      averageServiceRequestAssignToInsertDate:
      averageServiceRequestAssignToInsertDate ?? this.averageServiceRequestAssignToInsertDate,
      averageServiceRequestAssignEmdadgarArriveDateTime:
      averageServiceRequestAssignEmdadgarArriveDateTime ?? this.averageServiceRequestAssignEmdadgarArriveDateTime,
      averageServiceRequestAddressLinkCompleteDate:
      averageServiceRequestAddressLinkCompleteDate ?? this.averageServiceRequestAddressLinkCompleteDate,
      averageServiceRequestAddressLinkCompleteDateHasAssignDate:
      averageServiceRequestAddressLinkCompleteDateHasAssignDate ?? this.averageServiceRequestAddressLinkCompleteDateHasAssignDate,
      totalIntraNetworkActiveNavganCount: totalIntraNetworkActiveNavganCount ?? this.totalIntraNetworkActiveNavganCount,
      totalIntraNetworkServiceRequestCount:
      totalIntraNetworkServiceRequestCount ?? this.totalIntraNetworkServiceRequestCount,
      tootalCallLogCount: tootalCallLogCount ?? this.tootalCallLogCount,
      serviceRequestAverageInsertDateToAssingEmdadgarAssignDate:
      serviceRequestAverageInsertDateToAssingEmdadgarAssignDate ?? this.serviceRequestAverageInsertDateToAssingEmdadgarAssignDate,
      serviceRequestEmdadgarInvoicedWithTabletCount:
      serviceRequestEmdadgarInvoicedWithTabletCount ?? this.serviceRequestEmdadgarInvoicedWithTabletCount,
      serviceRequestEmdadgarInvoicedWithTabletPercent:
      serviceRequestEmdadgarInvoicedWithTabletPercent ?? this.serviceRequestEmdadgarInvoicedWithTabletPercent,
      totalHamlAzadServiceRequestCount: totalHamlAzadServiceRequestCount ?? this.totalHamlAzadServiceRequestCount,
      totalHamlAzadServiceRequestPercent: totalHamlAzadServiceRequestPercent ?? this.totalHamlAzadServiceRequestPercent,
    );
  }

  IndicatorReportModel toModel() {
    return IndicatorReportModel(
      serviceRequestEmdadgarFollowUpWithTabletPercent: serviceRequestEmdadgarFollowUpWithTabletPercent,
      serviceRequestEmdadgarFollowUpWithTabletCount: serviceRequestEmdadgarFollowUpWithTabletCount,
      allActiveEmdadgars: allActiveEmdadgars,
      totalLackofCooperationWithGreaterThanZeroWeightCount: totalLackofCooperationWithGreaterThanZeroWeightCount,
      totalLackofCooperationCount: totalLackofCooperationCount,
      lackofCooperationPercent: lackofCooperationPercent,
      sumLackofCooperationsWithGreaterThanZireoWeight: sumLackofCooperationsWithGreaterThanZireoWeight,
      serviceRequestCategoriesPercent: serviceRequestCategoriesPercent,
      totalAllAllowdCancelationOrClosedServiceRequestsCount: totalAllAllowdCancelationOrClosedServiceRequestsCount,
      allCancelationServiceRequestCount: allCancelationServiceRequestCount,
      totalAllNotAllowdCancelationServiceRequestCount: totalAllNotAllowdCancelationServiceRequestCount,
      allBeforeAssignCancelationServiceRequestCount: allBeforeAssignCancelationServiceRequestCount,
      totalAllAllowdCancelationServiceRequestCount: totalAllAllowdCancelationServiceRequestCount,
      totalCompeletedServiceRequestCount: totalCompeletedServiceRequestCount,
      totalServiceRequestHaveAssignDateCount: totalServiceRequestHaveAssignDateCount,
      totalRegisterServiceRequest: totalRegisterServiceRequest,
      totalUrgentServiceRequest: totalUrgentServiceRequest,
      totalNotProceededServiceRequest: totalNotProceededServiceRequest,
      averageServiceRequestInsertDateToCallLogAnswerDate: averageServiceRequestInsertDateToCallLogAnswerDate,
      averageServiceRequestInsertDateToEntryPageDate: averageServiceRequestInsertDateToEntryPageDate,
      averageServiceRequestAssignToInsertDate: averageServiceRequestAssignToInsertDate,
      averageServiceRequestAssignEmdadgarArriveDateTime: averageServiceRequestAssignEmdadgarArriveDateTime,
      averageServiceRequestAddressLinkCompleteDate: averageServiceRequestAddressLinkCompleteDate,
      averageServiceRequestAddressLinkCompleteDateHasAssignDate: averageServiceRequestAddressLinkCompleteDateHasAssignDate,
      totalIntraNetworkActiveNavganCount: totalIntraNetworkActiveNavganCount,
      totalIntraNetworkServiceRequestCount: totalIntraNetworkServiceRequestCount,
      tootalCallLogCount: tootalCallLogCount,
      serviceRequestAverageInsertDateToAssingEmdadgarAssignDate: serviceRequestAverageInsertDateToAssingEmdadgarAssignDate,
      serviceRequestEmdadgarInvoicedWithTabletCount: serviceRequestEmdadgarInvoicedWithTabletCount,
      serviceRequestEmdadgarInvoicedWithTabletPercent: serviceRequestEmdadgarInvoicedWithTabletPercent,
      totalHamlAzadServiceRequestCount: totalHamlAzadServiceRequestCount,
      totalHamlAzadServiceRequestPercent: totalHamlAzadServiceRequestPercent,
    );
  }
}
