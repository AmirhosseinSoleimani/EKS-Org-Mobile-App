class NavganServiceCategoryRequestModel {
  const NavganServiceCategoryRequestModel({
    required this.navganId,
    required this.serviceCategoryId,
  });

  final int navganId;
  final int serviceCategoryId;

  Map<String, dynamic> toJson() {
    return {
      'navganId': navganId,
      'serviceCategoryId': serviceCategoryId,
    };
  }
}
