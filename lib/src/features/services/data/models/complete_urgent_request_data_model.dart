import 'package:eks_sana_plus_org/src/features/services/domain/entities/complete_urgent_request_data_entity.dart';

class CompleteUrgentRequestDataModel extends CompleteUrgentRequestDataEntity {
  const CompleteUrgentRequestDataModel({
    super.message,
    super.subscription,
    super.guaranty,
  });

  factory CompleteUrgentRequestDataModel.fromJson(Map<String, dynamic> json) {
    return CompleteUrgentRequestDataModel(
      message: json['message'],
      subscription: json['subscription'],
      guaranty: json['guaranty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'subscription': subscription,
      'guaranty': guaranty,
    };
  }
}
