import 'package:eks_sana_plus_org/src/features/requests/data/models/cancel_reason_model.dart';

class CancelReasonEntity {
  final int? id;
  final String? title;

  const CancelReasonEntity({this.id, this.title});

  CancelReasonModel toModel() => CancelReasonModel(id: id, title: title);

  CancelReasonEntity copyWith({
    int? id,
    String? title,
  }) {
    return CancelReasonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
