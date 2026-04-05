
import 'package:eks_sana_plus_org/src/shared/features/user/data/models/job_response_model.dart';

class JobResponseEntity {
  final String? title;
  final int? id;

  const JobResponseEntity({
    this.title,
    this.id,
  });

  JobResponseModel toModel() {
    return JobResponseModel(
      title: title,
      id: id,
    );
  }
}

