import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/emdad_service_category_entity.dart';

class NavganServiceGroupEntity {
  const NavganServiceGroupEntity({
    this.serviceType,
    this.serviceTypeTitle,
    this.emdadCategories = const [],
  });

  final int? serviceType;
  final String? serviceTypeTitle;
  final List<EmdadServiceCategoryEntity> emdadCategories;

  NavganServiceGroupEntity copyWith({
    List<EmdadServiceCategoryEntity>? emdadCategories,
  }) {
    return NavganServiceGroupEntity(
      serviceType: serviceType,
      serviceTypeTitle: serviceTypeTitle,
      emdadCategories: emdadCategories ?? this.emdadCategories,
    );
  }
}
