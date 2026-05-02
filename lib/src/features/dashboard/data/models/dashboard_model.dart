import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';

import 'chart_data_model.dart';

class DashboardModel extends DashboardEntity {


  const DashboardModel({
    required super.totalCallLogCount,
    required super.totalRegisterServiceRequests,
    required super.totalUrgentServiceRequest,
    required super.serviceRequestEmdadgarFollowUpWithTabletCount,
    required super.serviceRequestEmdadgarFollowUpWithTabletPercent,
    required super.serviceRequestsGroupByGeneralStatus,
    required super.openServiceRequestsGroupByRequestStatus,
    required super.allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory,
    required super.allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus,
    required super.canceledServiceRequestsGroupByAssignStatus,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalCallLogCount: json['tootalCallLogCount'] ?? 0,
      totalRegisterServiceRequests: json['totalRegisterServiceRequest'] ?? 0,
      totalUrgentServiceRequest: json['totalUrgentServiceRequest'] ?? 0,
      serviceRequestEmdadgarFollowUpWithTabletCount: json['serviceRequestEmdadgarFollowUpWithTabletCount'] ?? 0,
      serviceRequestEmdadgarFollowUpWithTabletPercent: (json['serviceRequestEmdadgarFollowUpWithTabletPercent'] ?? 0).toDouble(),

      serviceRequestsGroupByGeneralStatus: (json['serviceRequestsGroupByGeneralStatus'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),

      openServiceRequestsGroupByRequestStatus: (json['openServiceRequestsGroupByRequestStatus'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),

      allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory: (json['allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),

      allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus: (json['allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),

      canceledServiceRequestsGroupByAssignStatus: (json['canceledServiceRequestsGroupByAssignStatus'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),
    );
  }
}
