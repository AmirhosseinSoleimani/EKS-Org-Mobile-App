import 'package:eks_sana_plus_org/src/features/services/data/models/request_status_history_model.dart';

class RequestStatusHistoryItemEntity {
  final int? id;
  final String? description;
  final String? insertUserName;
  final int? refId;
  final String? title;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? insertTime;
  final int? serviceRequestId;
  final int? serviceType;

  const RequestStatusHistoryItemEntity({
    this.id,
    this.description,
    this.insertUserName,
    this.refId,
    this.title,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.insertTime,
    this.serviceRequestId,
    this.serviceType,
  });

  RequestStatusHistoryItemEntity copyWith({
    int? id,
    String? description,
    String? insertUserName,
    int? refId,
    String? title,
    String? insertDateTime,
    String? insertDateTimeJalali,
    String? insertTime,
    int? serviceRequestId,
    int? serviceType,
  }) {
    return RequestStatusHistoryItemEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      insertUserName: insertUserName ?? this.insertUserName,
      refId: refId ?? this.refId,
      title: title ?? this.title,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      insertTime: insertTime ?? this.insertTime,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  RequestStatusHistoryItemModel toModel() {
    return RequestStatusHistoryItemModel(
      id: id,
      description: description,
      insertUserName: insertUserName,
      refId: refId,
      title: title,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      insertTime: insertTime,
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
    );
  }
}

class RequestStatusHistoryListEntity {
  final List<RequestStatusHistoryItemEntity> records;
  final int count;

  const RequestStatusHistoryListEntity({
    required this.records,
    required this.count,
  });

  RequestStatusHistoryListEntity copyWith({
    List<RequestStatusHistoryItemEntity>? records,
    int? count,
  }) {
    return RequestStatusHistoryListEntity(
      records: records ?? this.records,
      count: count ?? this.count,
    );
  }

  RequestStatusHistoryListModel toModel() {
    return RequestStatusHistoryListModel(
      records: records.map((e) => e.toModel()).toList(),
      count: count,
    );
  }
}
