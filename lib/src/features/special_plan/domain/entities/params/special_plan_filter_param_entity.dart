class SpecialPlanFilterParamEntity {
  const SpecialPlanFilterParamEntity({
    this.skip = 0,
    this.pageSize = 10,
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

  final int skip;
  final int pageSize;
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
