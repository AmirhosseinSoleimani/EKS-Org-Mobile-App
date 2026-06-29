import 'package:eks_sana_plus_org/src/features/cartable/data/models/cartable_item_model.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';

class CartableItemEntity {
  final int? id;
  final int? serviceType;
  final int? serviceRequestId;
  final String? guid;
  final bool? isBeginningOfCycle;
  final bool? isEndingOfCycle;
  final int? type;
  final int? flowId;
  final String? flowCode;
  final String? cycleId;
  final String? subject;
  final int? status;
  final String? statusTitle;
  final int? stepId;
  final String? stepTitle;
  final String? relatedTelNo;
  final int? relatedCallLogId;
  final int? serviceRequestTrackCode;
  final int? senderType;
  final String? senderTypeName;
  final String? senderTypeTitle;
  final int? senderId;
  final String? senderUid;
  final String? senderFullName;
  final int? receiverType;
  final String? receiverTypeName;
  final String? receiverTypeTitle;
  final int? receiverId;
  final String? receiverUid;
  final String? receiverFullName;
  final String? description;
  final String? descriptionHtml;
  final bool? isActive;
  final bool? isDeleted;
  final int? priority;
  final bool? snoozeTimeElapsed;
  final String? stepCode;
  final String? displayTime;
  final String? displayColor;
  final String? typeTitle;
  final String? sendDateTime;
  final String? sendDateJalali;
  final String? sendTime;
  final String? lastUpdateTime;
  final bool? dueTimeIsPassed;
  final List<CartableItemActionEntity>? availableActions;

  const CartableItemEntity({
    this.id,
    this.serviceType,
    this.serviceRequestId,
    this.guid,
    this.isBeginningOfCycle,
    this.isEndingOfCycle,
    this.type,
    this.flowId,
    this.flowCode,
    this.cycleId,
    this.subject,
    this.status,
    this.statusTitle,
    this.stepId,
    this.stepTitle,
    this.relatedTelNo,
    this.relatedCallLogId,
    this.serviceRequestTrackCode,
    this.senderType,
    this.senderTypeName,
    this.senderTypeTitle,
    this.senderId,
    this.senderUid,
    this.senderFullName,
    this.receiverType,
    this.receiverTypeName,
    this.receiverTypeTitle,
    this.receiverId,
    this.receiverUid,
    this.receiverFullName,
    this.description,
    this.descriptionHtml,
    this.isActive,
    this.isDeleted,
    this.priority,
    this.snoozeTimeElapsed,
    this.stepCode,
    this.displayTime,
    this.displayColor,
    this.typeTitle,
    this.sendDateTime,
    this.sendDateJalali,
    this.sendTime,
    this.lastUpdateTime,
    this.dueTimeIsPassed,
    this.availableActions,
  });

  CartableItemModel toModel() {
    return CartableItemModel(
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
      senderUid: senderUid,
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
      stepCode: stepCode,
      displayTime: displayTime,
      displayColor: displayColor,
      typeTitle: typeTitle,
      sendDateTime: sendDateTime,
      sendDateJalali: sendDateJalali,
      sendTime: sendTime,
      lastUpdateTime: lastUpdateTime,
      dueTimeIsPassed: dueTimeIsPassed,
      availableActions: availableActions
          ?.map((item) => item.toModel())
          .toList(),
    );
  }

  CartableItemEntity copyWith({
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
    String? senderUid,
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
    String? stepCode,
    String? displayTime,
    String? displayColor,
    String? typeTitle,
    String? sendDateTime,
    String? sendDateJalali,
    String? sendTime,
    String? lastUpdateTime,
    bool? dueTimeIsPassed,
    List<CartableItemActionEntity>? availableActions,
  }) {
    return CartableItemEntity(
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
      senderUid: senderUid ?? this.senderUid,
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
      stepCode: stepCode ?? this.stepCode,
      displayTime: displayTime ?? this.displayTime,
      displayColor: displayColor ?? this.displayColor,
      typeTitle: typeTitle ?? this.typeTitle,
      sendDateTime: sendDateTime ?? this.sendDateTime,
      sendDateJalali: sendDateJalali ?? this.sendDateJalali,
      sendTime: sendTime ?? this.sendTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      dueTimeIsPassed: dueTimeIsPassed ?? this.dueTimeIsPassed,
      availableActions: availableActions ?? this.availableActions,
    );
  }
}