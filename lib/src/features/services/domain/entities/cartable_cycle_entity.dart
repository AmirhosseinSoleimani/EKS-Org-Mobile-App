import 'package:eks_sana_plus_org/src/features/services/data/models/cartable_cycle_model.dart';

class CartableCycleItemEntity {
  final int id;
  final int serviceType;
  final int serviceRequestId;
  final String guid;
  final bool isBeginningOfCycle;
  final bool isEndingOfCycle;
  final int type;
  final int flowId;
  final String flowCode;
  final String cycleId;
  final String subject;
  final int status;
  final String statusTitle;
  final int stepId;
  final String stepTitle;
  final String relatedTelNo;
  final int relatedCallLogId;
  final int serviceRequestTrackCode;
  final int senderType;
  final String senderTypeName;
  final String senderTypeTitle;
  final int senderId;
  final String senderFullName;
  final int receiverType;
  final String receiverTypeName;
  final String receiverTypeTitle;
  final int receiverId;
  final String receiverUid;
  final String receiverFullName;
  final String description;
  final String descriptionHtml;
  final bool isActive;
  final bool isDeleted;
  final int priority;
  final bool snoozeTimeElapsed;
  final String displayTime;
  final String typeTitle;
  final String sendDateTime;
  final String sendDateJalali;
  final String sendTime;
  final bool dueTimeIsPassed;

  const CartableCycleItemEntity({
    required this.id,
    required this.serviceType,
    required this.serviceRequestId,
    required this.guid,
    required this.isBeginningOfCycle,
    required this.isEndingOfCycle,
    required this.type,
    required this.flowId,
    required this.flowCode,
    required this.cycleId,
    required this.subject,
    required this.status,
    required this.statusTitle,
    required this.stepId,
    required this.stepTitle,
    required this.relatedTelNo,
    required this.relatedCallLogId,
    required this.serviceRequestTrackCode,
    required this.senderType,
    required this.senderTypeName,
    required this.senderTypeTitle,
    required this.senderId,
    required this.senderFullName,
    required this.receiverType,
    required this.receiverTypeName,
    required this.receiverTypeTitle,
    required this.receiverId,
    required this.receiverUid,
    required this.receiverFullName,
    required this.description,
    required this.descriptionHtml,
    required this.isActive,
    required this.isDeleted,
    required this.priority,
    required this.snoozeTimeElapsed,
    required this.displayTime,
    required this.typeTitle,
    required this.sendDateTime,
    required this.sendDateJalali,
    required this.sendTime,
    required this.dueTimeIsPassed,
  });

