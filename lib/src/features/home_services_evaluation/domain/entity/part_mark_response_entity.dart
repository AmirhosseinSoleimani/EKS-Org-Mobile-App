import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/part_mark_response_model.dart';

class PartMarkResponseEntity {
  final String? mark;

  PartMarkResponseModel toModel() {
    return PartMarkResponseModel(mark: mark);
  }

  PartMarkResponseModel copyWith({String? mark}) {
    return PartMarkResponseModel(mark: mark ?? this.mark);
  }

  const PartMarkResponseEntity({this.mark});
}
