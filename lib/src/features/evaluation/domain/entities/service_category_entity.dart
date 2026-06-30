import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_category_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/cupertino.dart';

class ServiceCategoryEntity implements DropdownItem {
  final int? id;
  final int? actionsToLog;
  final String? code;
  final int? serviceTypeId;
  final String? title;
  final int? orderNo;
  final bool? isActive;
  final bool? isDeleted;
  final bool? isVisible;
  final LogDataEntity? logData;
  final int? objectState;
  final String? idString;
  final String? keyType;

  const ServiceCategoryEntity({
    this.actionsToLog,
    this.code,
    this.serviceTypeId,
    this.title,
    this.orderNo,
    this.isActive,
    this.isDeleted,
    this.isVisible,
    this.logData,
    this.objectState,
    this.id,
    this.idString,
    this.keyType,
  });

  ServiceCategoryEntity copyWith({
    int? actionsToLog,
    String? code,
    int? serviceTypeId,
    String? title,
    int? orderNo,
    bool? isActive,
    bool? isDeleted,
    bool? isVisible,
    LogDataEntity? logData,
    int? objectState,
    int? id,
    String? idString,
    String? keyType,
  }) {
    return ServiceCategoryEntity(
      actionsToLog: actionsToLog ?? this.actionsToLog,
      code: code ?? this.code,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      title: title ?? this.title,
      orderNo: orderNo ?? this.orderNo,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      isVisible: isVisible ?? this.isVisible,
      logData: logData ?? this.logData,
      objectState: objectState ?? this.objectState,
      id: id ?? this.id,
      idString: idString ?? this.idString,
      keyType: keyType ?? this.keyType,
    );
  }

  ServiceCategoryModel toModel() {
    return ServiceCategoryModel(
      actionsToLog: actionsToLog,
      code: code,
      serviceTypeId: serviceTypeId,
      title: title,
      orderNo: orderNo,
      isActive: isActive,
      isDeleted: isDeleted,
      isVisible: isVisible,
      logData: logData?.toModel(),
      objectState: objectState,
      id: id,
      idString: idString,
      keyType: keyType,
    );
  }

  @override
  String get label => title ?? '';

  @override
  get value => id;

  @override
  Widget? leading(BuildContext context) {
    return SizedBox();
  }
}

class LogDataEntity {
  final DateTime? insertDateTime;
  final String? insertUserName;
  final int? insertUserId;
  final int? objectState;
  final int? id;

  const LogDataEntity({
   this.insertDateTime,
   this.insertUserName,
   this.insertUserId,
   this.objectState,
   this.id,
  });

  LogDataEntity copyWith({
    DateTime? insertDateTime,
    String? insertUserName,
    int? insertUserId,
    int? objectState,
    int? id,
  }) {
    return LogDataEntity(
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertUserName: insertUserName ?? this.insertUserName,
      insertUserId: insertUserId ?? this.insertUserId,
      objectState: objectState ?? this.objectState,
      id: id ?? this.id,
    );
  }

  LogDataModel toModel() {
    return LogDataModel(
      insertDateTime: insertDateTime,
      insertUserName: insertUserName,
      insertUserId: insertUserId,
      objectState: objectState,
      id: id,
    );
  }
}
