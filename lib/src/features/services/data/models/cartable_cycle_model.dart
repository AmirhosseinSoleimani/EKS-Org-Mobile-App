import '../../domain/entities/cartable_cycle_entity.dart';

class CartableCycleItemModel extends CartableCycleItemEntity {
  const CartableCycleItemModel({
    required super.id,
    required super.serviceType,
    required super.serviceRequestId,
    required super.guid,
    required super.isBeginningOfCycle,
    required super.isEndingOfCycle,
    required super.type,
    required super.flowId,
    required super.flowCode,
    required super.cycleId,
    required super.subject,
    required super.status,
    required super.statusTitle,
    required super.stepId,
    required super.stepTitle,
    required super.relatedTelNo,
    required super.relatedCallLogId,
    required super.serviceRequestTrackCode,
    required super.senderType,
    required super.senderTypeName,
    required super.senderTypeTitle,
    required super.senderId,
    required super.senderFullName,
    required super.receiverType,
    required super.receiverTypeName,
    required super.receiverTypeTitle,
    required super.receiverId,
    required super.receiverUid,
    required super.receiverFullName,
    required super.description,
    required super.descriptionHtml,
    required super.isActive,
    required super.isDeleted,
    required super.priority,
    required super.snoozeTimeElapsed,
    required super.displayTime,
    required super.typeTitle,
    required super.sendDateTime,
    required super.sendDateJalali,
    required super.sendTime,
    required super.dueTimeIsPassed,
  });

  factory CartableCycleItemModel.fromJson(Map<String, dynamic> json) {
    return CartableCycleItemModel(
      id: json['id'] ?? 0,
      serviceType: json['serviceType'] ?? 0,
      serviceRequestId: json['serviceRequestId'] ?? 0,
      guid: json['guid'] ?? '',
      isBeginningOfCycle: json['isBeginningOfCycle'] ?? false,
      isEndingOfCycle: json['isEndingOfCycle'] ?? false,
      type: json['type'] ?? 0,
      flowId: json['flowId'] ?? 0,
      flowCode: json['flowCode'] ?? '',
      cycleId: json['cycleId'] ?? '',
      subject: json['subject'] ?? '',
      status: json['status'] ?? 0,
      statusTitle: json['statusTitle'] ?? '',
      stepId: json['stepId'] ?? 0,
      stepTitle: json['stepTitle'] ?? '',
      relatedTelNo: json['relatedTelNo'] ?? '',
      relatedCallLogId: json['relatedCallLogId'] ?? 0,
      serviceRequestTrackCode: json['serviceRequestTrackCode'] ?? 0,
      senderType: json['senderType'] ?? 0,
      senderTypeName: json['senderTypeName'] ?? '',
      senderTypeTitle: json['senderTypeTitle'] ?? '',
      senderId: json['senderId'] ?? 0,
      senderFullName: json['senderFullName'] ?? '',
      receiverType: json['receiverType'] ?? 0,
      receiverTypeName: json['receiverTypeName'] ?? '',
      receiverTypeTitle: json['receiverTypeTitle'] ?? '',
      receiverId: json['receiverId'] ?? 0,
      receiverUid: json['receiverUid'] ?? '',
      receiverFullName: json['receiverFullName'] ?? '',
      description: json['description'] ?? '',
      descriptionHtml: json['descriptionHtml'] ?? '',
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      priority: json['priority'] ?? 0,
      snoozeTimeElapsed: json['snoozeTimeElapsed'] ?? false,
      displayTime: json['displayTime'] ?? '',
      typeTitle: json['typeTitle'] ?? '',
      sendDateTime: json['sendDateTime'] ?? '',
      sendDateJalali: json['sendDateJalali'] ?? '',
      sendTime: json['sendTime'] ?? '',
      dueTimeIsPassed: json['dueTimeIsPassed'] ?? false,
    );
  }
}

class CartableCycleListModel extends CartableCycleListEntity {
  const CartableCycleListModel({
    required super.items,
    required super.count,
  });

  factory CartableCycleListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List? ?? [];

    final items =
    data.map((e) => CartableCycleItemModel.fromJson(e)).toList();

    return CartableCycleListModel(
      items: items,
      count: items.length,
    );
  }
}
