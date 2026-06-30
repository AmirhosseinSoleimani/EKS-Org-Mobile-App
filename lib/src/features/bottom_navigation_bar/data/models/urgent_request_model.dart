
import 'package:eks_sana_plus_org/src/features/bottom_navigation_bar/domain/entiteis/urgent_request_entity.dart';

class UrgentRequestModel extends UrgentRequestEntity {
  UrgentRequestModel({super.message});

  UrgentRequestModel.fromJson(dynamic json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
