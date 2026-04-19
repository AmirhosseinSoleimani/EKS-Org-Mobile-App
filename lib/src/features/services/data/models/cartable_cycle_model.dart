import '../../domain/entities/cartable_cycle_entity.dart';

class CartableCycleItemModel extends CartableCycleItemEntity {
  const CartableCycleItemModel({
    super.id,
    super.serviceType,
    super.serviceRequestId,
    super.guid,
    super.isBeginningOfCycle,
    super.isEndingOfCycle,
    super.type,
    super.flowId,
    super.flowCode,
    super.cycleId,
    super.subject,
    super.status,
    super.statusTitle,
    super.stepId,
    super.stepTitle,
    super.relatedTelNo,
    super.relatedCallLogId,
    super.serviceRequestTrackCode,
    super.senderType,
    super.senderTypeName,
    super.senderTypeTitle,
    super.senderId,
    super.senderFullName,
    super.receiverType,
    super.receiverTypeName,
    super.receiverTypeTitle,
    super.receiverId,
    super.receiverUid,
    super.receiverFullName,
    super.description,
    super.descriptionHtml,
    super.isActive,
    super.isDeleted,
    super.priority,
    super.snoozeTimeElapsed,
    super.displayTime,
    super.typeTitle,
    super.sendDateTime,
    super.sendDateJalali,
    super.sendTime,
    super.dueTimeIsPassed,
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
