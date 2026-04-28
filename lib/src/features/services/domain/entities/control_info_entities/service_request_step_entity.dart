
import 'package:eks_sana_plus_org/src/features/services/data/models/control_info_models/service_request_step_model.dart';

class ServiceRequestStepEntity {
  final String? dateTime;
  final int? authorId;
  final String? authorFullname;
  final String? time;
  final String? dateJalali;

  const ServiceRequestStepEntity({
    this.dateTime,
    this.authorId,
    this.authorFullname,
    this.time,
    this.dateJalali,
  });

  ServiceRequestStepEntity copyWith({
    String? dateTime,
    int? authorId,
    String? authorFullname,
    String? time,
    String? dateJalali,
  }) {
    return ServiceRequestStepEntity(
      dateTime: dateTime ?? this.dateTime,
      authorId: authorId ?? this.authorId,
      authorFullname: authorFullname ?? this.authorFullname,
      time: time ?? this.time,
      dateJalali: dateJalali ?? this.dateJalali,
    );
  }

  ServiceRequestStepModel toModel() {
    return ServiceRequestStepModel(
      dateTime: dateTime,
      authorId: authorId,
      authorFullname: authorFullname,
      time: time,
      dateJalali: dateJalali,
    );
  }
}
