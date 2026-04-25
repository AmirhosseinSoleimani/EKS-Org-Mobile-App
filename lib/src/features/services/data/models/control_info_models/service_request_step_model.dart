import 'package:eks_sana_plus_org/src/features/services/domain/entities/control_info_entities/service_request_step_entity.dart';

class ServiceRequestStepModel extends ServiceRequestStepEntity {
  ServiceRequestStepModel({
    super.dateTime,
    super.authorId,
    super.authorFullname,
    super.time,
    super.dateJalali,
  });

  factory ServiceRequestStepModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestStepModel(
      dateTime: json['dateTime'],
      authorId: json['authorId'],
      authorFullname: json['authorFullname'],
      time: json['time'],
      dateJalali: json['dateJalali'],
    );
  }
}
