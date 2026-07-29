class SpecialPlanFilterValue {
  const SpecialPlanFilterValue({
    this.title,
    this.productId,
    this.hasHighPriority,
    this.startDate,
    this.endDate,
    this.orderNo,
    this.provinceTitle,
    this.cityTitle,
    this.isActive,
    this.onlySaipaCars,
  });

  final String? title;
  final int? productId;
  final bool? hasHighPriority;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? orderNo;
  final String? provinceTitle;
  final String? cityTitle;
  final bool? isActive;
  final bool? onlySaipaCars;
}
