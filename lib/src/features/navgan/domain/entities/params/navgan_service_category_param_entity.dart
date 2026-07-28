import 'package:eks_sana_plus_org/src/features/navgan/data/models/params/navgan_service_category_request_model.dart';

class NavganServiceCategoryParamEntity {
  const NavganServiceCategoryParamEntity({
    required this.navganId,
    required this.serviceCategoryId,
  });

  final int navganId;
  final int serviceCategoryId;

  NavganServiceCategoryRequestModel toModel() {
    return NavganServiceCategoryRequestModel(
      navganId: navganId,
      serviceCategoryId: serviceCategoryId,
    );
  }
}
