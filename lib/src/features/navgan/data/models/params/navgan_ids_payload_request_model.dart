class NavganIdsPayloadRequestModel {
  const NavganIdsPayloadRequestModel({
    required this.navganId,
    required this.idsFieldName,
    required this.ids,
    this.serviceCategoryId,
  });

  final int navganId;
  final String idsFieldName;
  final List<int> ids;
  final int? serviceCategoryId;

  Map<String, dynamic> toJson() {
    return {
      'navganId': navganId,
      if (serviceCategoryId != null) 'serviceCategoryId': serviceCategoryId,
      idsFieldName: ids,
    };
  }
}
