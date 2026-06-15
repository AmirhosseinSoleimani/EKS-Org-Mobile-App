import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_category_response_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class ServiceCategoryResponseEntity implements DropdownItem<int> {
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

  const ServiceCategoryResponseEntity({
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

  ServiceCategoryResponseEntity copyWith({
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
    return ServiceCategoryResponseEntity(
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

  ServiceCategoryResponseModel toModel() {
    return ServiceCategoryResponseModel(
      actionsToLog: actionsToLog,
      code: code,
      serviceTypeId: serviceTypeId,
      title: title,
      orderNo: orderNo,
      isActive: isActive,
      isDeleted: isDeleted,
      isVisible: isVisible,
      objectState: objectState,
      id: id,
      idString: idString,
      keyType: keyType,
    );
  }

  @override
  String get label => title ?? '';

  @override
  int get value => id ?? 0;

  @override
  Widget? leading(BuildContext context) => null;
}