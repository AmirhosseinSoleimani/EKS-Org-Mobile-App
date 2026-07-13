class PlanCancelationEntity {
  final bool shouldCancel;
  final List<PlanCancelationRequestEntity> requests;

  const PlanCancelationEntity({
    required this.shouldCancel,
    required this.requests,
  });
}

class PlanCancelationRequestEntity {
  final int? id;
  final int? trackCode;
  final int? serviceType;
  final String? serviceTypeTitle;

  const PlanCancelationRequestEntity({
    this.id,
    this.trackCode,
    this.serviceType,
    this.serviceTypeTitle,
  });
}
