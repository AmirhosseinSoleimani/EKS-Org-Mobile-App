import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_model.dart';

import 'chart_data_entity.dart';

class DashboardEntity {
  final int totalCallLogCount;
  final int totalServiceRequests;
  final int totalUrgentRequests;
  final int followUpTabletCount;
  final double followUpTabletPercent;

  final List<ChartDataEntity> generalStatus;
  final List<ChartDataEntity> openRequestsStatus;
  final List<ChartDataEntity> closedOrCanceledByCategory;
  final List<ChartDataEntity> closedOrCanceledByStatus;
  final List<ChartDataEntity> canceledByAssignStatus;

  const DashboardEntity({
    required this.totalCallLogCount,
    required this.totalServiceRequests,
    required this.totalUrgentRequests,
    required this.followUpTabletCount,
    required this.followUpTabletPercent,
    required this.generalStatus,
    required this.openRequestsStatus,
    required this.closedOrCanceledByCategory,
    required this.closedOrCanceledByStatus,
    required this.canceledByAssignStatus,
  });

  DashboardEntity copyWith({
    int? totalCallLogCount,
    int? totalServiceRequests,
    int? totalUrgentRequests,
    int? followUpTabletCount,
    double? followUpTabletPercent,
    List<ChartDataEntity>? generalStatus,
    List<ChartDataEntity>? openRequestsStatus,
    List<ChartDataEntity>? closedOrCanceledByCategory,
    List<ChartDataEntity>? closedOrCanceledByStatus,
    List<ChartDataEntity>? canceledByAssignStatus,
  }) {
    return DashboardEntity(
      totalCallLogCount: totalCallLogCount ?? this.totalCallLogCount,
      totalServiceRequests: totalServiceRequests ?? this.totalServiceRequests,
      totalUrgentRequests: totalUrgentRequests ?? this.totalUrgentRequests,
      followUpTabletCount: followUpTabletCount ?? this.followUpTabletCount,
      followUpTabletPercent:
          followUpTabletPercent ?? this.followUpTabletPercent,
      generalStatus: generalStatus ?? this.generalStatus,
      openRequestsStatus: openRequestsStatus ?? this.openRequestsStatus,
      closedOrCanceledByCategory:
          closedOrCanceledByCategory ?? this.closedOrCanceledByCategory,
      closedOrCanceledByStatus:
          closedOrCanceledByStatus ?? this.closedOrCanceledByStatus,
      canceledByAssignStatus:
          canceledByAssignStatus ?? this.canceledByAssignStatus,
    );
  }

  DashboardModel toModel() {
    return DashboardModel(
      totalCallLogCount: totalCallLogCount,
      totalServiceRequests: totalServiceRequests,
      totalUrgentRequests: totalUrgentRequests,
      followUpTabletCount: followUpTabletCount,
      followUpTabletPercent: followUpTabletPercent,
      generalStatus: generalStatus.map((e) => e.toModel()).toList(),
      openRequestsStatus: openRequestsStatus.map((e) => e.toModel()).toList(),
      closedOrCanceledByCategory:
          closedOrCanceledByCategory.map((e) => e.toModel()).toList(),
      closedOrCanceledByStatus:
          closedOrCanceledByStatus.map((e) => e.toModel()).toList(),
      canceledByAssignStatus:
          canceledByAssignStatus.map((e) => e.toModel()).toList(),
    );
  }
}
