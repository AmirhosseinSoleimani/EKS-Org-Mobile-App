import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/job_response_entity.dart';

class JobResponseModel extends JobResponseEntity {
  JobResponseModel({
    super.title,
    super.id,
  });

  factory JobResponseModel.fromJson(Map<String, dynamic> json) {
    return JobResponseModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
