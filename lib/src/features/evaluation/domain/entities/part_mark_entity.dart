import 'package:eks_sana_plus_org/src/features/evaluation/data/models/part_mark_model.dart';

class PartMarkEntity {
  final String? mark;
  final int? allowIllegalMarkReason;

  const PartMarkEntity({this.mark, this.allowIllegalMarkReason});

  PartMarkModel toModel() {
    return PartMarkModel(
      mark: mark,
      allowIllegalMarkReason: allowIllegalMarkReason,
    );
  }

  PartMarkEntity copyWith({String? mark, int? allowIllegalMarkReason}) {
    return PartMarkEntity(
      mark: mark ?? this.mark,
      allowIllegalMarkReason:
          allowIllegalMarkReason ?? this.allowIllegalMarkReason,
    );
  }
}
