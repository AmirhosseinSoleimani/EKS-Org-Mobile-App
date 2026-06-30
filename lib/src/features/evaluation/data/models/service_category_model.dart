// Model
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';

class ServiceCategoryModel extends ServiceCategoryEntity {
  const ServiceCategoryModel({
    super.actionsToLog,
    super.code,
    super.serviceTypeId,
    super.title,
    super.orderNo,
    super.isActive,
    super.isDeleted,
    super.isVisible,
    super.logData,
    super.objectState,
    super.id,
    super.idString,
    super.keyType,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryModel(
      actionsToLog: json['actionsToLog'] as int,
      code: json['code'] as String,
      serviceTypeId: json['serviceTypeId'] as int,
      title: json['title'] as String,
      orderNo: json['orderNo'] as int,
      isActive: json['isActive'] as bool,
      isDeleted: json['isDeleted'] as bool,
      isVisible: json['isVisible'] as bool,
      logData: LogDataModel.fromJson(json['logData'] as Map<String, dynamic>),
      objectState: json['objectState'] as int,
      id: json['id'] as int,
      idString: json['idString'] as String,
      keyType: json['keyType'] as String,
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
      'logData': logData?.toModel().toJson(),
      'objectState': objectState,
      'id': id,
      'idString': idString,
      'keyType': keyType,
    };
  }

  ServiceCategoryModel toEntity() {
    return ServiceCategoryModel(
      actionsToLog: actionsToLog,
      code: code,
      serviceTypeId: serviceTypeId,
      title: title,
      orderNo: orderNo,
      isActive: isActive,
      isDeleted: isDeleted,
      isVisible: isVisible,
      logData: logData,
      objectState: objectState,
      id: id,
      idString: idString,
      keyType: keyType,
    );
  }
}

class LogDataModel extends LogDataEntity {
  const LogDataModel({
    super.insertDateTime,
    super.insertUserName,
    super.insertUserId,
    super.objectState,
    super.id,
  });

  factory LogDataModel.fromJson(Map<String, dynamic> json) {
    return LogDataModel(
      insertDateTime: DateTime.parse(json['insertDateTime'] as String),
      insertUserName: json['insertUserName'] as String,
      insertUserId: json['insertUserId'] as int,
      objectState: json['objectState'] as int,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'insertDateTime': insertDateTime?.toIso8601String(),
      'insertUserName': insertUserName,
      'insertUserId': insertUserId,
      'objectState': objectState,
      'id': id,
    };
  }

  LogDataEntity toEntity() {
    return LogDataEntity(
      insertDateTime: insertDateTime,
      insertUserName: insertUserName,
      insertUserId: insertUserId,
      objectState: objectState,
      id: id,
    );
  }
}
