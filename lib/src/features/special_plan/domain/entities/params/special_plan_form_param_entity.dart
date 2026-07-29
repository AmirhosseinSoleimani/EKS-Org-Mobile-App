class SpecialPlanFormParamEntity {
  const SpecialPlanFormParamEntity({
    this.id,
    required this.title,
    this.productId,
    required this.startDate,
    required this.endDate,
    required this.areaBaseInfoId,
    required this.hasHighPriority,
    required this.orderNo,
    required this.isActive,
    required this.onlySaipaCars,
  });

  final int? id;
  final String title;
  final int? productId;
  final DateTime startDate;
  final DateTime endDate;
  final int areaBaseInfoId;
  final bool hasHighPriority;
  final int orderNo;
  final bool isActive;
  final bool onlySaipaCars;
}
