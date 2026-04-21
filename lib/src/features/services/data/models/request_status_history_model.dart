import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';


class RequestStatusHistoryItemModel extends RequestStatusHistoryItemEntity {
  const RequestStatusHistoryItemModel({
    super.id,
    super.description,
    super.insertUserName,
    super.refId,
    super.title,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.insertTime,
    super.serviceRequestId,
    super.serviceType,
  });

  factory RequestStatusHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return RequestStatusHistoryItemModel(
      id: json['id'],
      description: json['description'],
      insertUserName: json['insertUserName'],
      refId: json['refId'],
      title: json['title'],
      insertDateTime: json['insertDateTime'],
      insertDateTimeJalali: json['insertDateTimeJalali'],
      insertTime: json['insertTime'],
      serviceRequestId: json['serviceRequestId'],
      serviceType: json['serviceType'],
    );
  }
}

class RequestStatusHistoryListModel extends RequestStatusHistoryListEntity {
  const RequestStatusHistoryListModel({
    required super.records,
    required super.count,
  });

  factory RequestStatusHistoryListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return RequestStatusHistoryListModel(
      records: (data['records'] as List)
          .map((e) => RequestStatusHistoryItemModel.fromJson(e))
          .toList(),
      count: data['count'] ?? 0,
    );
  }
}
