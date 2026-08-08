class EmdadServiceCategoryEntity {
  const EmdadServiceCategoryEntity({
    required this.id,
    required this.serviceTypeId,
    required this.serviceTypeTitle,
    required this.code,
    required this.title,
    required this.orderNo,
  });

  final int id;
  final int serviceTypeId;
  final String serviceTypeTitle;
  final String code;
  final String title;
  final int orderNo;
}
