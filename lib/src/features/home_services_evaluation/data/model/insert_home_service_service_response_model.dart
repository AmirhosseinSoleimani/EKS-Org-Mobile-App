

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_response_entity.dart';

class InsertHomeServiceServiceResponseModel extends InsertHomeServiceServiceResponseEntity {

  const InsertHomeServiceServiceResponseModel({
    super.services,
  });

  factory InsertHomeServiceServiceResponseModel.fromJson(Map<String, dynamic> json){
    return InsertHomeServiceServiceResponseModel(
      services: (json['emdadServices'] != null) ? (json['emdadServices'] as List).map((e) => InsertHomeServiceServiceItemResponseModel.fromJson(e)).toList() : [],
    );
  }
}

class InsertHomeServiceServiceItemResponseModel extends InsertHomeServiceServiceItemResponseEntity {
  const InsertHomeServiceServiceItemResponseModel({
    super.id,
    super.categoryId,
    super.serviceTypeId,
    super.title,
    super.imageGuid,
    super.subscriptionStatus,
    super.isActive,
    super.productId,
    super.labors,
    super.hasSubscription,
    super.isImageMandatory,
  });

  factory InsertHomeServiceServiceItemResponseModel.fromJson(Map<String, dynamic> json) {
    return InsertHomeServiceServiceItemResponseModel(
        id: json['serviceId'],
        categoryId: json['serviceCategoryId'],
        isActive: json['isActive'],
        serviceTypeId: json['serviceTypeId'],
        title: json['serviceTitle'],
        imageGuid: json['imageBase64'],
        hasSubscription: json['hasSubscription'],
        productId: json['productId'],
        isImageMandatory: json['isImageMandatory'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceId'] = id;
    map['categoryId'] = categoryId;
    map['hasSubscription'] = hasSubscription;
    map['title'] = title;
    map['isActive'] = isActive;
    map['serviceTypeId'] = serviceTypeId;
    map['productId'] = productId;
    map['labors'] = labors?.map((e) => e.toModel().toJson()).toList();
    return map;
  }
}
