
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_response_entity.dart';

class PartMarkResponseModel extends PartMarkResponseEntity {
  PartMarkResponseModel({
    super.mark
  });

  factory PartMarkResponseModel.fromJson(Map<String, dynamic> json) {
    return PartMarkResponseModel(
      mark: json["mark"],
    );
  }
}
