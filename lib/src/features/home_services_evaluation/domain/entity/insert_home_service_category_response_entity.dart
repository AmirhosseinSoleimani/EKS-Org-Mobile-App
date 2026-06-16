import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_category_response_model.dart';

import 'insert_home_service_service_response_entity.dart';

class InsertHomeServiceCategoryResponseEntity {
  const InsertHomeServiceCategoryResponseEntity({
    this.categoryId,
    this.categoryTitle,
    this.homeServices,
  });

  final int? categoryId;
  final String? categoryTitle;
  final List<InsertHomeServiceServiceItemResponseEntity>? homeServices;

  InsertHomeServiceCategoryResponseEntity copyWith({
    int? categoryId,
    String? categoryTitle,
    List<InsertHomeServiceServiceItemResponseEntity>? homeServices,
  }) {
    return InsertHomeServiceCategoryResponseEntity(
      categoryId: categoryId ?? this.categoryId,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      homeServices: homeServices ?? this.homeServices,
    );
  }

  InsertHomeServiceCategoryResponseModel toModel() {
    return InsertHomeServiceCategoryResponseModel(
      categoryId: categoryId,
      categoryTitle: categoryTitle,
      homeServices: homeServices?.map((e) => e.toModel()).toList(),
    );
  }
}
