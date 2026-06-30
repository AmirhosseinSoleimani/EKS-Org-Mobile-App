
enum ServiceAssignAction {
  assignEmdadgar(1),
  nonCooperation(2),
  cancelMission(3);

  final int value;

  const ServiceAssignAction(this.value);

  static ServiceAssignAction fromValue(int? value) {
    return ServiceAssignAction.values.firstWhere(
          (e) => e.value == value,
      orElse: () => ServiceAssignAction.assignEmdadgar,
    );
  }
}
