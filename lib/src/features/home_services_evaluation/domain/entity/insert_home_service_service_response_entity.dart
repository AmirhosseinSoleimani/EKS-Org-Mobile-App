import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_service_response_model.dart';

import 'insert_home_service_labor_entity.dart';

class InsertHomeServiceServiceResponseEntity {
  const InsertHomeServiceServiceResponseEntity({
    this.services,
  });

  final List<InsertHomeServiceServiceItemResponseEntity>? services;

  InsertHomeServiceServiceResponseModel toModel() {
    return InsertHomeServiceServiceResponseModel(
      services: services?.map((e) => e.toModel()).toList(),
    );
  }
}



class InsertHomeServiceServiceItemResponseEntity {
  const InsertHomeServiceServiceItemResponseEntity({
    this.id,
    this.categoryId,
    this.serviceTypeId,
    this.title,
    this.imageGuid,
    this.subscriptionStatus,
    this.isActive,
    this.productId,
    this.labors,
    this.hasSubscription,
    this.isSelected = false,
    this.isImageMandatory,
  });

  final String? subscriptionStatus;
  final int? id;
  final int? serviceTypeId;
  final int? categoryId;
  final String? title;
  final bool? isActive;
  final int? productId;
  final String? imageGuid;
  final List<InsertHomeServiceLaborEntity>? labors;
  final bool? hasSubscription;
  final bool isSelected;
  final bool? isImageMandatory;

  InsertHomeServiceServiceItemResponseEntity copyWith({
    String? subscriptionStatus,
    int? id,
    int? serviceTypeId,
    int? categoryId,
    String? title,
    bool? isActive,
    int? productId,
    String? imageGuid,
    List<InsertHomeServiceLaborEntity>? labors,
    bool? hasSubscription,
    bool? isSelected,
    bool? isImageMandatory,
  }) {
    return InsertHomeServiceServiceItemResponseEntity(
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      id: id ?? this.id,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      productId: productId ?? this.productId,
      imageGuid: imageGuid ?? this.imageGuid,
      labors: labors ?? this.labors,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      isSelected: isSelected ?? this.isSelected,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }


  InsertHomeServiceServiceItemResponseModel toModel() {
    return InsertHomeServiceServiceItemResponseModel(
      id: id,
      categoryId: categoryId,
      serviceTypeId: serviceTypeId,
      title: title,
      imageGuid: imageGuid,
      subscriptionStatus: subscriptionStatus,
      isActive: isActive,
      productId: productId,
      hasSubscription:hasSubscription,
      isImageMandatory: isImageMandatory,
      labors: labors?.map((labor) => labor.toModel()).toList(),
    );
  }
}
