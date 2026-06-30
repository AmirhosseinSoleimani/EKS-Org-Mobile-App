import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';

class PartMarkModel extends PartMarkEntity {
  const PartMarkModel({super.mark, super.allowIllegalMarkReason});

  factory PartMarkModel.fromJson(Map<String, dynamic> json) {
    return PartMarkModel(
      mark: json['mark'],
      allowIllegalMarkReason: json['allowIllegalMarkReason'],
    );
  }
}
