enum PaymentType {
  cash(0),
  online(1);

  final int value;
  const PaymentType(this.value);

  static PaymentType? fromValue(int? value) {
    if (value == null) return null;
    return PaymentType.values.firstWhere(
          (e) => e.value == value,
      orElse: () => PaymentType.cash,
    );
  }
}