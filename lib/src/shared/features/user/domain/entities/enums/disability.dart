enum Disability {
  none(0, "بدون معلولیت"),
  hearing(1, "اختلال شنوایی"),
  speech(2, "اختلال گفتاری"),
  mobility(3, "اختلال حرکتی");

  final int value;
  final String title;

  const Disability(this.value, this.title);

  static Disability fromValue(int value) {
    return Disability.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Disability.none,
    );
  }
}
