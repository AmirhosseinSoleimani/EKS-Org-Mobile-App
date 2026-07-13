import '../../domain/entities/plan_cancelation_entity.dart';

class PlanCancelationModel extends PlanCancelationEntity {
  const PlanCancelationModel({
    required super.shouldCancel,
    required super.requests,
  });

  factory PlanCancelationModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const PlanCancelationModel(shouldCancel: false, requests: []);
    }

    final rawRequests = json['requests'];
    return PlanCancelationModel(
      shouldCancel: json['shouldCancel'] ?? false,
      requests: rawRequests is List
          ? rawRequests
              .map((item) => PlanCancelationRequestModel.fromJson(
                    item as Map<String, dynamic>?,
                  ))
              .toList()
          : const [],
    );
  }
}

class PlanCancelationRequestModel extends PlanCancelationRequestEntity {
  const PlanCancelationRequestModel({
    super.id,
    super.trackCode,
    super.serviceType,
    super.serviceTypeTitle,
  });

  factory PlanCancelationRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PlanCancelationRequestModel();

    return PlanCancelationRequestModel(
      id: json['id'],
      trackCode: json['trackCode'],
      serviceType: json['serviceType'],
      serviceTypeTitle: json['serviceTypeTitle'],
    );
  }
}
