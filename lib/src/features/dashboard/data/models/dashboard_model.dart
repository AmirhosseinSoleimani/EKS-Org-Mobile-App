import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';

import 'chart_data_model.dart';

class DashboardModel extends DashboardEntity {


  const DashboardModel({
    required super.totalCallLogCount,
    required super.totalServiceRequests,
    required super.totalUrgentRequests,
    required super.followUpTabletCount,
    required super.followUpTabletPercent,
    required super.generalStatus,
    required super.openRequestsStatus,
    required super.closedOrCanceledByCategory,
    required super.closedOrCanceledByStatus,
    required super.canceledByAssignStatus,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalCallLogCount: json['totalCallLogCount'] ?? 0,
      totalServiceRequests: json['totalServiceRequests'] ?? 0,
      totalUrgentRequests: json['totalUrgentRequests'] ?? 0,
      followUpTabletCount: json['serviceRequestEmdadgarFollowUpWithTabletCount'] ?? 0,
      followUpTabletPercent: (json['serviceRequestEmdadgarFollowUpWithTabletPercent'] ?? 0).toDouble(),

      generalStatus: (json['serviceRequestsGroupByGeneralStatus'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),

      openRequestsStatus: (json['openServiceRequestsGroupByRequestStatus'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),

      closedOrCanceledByCategory: (json['allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),

      closedOrCanceledByStatus: (json['allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),

      canceledByAssignStatus: (json['canceledServiceRequestsGroupByAssignStatus'] as List<dynamic>)
          .map((e) => ChartDataModel.fromJson(e))
          .toList(),
    );
  }
}
