
import '../../data/models/urgent_request_model.dart';

class UrgentRequestEntity {
  String? message;

  UrgentRequestModel toModel() {
    return UrgentRequestModel(message: message);
  }

  UrgentRequestEntity({this.message});
}