  CartableCycleItemEntity copyWith({
    int? id,
    int? serviceType,
    int? serviceRequestId,
    String? guid,
    bool? isBeginningOfCycle,
    bool? isEndingOfCycle,
    int? type,
    int? flowId,
    String? flowCode,
    String? cycleId,
    String? subject,
    int? status,
    String? statusTitle,
    int? stepId,
    String? stepTitle,
    String? relatedTelNo,
    int? relatedCallLogId,
    int? serviceRequestTrackCode,
    int? senderType,
    String? senderTypeName,
    String? senderTypeTitle,
    int? senderId,
    String? senderFullName,
    int? receiverType,
    String? receiverTypeName,
    String? receiverTypeTitle,
    int? receiverId,
    String? receiverUid,
    String? receiverFullName,
    String? description,
    String? descriptionHtml,
    bool? isActive,
    bool? isDeleted,
    int? priority,
    bool? snoozeTimeElapsed,
    String? displayTime,
    String? typeTitle,
    String? sendDateTime,
    String? sendDateJalali,
    String? sendTime,
    bool? dueTimeIsPassed,
  }) {
    return CartableCycleItemEntity(
      id: id ?? this.id,
      serviceType: serviceType ?? this.serviceType,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      guid: guid ?? this.guid,
      isBeginningOfCycle: isBeginningOfCycle ?? this.isBeginningOfCycle,
      isEndingOfCycle: isEndingOfCycle ?? this.isEndingOfCycle,
      type: type ?? this.type,
      flowId: flowId ?? this.flowId,
      flowCode: flowCode ?? this.flowCode,
      cycleId: cycleId ?? this.cycleId,
      subject: subject ?? this.subject,
      status: status ?? this.status,
      statusTitle: statusTitle ?? this.statusTitle,
      stepId: stepId ?? this.stepId,
      stepTitle: stepTitle ?? this.stepTitle,
      relatedTelNo: relatedTelNo ?? this.relatedTelNo,
      relatedCallLogId: relatedCallLogId ?? this.relatedCallLogId,
      serviceRequestTrackCode:
      serviceRequestTrackCode ?? this.serviceRequestTrackCode,
      senderType: senderType ?? this.senderType,
      senderTypeName: senderTypeName ?? this.senderTypeName,
      senderTypeTitle: senderTypeTitle ?? this.senderTypeTitle,
      senderId: senderId ?? this.senderId,
      senderFullName: senderFullName ?? this.senderFullName,
      receiverType: receiverType ?? this.receiverType,
      receiverTypeName: receiverTypeName ?? this.receiverTypeName,
      receiverTypeTitle: receiverTypeTitle ?? this.receiverTypeTitle,
      receiverId: receiverId ?? this.receiverId,
      receiverUid: receiverUid ?? this.receiverUid,
      receiverFullName: receiverFullName ?? this.receiverFullName,
      description: description ?? this.description,
      descriptionHtml: descriptionHtml ?? this.descriptionHtml,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      priority: priority ?? this.priority,
      snoozeTimeElapsed: snoozeTimeElapsed ?? this.snoozeTimeElapsed,
      displayTime: displayTime ?? this.displayTime,
      typeTitle: typeTitle ?? this.typeTitle,
      sendDateTime: sendDateTime ?? this.sendDateTime,
      sendDateJalali: sendDateJalali ?? this.sendDateJalali,
      sendTime: sendTime ?? this.sendTime,
      dueTimeIsPassed: dueTimeIsPassed ?? this.dueTimeIsPassed,
    );
  }

  CartableCycleItemModel toModel() {
    return CartableCycleItemModel(
      id: id,
      serviceType: serviceType,
      serviceRequestId: serviceRequestId,
      guid: guid,
      isBeginningOfCycle: isBeginningOfCycle,
      isEndingOfCycle: isEndingOfCycle,
      type: type,
      flowId: flowId,
      flowCode: flowCode,
      cycleId: cycleId,
      subject: subject,
      status: status,
      statusTitle: statusTitle,
      stepId: stepId,
      stepTitle: stepTitle,
      relatedTelNo: relatedTelNo,
      relatedCallLogId: relatedCallLogId,
      serviceRequestTrackCode: serviceRequestTrackCode,
      senderType: senderType,
      senderTypeName: senderTypeName,
      senderTypeTitle: senderTypeTitle,
      senderId: senderId,
      senderFullName: senderFullName,
      receiverType: receiverType,
      receiverTypeName: receiverTypeName,
      receiverTypeTitle: receiverTypeTitle,
      receiverId: receiverId,
      receiverUid: receiverUid,
      receiverFullName: receiverFullName,
      description: description,
      descriptionHtml: descriptionHtml,
      isActive: isActive,
      isDeleted: isDeleted,
      priority: priority,
      snoozeTimeElapsed: snoozeTimeElapsed,
      displayTime: displayTime,
      typeTitle: typeTitle,
      sendDateTime: sendDateTime,
      sendDateJalali: sendDateJalali,
      sendTime: sendTime,
      dueTimeIsPassed: dueTimeIsPassed,
    );
  }
}

class CartableCycleListEntity {
  final List<CartableCycleItemEntity> items;
  final int count;

  const CartableCycleListEntity({
    required this.items,
    required this.count,
  });

  CartableCycleListEntity copyWith({
    List<CartableCycleItemEntity>? items,
    int? count,
  }) {
    return CartableCycleListEntity(
      items: items ?? this.items,
      count: count ?? this.count,
    );
  }

  CartableCycleListModel toModel() {
    return CartableCycleListModel(
      items: items.map((e) => e.toModel()).toList(),
      count: count,
    );
  }
}
