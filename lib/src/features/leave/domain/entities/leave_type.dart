enum LeaveType {
  all(0),
  daily(1),
  hourly(2);

  const LeaveType(this.code);

  final int code;

  static LeaveType fromCode(int? code) {
    return LeaveType.values.firstWhere(
      (type) => type.code == code,
      orElse: () => LeaveType.all,
    );
  }
}

class LeaveTypeOption {
  const LeaveTypeOption({
    required this.title,
    required this.type,
  });

  final String title;
  final LeaveType type;
}

