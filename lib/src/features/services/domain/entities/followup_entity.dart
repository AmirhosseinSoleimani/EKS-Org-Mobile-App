import 'package:eks_sana_plus_org/src/features/services/data/models/Followup_Model.dart';

class FollowupEntity {
  final List<FollowupItemEntity>? followUpList;

  const FollowupEntity({this.followUpList});

  FollowupModel toModel() => FollowupModel(
    followUpList: followUpList?.map((part) => part.toModel()).toList(),
  );
}

class FollowupItemEntity {
  final int? id;
  final String? followUpDateTime;
  final int? actionType;
  final int? authorType;
  final int? authorId;
  final String? authorFullName;
  final int? sourceType;
  final int? resultStatusId;
  final String? resultStatusTitle;
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
  final String? insertDateTimeJalali;
  final String? insertTime;
  final int? serviceRequestId;
  final int? serviceType;
  final String? description;

  const FollowupItemEntity({
    this.id,
    this.followUpDateTime,
    this.actionType,
    this.authorType,
    this.authorId,
    this.authorFullName,
    this.sourceType,
    this.resultStatusId,
    this.resultStatusTitle,
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
    this.insertDateTimeJalali,
    this.insertTime,
    this.serviceRequestId,
    this.serviceType,
    this.description,
  });

  FollowupItemEntity copyWith({
    int? id,
    String? followUpDateTime,
    int? actionType,
    int? authorType,
    int? authorId,
    String? authorFullName,
    int? sourceType,
    int? resultStatusId,
    String? resultStatusTitle,
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
    String? insertDateTimeJalali,
    String? insertTime,
    String? description,
    int? serviceRequestId,
    int? serviceType,
  }) {
    return FollowupItemEntity(
      id: id ?? this.id,
      followUpDateTime: followUpDateTime ?? this.followUpDateTime,
      actionType: actionType ?? this.actionType,
      authorType: authorType ?? this.authorType,
      authorId: authorId ?? this.authorId,
      authorFullName: authorFullName ?? this.authorFullName,
      sourceType: sourceType ?? this.sourceType,
      resultStatusId: resultStatusId ?? this.resultStatusId,
      resultStatusTitle: resultStatusTitle ?? this.resultStatusTitle,
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
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      insertTime: insertTime ?? this.insertTime,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      description: description ?? this.description,
    );
  }

  FollowupItemModel toModel() => FollowupItemModel(
    id: id,
    followUpDateTime: followUpDateTime,
    actionType: actionType,
    authorType: authorType,
    authorId: authorId,
    authorFullName: authorFullName,
    sourceType: sourceType,
    resultStatusId: resultStatusId,
    resultStatusTitle: resultStatusTitle,
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
    insertDateTimeJalali: insertDateTimeJalali,
    insertTime: insertTime,
    serviceRequestId: serviceRequestId,
    serviceType: serviceType,
    description: description,
  );
}
