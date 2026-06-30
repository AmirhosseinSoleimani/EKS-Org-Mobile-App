enum AreaBusinessUsageType {
  //خدمات امدادی
  aidService(value: 1),
  //خدمات در محل
  homeService(value: 2),
  //تخفیف
  discount(value: 3),
  //طرح ویژه
  spatialPlan(value: 4);

  final int value;

  const AreaBusinessUsageType({required this.value});

  static AreaBusinessUsageType fromValue(int? value) {
    return AreaBusinessUsageType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AreaBusinessUsageType.aidService,
    );
  }
}
