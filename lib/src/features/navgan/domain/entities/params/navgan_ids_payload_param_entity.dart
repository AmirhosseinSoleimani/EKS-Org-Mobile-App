import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_ids_payload_request_model.dart';

class NavganIdsPayloadParamEntity {
  const NavganIdsPayloadParamEntity({
    required this.navganId,
    required this.ids,
    this.serviceCategoryId,
  });

  final int navganId;
  final List<int> ids;
  final int? serviceCategoryId;

  NavganIdsPayloadRequestModel toServiceCategoriesModel() {
    return NavganIdsPayloadRequestModel(
      navganId: navganId,
      idsFieldName: 'emdadServiceCategoryIds',
      ids: ids,
    );
  }

  NavganIdsPayloadRequestModel toDefectsModel() {
    return NavganIdsPayloadRequestModel(
      navganId: navganId,
      serviceCategoryId: serviceCategoryId,
      idsFieldName: 'defectInfoIds',
      ids: ids,
    );
  }
}
