import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_reason_entity.dart';

class LeaveReasonModel extends LeaveReasonEntity {
  const LeaveReasonModel({
    super.id,
    super.title,
    super.secondaryReasons = const [],
  });

  factory LeaveReasonModel.fromJson(Map<String, dynamic> json) {
    return LeaveReasonModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      secondaryReasons: (json['secondaryReasons'] as List<dynamic>?)
              ?.map(
                (item) => LeaveReasonModel.fromJson(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'secondaryReasons': secondaryReasons
          .map((reason) => reason.toModel().toJson())
          .toList(),
    };
  }
}

