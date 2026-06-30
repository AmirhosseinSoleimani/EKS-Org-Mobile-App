enum EmdadgarStatus {
  available(value: 1),
  busy(value: 2),
  offline(value: 3),
  danger(value: 4);

  final int value;

  const EmdadgarStatus({
    required this.value,
  });

  static EmdadgarStatus fromValue(int? value) {
    return EmdadgarStatus.values.firstWhere(
          (e) => e.value == value,
      orElse: () => EmdadgarStatus.offline,
    );
  }
}
