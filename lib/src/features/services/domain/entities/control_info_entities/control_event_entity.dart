import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/control_event_model.dart';

class ControlEventEntity {
  final int? id;
  final String? followUpDateTime;
  final int? actionType;
  final int? authorType;
  final int? authorId;
  final String? authorFullName;
  final int? sourceType;
  final int? resultStatusId;
  final String? resultStatusTitle;
  final String? description;
  final bool? isDeleted;
  final String? followUpDateJalali;
  final String? followUpTime;
  final String? actionTypeName;
  final String? actionTypeTitle;
  final String? authorTypeName;
  final String? authorTypeTitle;
  final String? sourceTypeName;
  final String? sourceTypeTitle;
  final String? insertDateTime;
  final int? serviceRequestId;
  final int? serviceType;

  const ControlEventEntity({
    this.id,
    this.followUpDateTime,
    this.actionType,
    this.authorType,
    this.authorId,
    this.authorFullName,
    this.sourceType,
    this.resultStatusId,
    this.resultStatusTitle,
    this.description,
    this.isDeleted,
    this.followUpDateJalali,
    this.followUpTime,
    this.actionTypeName,
    this.actionTypeTitle,
    this.authorTypeName,
    this.authorTypeTitle,
    this.sourceTypeName,
    this.sourceTypeTitle,
    this.insertDateTime,
    this.serviceRequestId,
    this.serviceType,
  });

  ControlEventEntity copyWith({
    int? id,
    String? followUpDateTime,
    int? actionType,
    int? authorType,
    int? authorId,
    String? authorFullName,
    int? sourceType,
    int? resultStatusId,
    String? resultStatusTitle,
    String? description,
    bool? isDeleted,
    String? followUpDateJalali,
    String? followUpTime,
    String? actionTypeName,
    String? actionTypeTitle,
    String? authorTypeName,
    String? authorTypeTitle,
    String? sourceTypeName,
    String? sourceTypeTitle,
    String? insertDateTime,
    int? serviceRequestId,
    int? serviceType,
  }) {
    return ControlEventEntity(
      id: id ?? this.id,
      followUpDateTime: followUpDateTime ?? this.followUpDateTime,
      actionType: actionType ?? this.actionType,
      authorType: authorType ?? this.authorType,
      authorId: authorId ?? this.authorId,
      authorFullName: authorFullName ?? this.authorFullName,
      sourceType: sourceType ?? this.sourceType,
      resultStatusId: resultStatusId ?? this.resultStatusId,
      resultStatusTitle: resultStatusTitle ?? this.resultStatusTitle,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
      followUpDateJalali: followUpDateJalali ?? this.followUpDateJalali,
      followUpTime: followUpTime ?? this.followUpTime,
      actionTypeName: actionTypeName ?? this.actionTypeName,
      actionTypeTitle: actionTypeTitle ?? this.actionTypeTitle,
      authorTypeName: authorTypeName ?? this.authorTypeName,
      authorTypeTitle: authorTypeTitle ?? this.authorTypeTitle,
      sourceTypeName: sourceTypeName ?? this.sourceTypeName,
      sourceTypeTitle: sourceTypeTitle ?? this.sourceTypeTitle,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  ControlEventModel toModel() => ControlEventModel(
    id: id,
    followUpDateTime: followUpDateTime,
    actionType: actionType,
    authorType: authorType,
    authorId: authorId,
    authorFullName: authorFullName,
    sourceType: sourceType,
    resultStatusId: resultStatusId,
    resultStatusTitle: resultStatusTitle,
    description: description,
    isDeleted: isDeleted,
    followUpDateJalali: followUpDateJalali,
    followUpTime: followUpTime,
    actionTypeName: actionTypeName,
    actionTypeTitle: actionTypeTitle,
    authorTypeName: authorTypeName,
    authorTypeTitle: authorTypeTitle,
    sourceTypeName: sourceTypeName,
    sourceTypeTitle: sourceTypeTitle,
    insertDateTime: insertDateTime,
    serviceRequestId: serviceRequestId,
    serviceType: serviceType,
  );
}
