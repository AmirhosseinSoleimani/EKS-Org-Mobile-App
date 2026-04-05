import 'package:eks_sana_plus_org/src/features/requests/domain/entities/cancel_reasons_entity.dart';

class CancelReasonModel extends CancelReasonEntity {
  const CancelReasonModel({super.id, super.title});

  factory CancelReasonModel.fromJson(Map<String, dynamic> json) {
    return CancelReasonModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
    );
  }

  @override
  CancelReasonModel copyWith({
    int? id,
    String? title,
  }) {
    return CancelReasonModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
