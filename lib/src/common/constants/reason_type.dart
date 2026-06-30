enum ReasonType {
  beforeDispatch(1, 'قبل از اعزام'),
  afterDispatch(2, 'بعد از اعزام'),
  nonCooperation(3, 'عدم همکاری'),
  cancelEmdadgar(4, 'لغو ماموریت');

  const ReasonType(this.value, this.label);

  final String label;
  final int value;

  static ReasonType fromValue(int? value) {
    return ReasonType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ReasonType.beforeDispatch,
    );
  }
}
