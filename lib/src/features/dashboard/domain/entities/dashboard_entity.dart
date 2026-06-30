import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_model.dart';

import 'chart_data_entity.dart';

class DashboardEntity {
  final int totalCallLogCount;
  final int totalRegisterServiceRequests;
  final int totalUrgentServiceRequest;
  final int serviceRequestEmdadgarFollowUpWithTabletCount;
  final double serviceRequestEmdadgarFollowUpWithTabletPercent;

  final List<ChartDataEntity> serviceRequestsGroupByGeneralStatus;
  final List<ChartDataEntity> openServiceRequestsGroupByRequestStatus;
  final List<ChartDataEntity> allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory;
  final List<ChartDataEntity> allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus;
  final List<ChartDataEntity> canceledServiceRequestsGroupByAssignStatus;

  const DashboardEntity({
    required this.totalCallLogCount,
    required this.totalRegisterServiceRequests,
    required this.totalUrgentServiceRequest,
    required this.serviceRequestEmdadgarFollowUpWithTabletCount,
    required this.serviceRequestEmdadgarFollowUpWithTabletPercent,
    required this.serviceRequestsGroupByGeneralStatus,
    required this.openServiceRequestsGroupByRequestStatus,
    required this.allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory,
    required this.allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus,
    required this.canceledServiceRequestsGroupByAssignStatus,
  });

  DashboardEntity copyWith({
    int? totalCallLogCount,
    int? totalRegisterServiceRequests,
    int? totalUrgentServiceRequest,
    int? serviceRequestEmdadgarFollowUpWithTabletCount,
    double? serviceRequestEmdadgarFollowUpWithTabletPercent,
    List<ChartDataEntity>? serviceRequestsGroupByGeneralStatus,
    List<ChartDataEntity>? openServiceRequestsGroupByRequestStatus,
    List<ChartDataEntity>? allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory,
    List<ChartDataEntity>? allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus,
    List<ChartDataEntity>? canceledServiceRequestsGroupByAssignStatus,
  }) {
    return DashboardEntity(
      totalCallLogCount: totalCallLogCount ?? this.totalCallLogCount,
      totalRegisterServiceRequests: totalRegisterServiceRequests ?? this.totalRegisterServiceRequests,
      totalUrgentServiceRequest: totalUrgentServiceRequest ?? this.totalUrgentServiceRequest,
      serviceRequestEmdadgarFollowUpWithTabletCount: serviceRequestEmdadgarFollowUpWithTabletCount ?? this.serviceRequestEmdadgarFollowUpWithTabletCount,
      serviceRequestEmdadgarFollowUpWithTabletPercent:
          serviceRequestEmdadgarFollowUpWithTabletPercent ?? this.serviceRequestEmdadgarFollowUpWithTabletPercent,
      serviceRequestsGroupByGeneralStatus: serviceRequestsGroupByGeneralStatus ?? this.serviceRequestsGroupByGeneralStatus,
      openServiceRequestsGroupByRequestStatus: openServiceRequestsGroupByRequestStatus ?? this.openServiceRequestsGroupByRequestStatus,
      allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory:
          allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory ?? this.allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory,
      allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus:
          allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus ?? this.allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus,
      canceledServiceRequestsGroupByAssignStatus:
          canceledServiceRequestsGroupByAssignStatus ?? this.canceledServiceRequestsGroupByAssignStatus,
    );
  }

  DashboardModel toModel() {
    return DashboardModel(
      totalCallLogCount: totalCallLogCount,
      totalRegisterServiceRequests: totalRegisterServiceRequests,
      totalUrgentServiceRequest: totalUrgentServiceRequest,
      serviceRequestEmdadgarFollowUpWithTabletCount: serviceRequestEmdadgarFollowUpWithTabletCount,
      serviceRequestEmdadgarFollowUpWithTabletPercent: serviceRequestEmdadgarFollowUpWithTabletPercent,
      serviceRequestsGroupByGeneralStatus: serviceRequestsGroupByGeneralStatus.map((e) => e.toModel()).toList(),
      openServiceRequestsGroupByRequestStatus: openServiceRequestsGroupByRequestStatus.map((e) => e.toModel()).toList(),
      allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory:
          allowdCancelationOrClosedServiceRequestsGroupByGivenServiceCategory.map((e) => e.toModel()).toList(),
      allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus:
          allowdCancelationOrClosedServiceRequestsGroupByGeneralStatus.map((e) => e.toModel()).toList(),
      canceledServiceRequestsGroupByAssignStatus:
          canceledServiceRequestsGroupByAssignStatus.map((e) => e.toModel()).toList(),
    );
  }
}
