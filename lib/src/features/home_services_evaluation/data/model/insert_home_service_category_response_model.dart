import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_service_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_category_response_entity.dart';

class InsertHomeServiceCategoryResponseModel
    extends InsertHomeServiceCategoryResponseEntity {
  const InsertHomeServiceCategoryResponseModel({
    super.categoryId,
    super.categoryTitle,
    super.homeServices,
    super.actionsToLog,
    super.code,
    super.serviceTypeId,
    super.title,
    super.orderNo,
    super.isActive,
    super.isDeleted,
    super.isVisible,
    super.objectState,
    super.id,
    super.idString,
    super.keyType,
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
      actionsToLog: json['actionsToLog'] as int?,
      code: json['code'] as String?,
      serviceTypeId: json['serviceTypeId'] as int?,
      title: json['title'] as String?,
      orderNo: json['orderNo'] as int?,
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isVisible: json['isVisible'] as bool?,
      objectState: json['objectState'] as int?,
      id: json['id'] as int?,
      idString: json['idString'] as String?,
      keyType: json['keyType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionsToLog': actionsToLog,
      'code': code,
      'serviceTypeId': serviceTypeId,
      'title': title,
      'orderNo': orderNo,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'isVisible': isVisible,
      'objectState': objectState,
      'id': id,
      'idString': idString,
      'keyType': keyType,
      'homeServices': homeServices
          ?.map(
            (e) => (e as InsertHomeServiceServiceItemResponseModel).toJson(),
          )
          .toList(),
    };
  }
}
