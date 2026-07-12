import 'package:eks_sana_plus_org/src/features/leave/data/models/leave_reason_model.dart';

class LeaveReasonEntity {
  const LeaveReasonEntity({
    this.id,
    this.title,
    this.secondaryReasons = const [],
  });

  final int? id;
  final String? title;
  final List<LeaveReasonEntity> secondaryReasons;

  LeaveReasonModel toModel() {
    return LeaveReasonModel(
      id: id,
      title: title,
      secondaryReasons:
          secondaryReasons.map((reason) => reason.toModel()).toList(),
    );
  }
}

