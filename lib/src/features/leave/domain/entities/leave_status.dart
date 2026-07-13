enum LeaveStatus {
  registered(0),
  accepted(1),
  rejected(2),
  all(3);

  const LeaveStatus(this.code);

  final int code;

  static LeaveStatus fromCode(int? code) {
    return LeaveStatus.values.firstWhere(
      (status) => status.code == code,
      orElse: () => LeaveStatus.registered,
    );
  }

  bool get canChangeToFinalState => this == LeaveStatus.registered;

  bool get canRollback =>
      this == LeaveStatus.accepted || this == LeaveStatus.rejected;
}

class LeaveStatusOption {
  const LeaveStatusOption({
    required this.title,
    required this.status,
  });

  final String title;
  final LeaveStatus status;
}

