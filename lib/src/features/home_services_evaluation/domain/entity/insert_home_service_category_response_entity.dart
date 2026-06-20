import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_category_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'insert_home_service_service_response_entity.dart';

class InsertHomeServiceCategoryResponseEntity implements DropdownItem<int>{
  const InsertHomeServiceCategoryResponseEntity({
    this.categoryId,
    this.categoryTitle,
    this.homeServices,
    this.actionsToLog,
    this.code,
    this.serviceTypeId,
    this.title,
    this.orderNo,
    this.isActive,
    this.isDeleted,
    this.isVisible,
    this.objectState,
    this.id,
    this.idString,
    this.keyType,
  });

  final int? categoryId;
  final String? categoryTitle;
  final List<InsertHomeServiceServiceItemResponseEntity>? homeServices;
  final int? actionsToLog;
  final String? code;
  final int? serviceTypeId;
  final String? title;
  final int? orderNo;
  final bool? isActive;
  final bool? isDeleted;
  final bool? isVisible;
  final int? objectState;
  final int? id;
  final String? idString;
  final String? keyType;

  InsertHomeServiceCategoryResponseEntity copyWith({
    int? categoryId,
    String? categoryTitle,
    List<InsertHomeServiceServiceItemResponseEntity>? homeServices,
    int? actionsToLog,
    String? code,
    int? serviceTypeId,
    String? title,
    int? orderNo,
    bool? isActive,
    bool? isDeleted,
    bool? isVisible,
    int? objectState,
    int? id,
    String? idString,
    String? keyType,
  }) {
    return InsertHomeServiceCategoryResponseEntity(
      categoryId: categoryId ?? this.categoryId,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      homeServices: homeServices ?? this.homeServices,
      actionsToLog: actionsToLog ?? this.actionsToLog,
      code: code ?? this.code,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      title: title ?? this.title,
      orderNo: orderNo ?? this.orderNo,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      isVisible: isVisible ?? this.isVisible,
      objectState: objectState ?? this.objectState,
      id: id ?? this.id,
      idString: idString ?? this.idString,
      keyType: keyType ?? this.keyType,
    );
  }

  InsertHomeServiceCategoryResponseModel toModel() {
    return InsertHomeServiceCategoryResponseModel(
      categoryId: categoryId,
      categoryTitle: categoryTitle,
      homeServices: homeServices?.map((e) => e.toModel()).toList(),
    );
  }

  @override
  String get label => title ?? '';

  @override
  Widget? leading(BuildContext context) => null;

  @override
  int get value => id ?? 0;
}
