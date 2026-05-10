import 'package:eks_sana_plus_org/src/features/services/data/models/complete_urgent_request_data_model.dart';

class CompleteUrgentRequestDataEntity {
  final String? message;
  final bool? subscription;
  final bool? guaranty;

  const CompleteUrgentRequestDataEntity({
    this.message,
    this.subscription,
    this.guaranty,
  });

  CompleteUrgentRequestDataEntity copyWith({
    String? message,
    bool? subscription,
    bool? guaranty,
  }) {
    return CompleteUrgentRequestDataEntity(
      message: message ?? this.message,
      subscription: subscription ?? this.subscription,
      guaranty: guaranty ?? this.guaranty,
    );
  }

  CompleteUrgentRequestDataModel toModel() {
    return CompleteUrgentRequestDataModel(
      message: message,
      subscription: subscription,
      guaranty: guaranty,
    );
  }
}
