import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';

class CancelRequestReasonModel extends CancelRequestReasonEntity {
  const CancelRequestReasonModel({
    super.id,
    super.title,
    super.orderNo,
    super.type,
    super.canCreateInvoice,
    super.serviceType,
    super.detailType,
    super.detailTypeTitle,
    super.needImage,
    super.reasonActionTypeTitle,
    super.isActive,
    super.isDeleted,
  });

  factory CancelRequestReasonModel.fromJson(Map<String, dynamic> json) {
    return CancelRequestReasonModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      orderNo: json['orderNo'] as int?,
      type: json['type'] as int?,
      canCreateInvoice: json['canCreateInvoice'] as bool?,
      serviceType: json['serviceType'] as int?,
      detailType: json['detailType'] as int?,
      detailTypeTitle: json['detailTypeTitle'] as String?,
      needImage: json['needImage'] as bool?,
      reasonActionTypeTitle: json['reasonActionTypeTitle'] as String?,
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'orderNo': orderNo,
      'type': type,
      'canCreateInvoice': canCreateInvoice,
      'serviceType': serviceType,
      'detailType': detailType,
      'detailTypeTitle': detailTypeTitle,
      'needImage': needImage,
      'reasonActionTypeTitle': reasonActionTypeTitle,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }
}

