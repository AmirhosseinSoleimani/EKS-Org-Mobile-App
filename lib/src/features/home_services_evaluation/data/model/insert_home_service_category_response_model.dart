import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_service_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_category_response_entity.dart';

class InsertHomeServiceCategoryResponseModel
    extends InsertHomeServiceCategoryResponseEntity {
  const InsertHomeServiceCategoryResponseModel({
    super.categoryId,
    super.categoryTitle,
    super.homeServices,
  });

  factory InsertHomeServiceCategoryResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InsertHomeServiceCategoryResponseModel(
      categoryId: json['id'],
      categoryTitle: json['title'],
      homeServices: (json['homeServices'] != null)
          ? (json['homeServices'] as List)
                .map(
                  (e) => InsertHomeServiceServiceItemResponseModel.fromJson(e),
                )
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': categoryId,
      'title': categoryTitle,
      'homeServices': homeServices
          ?.map(
            (e) => (e as InsertHomeServiceServiceItemResponseModel).toJson(),
          )
          .toList(),
    };
  }
}
